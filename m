Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6259C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:56:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5EB20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f4EMsjnY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+wVc50Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5EB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dc1X+vn9UM6EFpano5KMT70Wj9Ge/qiGHKxRidVkGX8=; b=f4EMsjnY+yj1FB
	nRv1Xu5BNKmTADZqwc6uqYfpwFzsW2y1zmxOjpoa7V+OpJr+t8YIvhtKPAJgFu+P8v6XIE1Mp9vyI
	jS8U3HAImLH5wTK+j0owoRCO7FiQSOUYv4lnsYyQQeg6XIEHhA6wf8/rNLcXhW/jTow1/8UXH9UW6
	+6SNH1Sp8WQBVee65tNTrO/1BdrOS/kAbXhtoXU5mwfQREZWN8ZeDs45xjMazeFw29JGT1IX7k0Eo
	Cf1628fO902fxRi3AUUSy62fnR19OQZkZIvalew0aNgnPsyzd1LNh4f1QHxDPNWd6KvRb3ZVhcHQG
	ojScIUSaXldO/b+L5jLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGEf-0006uG-DE; Thu, 13 Dec 2018 01:56:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGEb-0006tt-Vs
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:56:19 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C19F20811;
 Thu, 13 Dec 2018 01:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544666167;
 bh=MHR2MOcqgBaXBQwT/scBcjfoGa0nz9f4p5JtJlyVVV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B+wVc50YxzOgJoSPQlFGiSI18JpA6Dpm7B0B8V1sFgs1Gl5h114cvrlYRKJcgNS+W
 FTJjg8fJy4Ydmm3RQT8evlsmW0JKsXCg7zE0vov93SkXds2xnky733X/VjuyL7aF6R
 B2rz9EFvZSp0yFn44fbrrobA5RY3kgCilif+xSTI=
Date: Thu, 13 Dec 2018 09:55:11 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Message-ID: <20181213015509.GA11997@dragon>
References: <1544647253-3806-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544647253-3806-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_175618_050824_7FECD9CE 
X-CRM114-Status: GOOD (  18.86  )
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 06:40:53PM -0200, Fabio Estevam wrote:
> eukrea-tlv320.c machine driver runs on non-DT platforms
> and include <asm/mach-types.h> header file in order to be able
> to use some machine_is_eukrea_xxx() macros.
> 
> Since commit 0e1532bfecf4 ("arm64: add basic Kconfig symbols for i.MX8")
> the ARCH_MXC symbol is visible on ARM64 too.
> 
> Building it for ARM64 causes the following build error:
> 
> sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
> 
> Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
> driver when ARM64 is selected.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Hi Mark,
> 
> Commit commit 0e1532bfecf4 ("arm64: add basic Kconfig symbols for i.MX8")
> is present in Shawn's tree, so maybe this should be taken by Shawn?

I would suggest you drop the mentioning of the commit from your commit
log, so that Mark can take the patch as a preparation for i.MX8 landing.

Shawn

> 
>  sound/soc/fsl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 6ec19fb..2e75b5b 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97
>  
>  config SND_SOC_EUKREA_TLV320
>  	tristate "Eukrea TLV320"
> -	depends on ARCH_MXC && I2C
> +	depends on ARCH_MXC && !ARM64 && I2C
>  	select SND_SOC_TLV320AIC23_I2C
>  	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_SSI
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
