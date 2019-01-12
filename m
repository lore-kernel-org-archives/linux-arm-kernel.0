Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:09:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527AA20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USDvVw7E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9ff5xGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527AA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ar0tdIgAcknirhgoyfOTenLycl5JG5oHqfRT+XUIBMI=; b=USDvVw7E+WkHho
	hW/8s2kTICXLZ/laFIQaubP+A06WWYA5JhfB4V7O9jic4glJka3NKJucq/+TLXVpe24ZNpCJBvvxg
	J4FgitShE3fXEOAIS6HWoj0KD340Ne4eWT4+SkS/5iYB0qJMbHGxfSYOyQ/Mm9f8yQgEt6BFBnWqB
	RTenoimpl340OHAbPro68aVngfEB98UeHaozQvHGq65SLUYuv5j4vKX1YamR7i19Qb1ToNLB2ekqQ
	g/5xqazshDmzwqfRLRodD/oxrttcTWD3n1rqDAlyx0qBcyV3uAq22XkuWLutGmbQX3c8PY/Zd05aU
	cjPrAlZCKS/kvcvsJBXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9fd-0003df-Hn; Sat, 12 Jan 2019 03:09:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9fa-0003dG-6O
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 03:09:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A92DD20870;
 Sat, 12 Jan 2019 03:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547262549;
 bh=V947eUaYNWpz7sWjMJJYpsFrc80edJpxpAix5tILRGA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s9ff5xGGnX9pi9P2SAimEl+7WRJCfBVda3YuXHywpC1nN8rGLlh1gyopvAzEbnKg5
 jgb5Waa0cR6u3qApkvC1Rq1HPKJUSBmO+EN9KiPvy+qOnLHiVeYD9QPyCW0bP9A25N
 VOAU3HoBjMFyjR8ZT+kjjWIY9SawVWdKmQydLdSA=
Date: Sat, 12 Jan 2019 11:08:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v2] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Message-ID: <20190112030854.GS32649@dragon>
References: <1545571216-655-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545571216-655-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_190910_306906_0726E56E 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 01:20:34PM +0000, Abel Vesa wrote:
> Since this is going to be used on more SoCs than just i.MX8MQ,
> make the dependency here more generic.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since v1:
>  * removed the SOC_IMX7D since it's included by ARCH_MXC

This should really be mentioned in the commit log.

Shawn

>    as suggested by Dong Aisheng.
> 
>  drivers/soc/imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index 2112d18..d80f899 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
>  
>  config IMX_GPCV2_PM_DOMAINS
>  	bool "i.MX GPCv2 PM domains"
> -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> +	depends on ARCH_MXC || (COMPILE_TEST && OF)
>  	depends on PM
>  	select PM_GENERIC_DOMAINS
>  	default y if SOC_IMX7D
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
