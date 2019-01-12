Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C30C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:29:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518E420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sr+5yd5m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOmH5y9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518E420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pnViJ4GcG0QKdavMr88c/CdeiuzUkZreIJUmO976yYw=; b=Sr+5yd5movYc5X
	O3l4rv50nc8rRVGvWSWQL2D4JLDf8bzfYAB9PeqU/OUyL1SshhqhmQWriT3rkLRWekiwMfwH6BNID
	wm9qg+UT2CQlDf/O1GkUKJdVl3gRmKQ106SdQOlzRCNWtwyyRHrntpsMNIytL4sMw4C/6afjDQSQe
	Knei5pe8HrdXjqE9cACKVEpB8fnHYaqBppu9PDknI3dEsISzhHmeVAKrTA05z2c2l68uwT/rcmex/
	ZEuiSXSXI5girkCoQdISHHHotr4s6V7GQRlxWVVGO5OOfwDXQMjXM15onw7DlldgGmLReKDuCS2Ou
	DgnSUNdHcBq7cU+1QkHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi92u-0006p3-V1; Sat, 12 Jan 2019 02:29:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi92s-0006oi-35
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 02:29:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C836320870;
 Sat, 12 Jan 2019 02:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547260149;
 bh=rEDCBZjo/ENkRtN96vNDuYB78NtoZgMQINLim7UVwpA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lOmH5y9QEo7Fbm3bGTAaiDrWEkCqjNIcljzd0zmScGR+Ogym8OQxGuAmvaWZmt+Qb
 eIfXVwaPDmV7Ft6xLfS2LXaN5e2n7UUVH8oBAVKoNMRxIrzclV79bvaCDaim/ZZVyo
 OZYNXXIhxM/ysNSsjwc4xym12v0tYUCsxWjBQvRU=
Date: Sat, 12 Jan 2019 10:28:58 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH] ARM: dts: imx51: Add default bus-width property for esdhc1
Message-ID: <20190112022856.GM32649@dragon>
References: <20181219190734.23331-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181219190734.23331-1-shc_work@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_182910_169037_B3F2A4C9 
X-CRM114-Status: GOOD (  17.09  )
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
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 10:07:34PM +0300, Alexander Shiyan wrote:
> This patch adds bus-width property for esdhc1 to avoid mmc
> core warning: "bus-width" property is missing, assuming 1 bit.
> Additionally, the patch removes this property for boards where
> 4-bit width is already specified, and adds 1-bit width for
> boards where this property is omitted.

I suspect that even boards omitting the property support more than just
1-bit.  The warning is a good reminder for board maintainers/users  to
check the bus-width.

Shawn

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx51-apf51dev.dts                   | 1 -
>  arch/arm/boot/dts/imx51-babbage.dts                    | 1 +
>  arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 1 +
>  arch/arm/boot/dts/imx51-ts4800.dts                     | 1 +
>  arch/arm/boot/dts/imx51-zii-rdu1.dts                   | 1 -
>  arch/arm/boot/dts/imx51.dtsi                           | 1 +
>  6 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
> index 3e1846a..b26d92f 100644
> --- a/arch/arm/boot/dts/imx51-apf51dev.dts
> +++ b/arch/arm/boot/dts/imx51-apf51dev.dts
> @@ -97,7 +97,6 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
>  	cd-gpios = <&gpio2 29 GPIO_ACTIVE_LOW>;
> -	bus-width = <4>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 35ee1b4..8e86116 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -322,6 +322,7 @@
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> +	bus-width = <1>;
>  	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>  	wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> index e9e819f..f2c3c87 100644
> --- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> +++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> @@ -101,6 +101,7 @@
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1 &pinctrl_esdhc1_cd>;
> +	bus-width = <1>;
>  	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
> index 39eb067..e6d25a5 100644
> --- a/arch/arm/boot/dts/imx51-ts4800.dts
> +++ b/arch/arm/boot/dts/imx51-ts4800.dts
> @@ -82,6 +82,7 @@
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> +	bus-width = <1>;
>  	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>  	wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 69d753c..1287b57 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -459,7 +459,6 @@
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> -	bus-width = <4>;
>  	no-1-8-v;
>  	non-removable;
>  	no-sdio;
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 67d4627..eac432a 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -172,6 +172,7 @@
>  						 <&clks IMX5_CLK_DUMMY>,
>  						 <&clks IMX5_CLK_ESDHC1_PER_GATE>;
>  					clock-names = "ipg", "ahb", "per";
> +					bus-width = <4>;
>  					status = "disabled";
>  				};
>  
> -- 
> 2.10.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
