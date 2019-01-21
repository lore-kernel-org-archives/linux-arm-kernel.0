Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40FC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB5920861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="arwfL2Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB5920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D+aWoJjQpYzOFlaTpBakOellcFm1aUh9bEfvgSxGmIU=; b=arwfL2DxjbFBRj
	AEQrxIXQ0p/subzDrAOaDc7JgH2D68c4ZnvCHvC44xggbtcXz7q/7MT0wE+Hn7s1mepicjgOXesVf
	436jhmE1JN1q+Wt/Kb18EHx2KOxt5eJR6OEwUS7q99lCJioQCD+UG/6V2NlyimASUYji8swedj729
	f0P+34nro0qAU7zJlTxqyZPqucHPtOYXGHwf1wXTh61qkGbhxVHpkDFbAnjHbhkTzmluhmpvJWQ2k
	ZhCX0qvBHudKG0hmL+kEeHzuH45VS7xss8UdieyGTUPIQtrZTagY0DhNVQh5UeOnXOcO6w2k9OEdg
	XE4oFVBH8hiu2Q0wIKSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVBR-0005Zz-1F; Mon, 21 Jan 2019 08:43:53 +0000
Received: from mxout012.mail.hostpoint.ch ([2a00:d70:0:e::312])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVBM-0005Yo-H5
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:43:50 +0000
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
 by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glVBG-0005L3-Hg; Mon, 21 Jan 2019 09:43:42 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
 by asmtp013.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glVBG-0006Iv-Cx; Mon, 21 Jan 2019 09:43:42 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
Message-ID: <cf6bf50028fd17a623f93d8d6114af3e9b54c610.camel@pschenker.ch>
Subject: Re: [PATCH] ARM: dts: imx6*-apalis/-colibri: mark I2C recovery
 GPIOs as open drain
From: Philippe Schenker <dev@pschenker.ch>
To: Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org, s.hauer@pengutronix.de
Date: Mon, 21 Jan 2019 09:43:41 +0100
In-Reply-To: <20190118133113.19484-1-stefan@agner.ch>
References: <20190118133113.19484-1-stefan@agner.ch>
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_004348_564545_9DB92A0E 
X-CRM114-Status: GOOD (  14.93  )
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
Reply-To: dev@pschenker.ch
Cc: max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-18 at 14:31 +0100, Stefan Agner wrote:
> Since commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery
> GPIO") GPIO lib expects this GPIO to be configured as open drain.
> Make sure we define this GPIO as open drain in the device tree.
> This gets rid of the following warning:
>   gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI
> DSDT/board file
> 
> Note that currently the i.MX pinctrl driver does not support
> enabling open drain directly, so this patch has no effect in
> practice. Open drain is enabled by the fixed pinmux entry.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

> ---
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index cf66f9ececbd..2d0ed199ed20 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -429,8 +429,8 @@
>  	pinctrl-names = "default", "recovery";
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> -	scl-gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..8a27c2a05678 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -298,8 +298,8 @@
>  	pinctrl-names = "default", "recovery";
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> -	scl-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> index 6c63a7384611..9ad1da159768 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> @@ -94,16 +94,16 @@
>  	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c1>;
>  	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	sda-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> -	scl-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
> +	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  };
>  
>  &i2c2 {
>  	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> -	sda-gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
> -	scl-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
> +	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	ad7879@2c {


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
