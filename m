Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB39CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:44:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB3D206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ITK+B8Sm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v73vkarh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB3D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=botPpGea0e5/lKl8BG7Mvx4QkerPVypAcI0Cb8Vy8v4=; b=ITK+B8Smp8jaL8
	5bpw80FIY6hnsdK7F73iiUKbZQwc7jR7Vgd1Px6Aebm/vFFy+poY80Jcc9T2gzcuYcHnyusFgSJlz
	zh3pItDj5Ek4QNqfzSJjSeE1pMeF++a9R2IDzlVsYqN+otYgHFoisqW4ZR7PgF3LJEGlKtvtEZN+8
	keGAAm91a2SLHktAHa9gCAT5y6ee/4ad24MZaSuvWGVNPod6TzPVgmR0lavI/5sYvGjj2AlIv+nkh
	9qcbrChYKsT3t8kMzpitX7T7/eLJN2rdQEZvpyFnbWtsWVR1GzP+d/ObESxmAmW3wpQxijZLKQOOU
	xusICodCfGWIpD7+Pjpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvCd-00029t-94; Thu, 21 Feb 2019 20:44:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvCS-0001yp-6p
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:44:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C68D0206C0;
 Thu, 21 Feb 2019 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550781847;
 bh=CZc1PLgDJqZGD7Q3WsEIWVR483enxgPNJEwBJnuY+TY=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=v73vkarhP7gMaHTbqyBkO9axVdbySe45pnFhVA3DKDnZSoYDV9V7sp4zqUtJd97TP
 LLXi5Hfy2Jv5PjeX9hIFnec5QjHOAi7RzpbLjH5uWHHKIwyUyzp0b+IFmPwKBvsCzS
 HJL/5ZEv0aCHR6C5DuOVuKI1XU2AWM9Gg26ZgUB4=
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] clk: imx: imx8mq: Fix the rate propagation for arm
 pll
Message-ID: <155078184707.77512.8417233736352965273@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
 <1550252913-24532-2-git-send-email-abel.vesa@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550252913-24532-2-git-send-email-abel.vesa@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, Angus Ainslie <angus.ainslie@puri.sm>,
 Lucas Stach <l.stach@pengutronix.de>, Mike Turquette <mturquette@baylibre.com>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Date: Thu, 21 Feb 2019 12:44:07 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_124408_752939_EAC54D01 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-02-15 09:48:43)
> The arm pll bypass needs to propagate the rate upwards
> in order for the cpufreq to work.
> 
> Fixes: b80522040cd3f ("clk: imx: Add clock driver for i.MX8MQ CCM")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
