Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B056DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:45:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2552080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJdK9d0u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuSo33ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2552080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N5Vv6jnEhZSotO1j2Vdi6WvC5FdN72+LE0AY9vUKE48=; b=XJdK9d0unSTm2U
	cIFgMPs+IiQ6YXM8QS+puK4KR1Z6KpNmAIWXVhDfKOEIpjXQQc+OO6DqzCM6e96kROcq2Fguwew2C
	1Jm+xjsEPzDT00B+hLJu+uW6pmy98B/ApZYncRLY+M9dzY+WgaRLDXuvpdgxKQqtsibnIPu+YmI9T
	xZ65NsDnnUDDgDXKZxmaXmdGqFGUzIp2lEzQ+qMlmn9f8dKotYib1DQ077iRVSM3YNtTtu9eCAoWU
	I0kZVfwuvMwiUV+OIJrNL+3Xdr4xrmp4WdXNHTgUtZhLyONlHLgcBNRRZF/RsNhrruYNVhJiZ6d+x
	WPhkKqfInbrMnKsUJQGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9HD-0002je-Ea; Fri, 08 Feb 2019 16:45:19 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9H8-0002hF-O8; Fri, 08 Feb 2019 16:45:16 +0000
Received: by mail-it1-x141.google.com with SMTP id b5so10395137iti.2;
 Fri, 08 Feb 2019 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CeEHovmgDGSlo7V67n/82RvyDVEZ6zBna+m70ZH1cIE=;
 b=DuSo33ikESVvKcbUejA2PGYecGWNPux7vQRNWJwmgEgF0Tg++rxsyu9HAC0VblA/Kf
 IGEv8u8gTzvmwKGIqn4qmB/ZTgTh0jSR0hiQJDi5yGEXtMJ2/fk2NwQElD6OhAZOcRUJ
 5YwpaO8b29ChbLtBH/S38kri9tJ79rY1eJc5zfS1qV7uIY4exig/lvORgpLOVNtGfiBj
 8jxEnuHK1dwRZ1xT7YQrV1frhImEI+g0MaFge84stgJrZJ5SfZ3E9u+q+RUVqEVVdidm
 CjwuL/N3YFLt2oQuYardL2bSYxxhx6CXRdeAjJhwTjwaP3dmfHOuUXv2qmnVvPzqW8bC
 oRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CeEHovmgDGSlo7V67n/82RvyDVEZ6zBna+m70ZH1cIE=;
 b=TlzM/nMSU043ycD3+hUqhYvkHIsLQgayxPFIG5by0iFm0LaOJuytEkM21rcJIE+R1t
 cS5x+ZyiAys0rpsWxvA9bCpdTbvyb9RD2yeuTX/JagWw/GXHjNLd/rUA2o8yjKX/CaWP
 Q8bXgtRVEQmgBy6ZCLKGLNdldLA3/X1PkRKdbVHAVS1lgRUtIFR0px3Yg6z9bKZTT6N9
 cyOmFSTl39uzLjdfhL0IKBFTf6+Bag/KqfOuzm8NSDGWwH03WF4plaGm77rVEGVLNilx
 x4ranT5kGiRszVM2595iyQXl30HC+pRtb9ee1aa/mYs/52qVzjFd2q/dfM3AZvSr+y/k
 eNeA==
X-Gm-Message-State: AHQUAuahRrecEEKCcVUNIBsGWWque3HWKD/QQzIyoP71bj+xIDKGrZwA
 a6TEpvU1uCDhGMg2h3YAzRwSHNA3Mgt+gHF2k8L/9mQ1
X-Google-Smtp-Source: AHgI3IYZhGLS4MlKZGKQ44Bgb7+nS2f8kIAqfCnIGD0L/5Hm7cYvMxU0kST0UpyW2xNMt8vdkSoCiZFkN6Dabuwp4OY=
X-Received: by 2002:a24:100d:: with SMTP id 13mr8448922ity.58.1549644312961;
 Fri, 08 Feb 2019 08:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 8 Feb 2019 16:45:01 +0000
