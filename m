Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B944C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D46F20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X5qfKR4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D46F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N+J8BBlO5AIHPWKER9U3LS1xvnwt8nUp+c3uqe4D868=; b=X5qfKR4GxO4FuG
	vQSfcb5tXhA94cIOzKsGgGM0ZL3ankL7WnE0HtrcRbG0/l3Ur50nhUYScY4UtYtuTS7TRkN3B9thk
	l0fRuoZ4LEUq20luwhMLgWPYhmc1GVCC9SsUsG6tp9Oja3xBOaWcEmO0v2uPr34s1UZjyUHFANUyU
	0Ien2Omr7zq39gps2JMgLi4vJQF2D140XNmNSVtPJpljhblZVTi6q11O3TElWG5OBH1cI+L4dA3UT
	A+9FgWBGbMRB5TSOi1v/Q8GvQGCdff1NpcK+PLUsCPMuwa6235tFLVcho0RlCEVSQEhN8pVTWyXCs
	QxhfLRY0jLsulC9LUETg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVvf-0002hd-JR; Thu, 10 Jan 2019 08:43:07 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVvc-0002gZ-1r; Thu, 10 Jan 2019 08:43:06 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghVvW-00025J-7P; Thu, 10 Jan 2019 09:42:58 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: Remove inconsistent use of 'arm,
 armv8' compatible string
Date: Thu, 10 Jan 2019 09:42:57 +0100
Message-ID: <2664471.Eeqcqp8LJD@diego>
In-Reply-To: <20190109202934.29304-1-robh@kernel.org>
References: <20190109202934.29304-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_004304_237952_B2BE72A2 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org, arm@kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 9. Januar 2019, 21:29:34 CET schrieb Rob Herring:
> The 'arm,armv8' compatible string is only for software models. It adds
> little value otherwise and is inconsistently used as a fallback on some
> platforms. Remove it from those platforms.
> 
> This fixes warnings generated by the DT schema.
> 
> Reported-by: Michal Simek <michal.simek@xilinx.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

For the Rockchip-parts
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi
> b/arch/arm64/boot/dts/rockchip/px30.dtsi index 9aa8d5ef9e45..eb992d60e6ba
> 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -40,7 +40,7 @@
> 
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLK>;
> @@ -52,7 +52,7 @@
> 
>  		cpu1: cpu@1 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLK>;
> @@ -64,7 +64,7 @@
> 
>  		cpu2: cpu@2 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLK>;
> @@ -76,7 +76,7 @@
> 
>  		cpu3: cpu@3 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLK>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi index ecd7f19c3542..0f72bb33ce86
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -37,7 +37,7 @@
> 
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x0>;
>  			clocks = <&cru ARMCLK>;
>  			#cooling-cells = <2>;
> @@ -49,7 +49,7 @@
> 
>  		cpu1: cpu@1 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x1>;
>  			clocks = <&cru ARMCLK>;
>  			#cooling-cells = <2>;
> @@ -61,7 +61,7 @@
> 
>  		cpu2: cpu@2 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x2>;
>  			clocks = <&cru ARMCLK>;
>  			#cooling-cells = <2>;
> @@ -73,7 +73,7 @@
> 
>  		cpu3: cpu@3 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x3>;
>  			clocks = <&cru ARMCLK>;
>  			#cooling-cells = <2>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3368.dtsi index 7014d10b954c..06e7c31d7d07
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -73,7 +73,7 @@
> 
>  		cpu_l0: cpu@0 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -81,7 +81,7 @@
> 
>  		cpu_l1: cpu@1 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -89,7 +89,7 @@
> 
>  		cpu_l2: cpu@2 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -97,7 +97,7 @@
> 
>  		cpu_l3: cpu@3 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -105,7 +105,7 @@
> 
>  		cpu_b0: cpu@100 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -113,7 +113,7 @@
> 
>  		cpu_b1: cpu@101 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -121,7 +121,7 @@
> 
>  		cpu_b2: cpu@102 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x102>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -129,7 +129,7 @@
> 
>  		cpu_b3: cpu@103 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x103>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 6cc1c9fa4ea6..db9d948c0b03
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -68,7 +68,7 @@
> 
>  		cpu_l0: cpu@0 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKL>;
> @@ -79,7 +79,7 @@
> 
>  		cpu_l1: cpu@1 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKL>;
> @@ -90,7 +90,7 @@
> 
>  		cpu_l2: cpu@2 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKL>;
> @@ -101,7 +101,7 @@
> 
>  		cpu_l3: cpu@3 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a53", "arm,armv8";
> +			compatible = "arm,cortex-a53";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKL>;
> @@ -112,7 +112,7 @@
> 
>  		cpu_b0: cpu@100 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a72", "arm,armv8";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKB>;
> @@ -123,7 +123,7 @@
> 
>  		cpu_b1: cpu@101 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a72", "arm,armv8";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKB>;




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
