Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347F1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:23:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B5620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHKAQkOF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N45Z2TRq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N45Z2TRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B5620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JGScfm1E16a+HIoSR8ggOz/6Ti5wAfD1VbqcJQdfVN0=; b=LHKAQkOFiWitrbw3ygKJa28ig
	gdVgT2WsvXB4lH9jzuQx3RHkYp+2aSFjajpdRtp0aDaRJ+Mvb1E1+uSTSmQ4bRT3j26elcPxtFT/e
	qe2KGGsO+/S94t10nNZAKcoEbJP/mn22nJXwUprdR1U7sDudaxX348lLQRGqfCeNq03JeU971HSw7
	GsSLmn/ORRbu4H0TctlhmR6PoVmxgZEjKr16/cCOjglpiVjrqn6p7tm/h504axwr8EmU2RZbqXkXd
	CpqLJY0YF/ir4m6jKFCikOP1Api8E80eN1p8J5Cs82pSjEA4H8vYR5Hcvzwr2KcXZG6+FDvhnzeeb
	52aLALnaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLio-0006vZ-1F; Fri, 07 Dec 2018 19:23:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLik-0006sZ-Lr
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:23:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id CF62260C48; Fri,  7 Dec 2018 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544210599;
 bh=wZ29aAim5MgQ9AWMPAJST6ubLLYEq0ylEKTLCgrNLHI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=N45Z2TRqqbhm5w/7CgDJOb9W227OpFWXlGnM0AcKTzmfpzVsJDzDNZoZ5pXp5lI5F
 PoIqCAOEv98VWRk2DX+UCWfYbAq0F3nGZ+ry8E2DRhTvcL56aOrPrJ3W5V4YzhwSq5
 78BDNrwf921F8nma2jyk023gCHk3AA0eKh29mhio=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E83EC609F3;
 Fri,  7 Dec 2018 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544210599;
 bh=wZ29aAim5MgQ9AWMPAJST6ubLLYEq0ylEKTLCgrNLHI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=N45Z2TRqqbhm5w/7CgDJOb9W227OpFWXlGnM0AcKTzmfpzVsJDzDNZoZ5pXp5lI5F
 PoIqCAOEv98VWRk2DX+UCWfYbAq0F3nGZ+ry8E2DRhTvcL56aOrPrJ3W5V4YzhwSq5
 78BDNrwf921F8nma2jyk023gCHk3AA0eKh29mhio=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E83EC609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [Patch v2] arm: dts: qcom: msm8998: Fixup clock to use xo_board
To: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org
References: <1544209088-25602-1-git-send-email-andy.gross@linaro.org>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <6f92d0bc-1e0d-0cdb-6af0-0856f18041f0@codeaurora.org>
Date: Fri, 7 Dec 2018 12:23:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1544209088-25602-1-git-send-email-andy.gross@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_112330_731226_34D9F02E 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/2018 11:58 AM, Andy Gross wrote:
> This patch sets the msm8998 xo clock name back to xo_board.  Recent
> clock tree changes fixed the clock tree and the change to the xo name
> is causing issues where msm8998 boards do not boot properly.  Let's
> change it back and leave the xo label on it.
> 
> Fixes: 634da3307b08 (arm64: dts: qcom: msm8998: correct xo clock name)
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Looks good to me.  Seems fine according to a quick test.  Feel free to 
put on a reviewed-by, acked, or whatever tag you'd like to have from me.
-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
