Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E11C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AED20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hXcZUXkZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHv+9uKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AED20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VrVbySfO5JHjLjP59hxYBDy7U0A8p6pUbfheEevSbrg=; b=hXcZUXkZb85kSK
	PFv8lpkpHfZAEtV/oiQbYpm0m4DbrPCeWjLd+SwJ05z9eGZyljUUudVOEx7OoXdOMm1PezrD3g0rh
	xddhh9GoUYHOvF5AtUS9Ay0qtUpAM15y4/fVuEIR3nEtDZQe4fGc6tU0Okaj0XBPjJgC+VX69WBDS
	Nth8cRAx8QB+rmOgSDeTwdUY6td/TRe9SDAnf5ToX7xGnj/D14wM0+jS1wDkKiwXg46gtR1Brw7iI
	PacjAkHH7qy8oOKtsYDIhelWfOjVMfE4I5TKPYElYbIsYLsGK3JbUkY/J0UEKlEi1Maj8G1FRwv77
	rCWqEDz0pl7k/SNuAl0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9sD-0000wr-N4; Sat, 12 Jan 2019 03:22:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9sB-0000wW-1t
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 03:22:12 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 283F620851;
 Sat, 12 Jan 2019 03:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547263330;
 bh=Y78ulpjyPypns/fbDe5hsNFE5RD38mam8UjgwZoE0Lg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sHv+9uKX3AXbYAJIs2MYxXAdLO2XK3mm1AEzsaDlGMEJWgOtmslzhZDqHCW9IdvGH
 x8X8iwRB7+qNkjS94kZc0zsVvwckjWlnD6MpGHBqlBamCwn7j97DQsV9vTrStLTILw
 CjAfgJRxMplapHWgpFBpFD8NvEn2w+V7JX157ouM=
Date: Sat, 12 Jan 2019 11:21:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 4/4] ARM: dts: imx6qdl-phytec-pfla02: Add some labels
Message-ID: <20190112032156.GA11426@dragon>
References: <20181223163141.6792-1-shc_work@mail.ru>
 <20181223163141.6792-4-shc_work@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181223163141.6792-4-shc_work@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_192211_115144_5412D8FB 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 07:31:41PM +0300, Alexander Shiyan wrote:
> This patch adds labels to devices that can be reused in top-level dts.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> index 81007d6..a685ff7 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -41,12 +41,12 @@
>  	gpio_leds: leds {
>  		compatible = "gpio-leds";
>  
> -		green {
> +		led_green: led_green {

We usually use hyphen than underscore in node name, so led-green for
node please.

>  			label = "phyflex:green";
>  			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
>  		};
>  
> -		red {
> +		led_red: led_red {

Ditto

>  			label = "phyflex:red";
>  			gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
>  		};
> @@ -71,7 +71,7 @@
>  	status = "okay";
>  	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
>  
> -	flash@0 {
> +	flash: flash@0 {

Please use a specific name for labelling, for example:

	m25p80: flash@0 {

>  		compatible = "m25p80", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> @@ -99,12 +99,12 @@
>  	pinctrl-0 = <&pinctrl_i2c1>;
>  	status = "okay";
>  
> -	eeprom@50 {
> +	eeprom: eeprom@50 {

Ditto

>  		compatible = "atmel,24c32";
>  		reg = <0x50>;
>  	};
>  
> -	pmic@58 {
> +	pmic: pmic@58 {

Ditto

Shawn

>  		compatible = "dlg,da9063";
>  		reg = <0x58>;
>  		interrupt-parent = <&gpio2>;
> -- 
> 2.10.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
