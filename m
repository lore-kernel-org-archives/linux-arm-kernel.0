Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CA3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 08:09:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F37206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 08:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nzvo18EZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJxc3CVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F37206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8gIp/2zWr7LbQ+pvcF6wAC6BKkjbPL+wqclJJrH74is=; b=Nzvo18EZepv3Si
	fGX3H8KWF5nkUpoJpuaJXoi8i+gpKHxQOK77WTxjUx91A33HZ9UTqE0SmA8OKfN0XRNQO1CYnRX6p
	8cX/colx0+SINGcAGmzDhLEjWNLTdGAhUXIur3+24zH4UJ0bi7xL4UyoUbgixXi5dR+KWN56IYU1I
	Jv0XIKVFluRwB8t9hUDWEPIYrrOf2muqd8dAiYqqbi/YbJfMzOCpP9ydCntEEW8GOxRExnF7fUWHq
	4eA98NjRozzr+XAlCICt/wqnUOLr8GyXPNT3K24EV14tIXJ0BRPxF3dFAFKqgad3Y19QCljLHycjs
	66qWUP98BqgaJ8zFK/Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYRUI-0000ls-OR; Sun, 16 Dec 2018 08:09:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYRUE-0000lJ-V4
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 08:09:20 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47590206C2;
 Sun, 16 Dec 2018 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544947747;
 bh=d0/5TH24wtdCdiW+nhl9ZI4VMTTkejbYQlOcU5ApVfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MJxc3CVGv/f5CbviIF965xB/iy6t0DqOyxtFh3p5XiImKnHmJOyb4iOF/3PCy8kc6
 eIdwdCWlp2NC39v9Ii/Jbq7LhVNGom8YuRZnCuHfeV2Tl9Dyl0wYaDA4gy4H/N7PJz
 azPhHyk6kzWY5lw3IbkY/lq4toK99Os7oXkQJ6t4=
Date: Sun, 16 Dec 2018 16:08:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/1] pinctrl: imx8qxp: break the dependency on SOC_IMX8QXP
Message-ID: <20181216080800.GI13243@dragon>
References: <1544781567-18040-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544781567-18040-1-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_000919_018757_E412FCBB 
X-CRM114-Status: UNSURE (   9.99  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "stefan@agner.ch" <stefan@agner.ch>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:04:50AM +0000, Aisheng Dong wrote:
> ARM64 SoC does not encourage people to add more finegrained SoC
> config options rather than a single ARCH_<family> in arch Kconfig.
> So this patch aims to break the dependency on SOC_IMX8QXP which
> will be removed later.

Option SOC_IMX8QXP hasn't hit mainline, so the removal of the option is
only about updating your platform series under reviewing.  That said, we
do not really need to mention that in the commit log.  Otherwise,

Acked-by: Shawn Guo <shawnguo@kernel.org>

> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
