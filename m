Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A418C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:06:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052DE217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qlEfy7NK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nZXTbd1g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mZFTnvEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052DE217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSsuOa8yOrlbsJgZfOr5S5KUdtnNSylX9SGe2miOVr8=; b=qlEfy7NKhYTSDW
	yMGzR++rZT56Mjl7UaNeB12kjzd4H9L2YKnidBZzKEYvFOVlREQKt3BzSpnaxS/3n6fU7HDJaf9us
	wRUMcCE5L0TRQ6LxxtGGDIZOJHkxaXk1NzyPmGjooXo6RrfFgj8iGhgFrtidy9CBBv9HjZLDCBosx
	/JSjGa2CBAL0ISExwRzgO8u2u3+q/6D8puZDZM0wRNsVmidohFgNjChshqvKJlOF9PMMADwIj6nal
	NY1BO8luJWJlzio4UjOkxdeNCsLaoYudnzvZMq1kwrvUdUPwhOkz4BC45b6MrUBVi+pmGvbfA195N
	Gx0xZJBNpfN8m/1Bwyzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZORq-0007qh-AH; Tue, 18 Dec 2018 23:06:46 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZORn-0007pg-0r
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 23:06:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 6149B607CA; Tue, 18 Dec 2018 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545174392;
 bh=4VVac61vewyIoUzbGR84HZBRvv1588mVKcbDfi5Pel0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nZXTbd1gjZjYgHxP0ZFaOO0gjabKaa6aROI8vA5WJlHwY3mB1ArZlWphc5M+LrRZr
 5Lg/YXjb8TTRkfolDfm7dFVL+y0g1HzkJtuD9fAf4WAFAVv8Of8cHYUa1l1O1gwBCZ
 JEcwyNu4+8m72Lsd5CZ+6/2mzBfIOWiUPFKEUFnE=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A93BF601C3;
 Tue, 18 Dec 2018 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545174391;
 bh=4VVac61vewyIoUzbGR84HZBRvv1588mVKcbDfi5Pel0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mZFTnvEx5bfx65CovOFtZWSXLFlHqemzWkoeIAijER3eYklpINl7HZ/EpCmymmeMO
 KrbgEys47XiJnyv74L9/tZwq1tS+DaamHUBAXpRI+jdgJWnjs96vWjf8Roi5gaP6io
 DGaZk7ME/zHPjWXBI4R77cBebr8Kqk6YoGPMXE6I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A93BF601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 18 Dec 2018 16:06:28 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 3/6] ARM: dts: qcom: Removed unused interrupt-names
 from GPU node
Message-ID: <20181218230628.GE18380@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, vireshk@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Georgi Djakov <georgi.djakov@linaro.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-4-jcrouse@codeaurora.org>
 <CAD=FV=Vi2bNCQ-A+h=1w9P15-XwCq7weZJ7LP7HBfs+GMTv=rA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vi2bNCQ-A+h=1w9P15-XwCq7weZJ7LP7HBfs+GMTv=rA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_150643_098132_7A788B29 
X-CRM114-Status: GOOD (  17.80  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 02:29:25PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Dec 18, 2018 at 10:32 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > 'interrupt-names' shouldn't be used in cases when there is only
> > one interrupt and it is not otherwise used in the driver.
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  arch/arm/boot/dts/qcom-apq8064.dtsi | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Looks good to me.  It should be noted that Andy shouldn't land this
> until he has a tree that contains ("drm/msm/gpu: Remove hardcoded
> interrupt name").  ...or he should Ack this and it should go through
> the same tree as that patch.
> 
> I'm curious: is there a reason you didn't remove it from the other two users?
> 
> linuxnext/master:arch/arm/boot/dts/imx51.dtsi:
> interrupt-names = "kgsl_3d0_irq";
> linuxnext/master:arch/arm/boot/dts/imx53.dtsi:
> interrupt-names = "kgsl_3d0_irq";

Because those aren't in Andy's tree. I suspect after all this lands we'll need
another sweep to clean up the extras. There is also a 8996 dt floating around
somewhere.

Jordan

> ...also: if this really is only for "apq8064" and not globally for all
> qcom devices it'd be nice to mention "apq8064" somewhere in the
> subject.

> -Doug

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