Message-ID: <CALeDE9MNa+CDJR8bvS05f2UTKrhwMRo8jzdS5o8Ndu7H8V8Ldg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_084514_788892_4EDD2534 
X-CRM114-Status: GOOD (  15.49  )
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
Cc: heiko@sntech.de, mani@kernel.org, linux-kernel@vger.kernel.org,
 dev@vamrs.com, linux-rockchip@lists.infradead.org, ezequiel@collabora.com,
 linux-arm-kernel@lists.infradead.org, tom@vamrs.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mani,

On Thu, Feb 7, 2019 at 5:54 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
> on AP6356S and Ficus based on AP6354 wireless modules.
>
> Firmwares for the respective boards are available here:
>
> http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
> http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

There's some warnings on building these I noticed in testing this on Fedora:

  DTC     arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
(reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
(4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (i2c_bus_reg):
Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (spi_bus_reg):
Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#address-cells value
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#size-cells value

  DTC     arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
(reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
(4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
(i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
(spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#address-cells value
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#size-cells value

> ---
>  .../boot/dts/rockchip/rk3399-rock960.dtsi     | 96 ++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index 56abbb08c133..1b2f7cd82244 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -9,6 +9,15 @@
>  #include "rk3399-opp.dtsi"
>
>  / {
> +       sdio_pwrseq: sdio-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               clocks = <&rk808 1>;
> +               clock-names = "ext_clock";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wifi_enable_h>;
> +               reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +       };
> +
>         vcc1v8_s0: vcc1v8-s0 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vcc1v8_s0";
> @@ -362,6 +371,20 @@
>  };
>
>  &pinctrl {
> +       bt {
> +               bt_enable_h: bt-enable-h {
> +                       rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               bt_host_wake_l: bt-host-wake-l {
> +                       rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               bt_wake_l: bt-wake-l {
> +                       rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
>         sdmmc {
>                 sdmmc_bus1: sdmmc-bus1 {
>                         rockchip,pins =
> @@ -387,6 +410,26 @@
>                 };
>         };
>
> +       sdio0 {
> +               sdio0_bus4: sdio0-bus4 {
> +                       rockchip,pins =
> +                               <2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
> +                               <2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
> +                               <2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
> +                               <2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
> +               };
> +
> +               sdio0_cmd: sdio0-cmd {
> +                       rockchip,pins =
> +                               <2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
> +               };
> +
> +               sdio0_clk: sdio0-clk {
> +                       rockchip,pins =
> +                               <2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
> +               };
> +       };
> +
>         pmic {
>                 pmic_int_l: pmic-int-l {
>                         rockchip,pins =
> @@ -403,6 +446,19 @@
>                                 <1 14 RK_FUNC_GPIO &pcfg_pull_down>;
>                 };
>         };
> +
> +       sdio-pwrseq {
> +               wifi_enable_h: wifi-enable-h {
> +                       rockchip,pins =
> +                               <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       wifi {
> +               wifi_host_wake_l: wifi-host-wake-l {
> +                       rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
>  };
>
>  &pwm2 {
> @@ -413,6 +469,33 @@
>         status = "okay";
>  };
>
> +&sdio0 {
> +       clock-frequency = <50000000>;
> +       bus-width = <4>;
> +       cap-sdio-irq;
> +       cap-sd-highspeed;
> +       no-emmc;
> +       keep-power-in-suspend;
> +       mmc-pwrseq = <&sdio_pwrseq>;
> +       non-removable;
> +       num-slots = <1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +       sd-uhs-sdr104;
> +
> +       status = "okay";
> +
> +       brcmf: wifi@1 {
> +               compatible = "brcm,bcm4329-fmac";
> +               reg = <1>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> +               interrupt-names = "host-wake";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wifi_host_wake_l>;
> +       };
> +};
> +
>  &sdhci {
>         bus-width = <8>;
>         mmc-hs400-1_8v;
> @@ -439,8 +522,19 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_xfer &uart0_cts>;
> +       pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
>         status = "okay";
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
> +               clocks = <&rk808 1>;
> +               clock-names = "ext_clock";
> +               device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> +               host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> +               shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> +       };
>  };
>
>  &uart2 {
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
