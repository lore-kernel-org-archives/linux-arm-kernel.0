Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:05:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8C220834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mlueQZZH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HgvpwCak";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtFB6+IM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8C220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iHjl5jmBpCinO1FvHaqjxg6WAEwKa8WvgpyhsRAfQXc=; b=mlueQZZHHyhPC1
	yhGYoyvhRL/Hdpx2SgMj5bE1lFOghrj2T1Y/T2IxajCm4Dqsocm8W9IR5zHY/61CJuIKs3s7Z8npI
	ZAY3JZQfmOShYud+oAexxlV8BAUnuYZwac2Ig9vIX+kM5I/RxAHnIYd9xwjxIQEs1WSiXXOZYZUyU
	6iBGkiniIeMn7JEMjVtlAnagPmUykX/ccgTpNDySuhc7erIDrDMw7aoP//5GpApUIhUNUqBXTTxgk
	2EpejPnTal3KbRlCQTic1rf6TkbNgSfq3UKQ3jc1EjQgqs8RWtEmecT5H3WRIgRgt6tQKcU0mDlfu
	KRd18nchDHQ/T2yIjm5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkLr-0008OB-9S; Fri, 30 Nov 2018 15:05:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkLo-0007rS-8z
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 15:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n0L6IlU96e/EDDIA+kzrvykp1GOQNmo35tTrPiatH5g=; b=HgvpwCakBrXN4O7nNWxI7PyKx
 YC2FB01q9mNUX843BVQe61wLPKFSLXZxsfDbaMhC1EB+SyEQEXu6CplkZfLD/uz04A+GZVDIUNpUg
 wTkjPdoGMZdVMYFe+4HeJClSqA759Ul597+aCXwXkRWmJ2Do8kqukeNV1ncD6Rz6XTg/7K/fqu6Vw
 I1Thed8FraYMN1rqoI1Touo2X1fbSfCh1bDl8YNhu33ch3D0dQ1qYzn4rmuxmEwjohirDULK3XPWx
 9rqcLKJzoDmUFd1zSa9ai9Zg98TrsMVE8GGPdE+Pgt52FwKzP3faeuYb6emF8F252VDW5gkPLqOCi
 gSrDqc70w==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSk8d-0004hf-MK
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:51:31 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DBA02145D
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543589472;
 bh=5o4mNCgIzAGhmNZTkKl038usGM5oM80fj84EEZxIiyY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DtFB6+IMWpqE10eOfC3T4sgJ0lOWvZDGxDC3iaJxV5icABhrUUoumJNMg9UmfsgS/
 8GcLQI5QE6S2yD+nwqfSQjdXO9bgobpZrjgfM1DQeh0hkkzqNYJpqPxuMpVOZhVSVN
 DWhbfkGfxAy2zpbUWhb4qjPMZExV334+7rSDmJ+Y=
Received: by mail-qt1-f172.google.com with SMTP id v11so6167243qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 06:51:12 -0800 (PST)
X-Gm-Message-State: AA+aEWaavmnlw1utEDexIFeQaLi9w8/0u8LKqjJ7etmS2NQuTnDpUhwF
 Kqd6z+p/hInCkTNiYUjNA64U26c7/o711EdCYQ==
X-Google-Smtp-Source: AFSGD/VbT5kB72CpsQCYdz1/l00lz8qB82ndgcnN3PONrkf38WoJ9sGSXL1b8rZ88rLmhNnSuQr2rQgCV3iloONQZlY=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr5876540qvi.90.1543589471111;
 Fri, 30 Nov 2018 06:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20181105194040.25406-1-daniel@zonque.org>
In-Reply-To: <20181105194040.25406-1-daniel@zonque.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 30 Nov 2018 08:51:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ9_nUu_iNOn7Eu91tcGO1xqFv-fYn4zEjLGim+kK4tXQ@mail.gmail.com>
Message-ID: <CAL_JsqJ9_nUu_iNOn7Eu91tcGO1xqFv-fYn4zEjLGim+kK4tXQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: pxa3xx: Add Raumfeld DTS files
To: Daniel Mack <daniel@zonque.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145128_136898_178244A2 
X-CRM114-Status: GOOD (  28.29  )
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
Cc: devicetree@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 5, 2018 at 1:41 PM Daniel Mack <daniel@zonque.org> wrote:
>
> This patch adds a set of DTS files that support all PXA3xx based Raumfeld
> audio hardware devices.
>
> Common nodes are factored out into 'common' and 'tuneable-clock' include
> files to keep the top-level DTS files smaller.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  arch/arm/boot/dts/Makefile                    |   7 +
>  arch/arm/boot/dts/pxa300-raumfeld-common.dtsi | 405 ++++++++++++++++++
>  .../boot/dts/pxa300-raumfeld-connector.dts    |  73 ++++
>  .../boot/dts/pxa300-raumfeld-controller.dts   | 267 ++++++++++++
>  .../boot/dts/pxa300-raumfeld-speaker-l.dts    |  11 +
>  .../boot/dts/pxa300-raumfeld-speaker-m.dts    |  11 +
>  .../boot/dts/pxa300-raumfeld-speaker-one.dts  | 137 ++++++
>  .../boot/dts/pxa300-raumfeld-speaker-s.dts    |  11 +
>  .../dts/pxa300-raumfeld-tuneable-clock.dtsi   |  85 ++++
>  9 files changed, 1007 insertions(+)
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-connector.dts
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-controller.dts
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
>  create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d625b9..a4c921fe325f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -778,6 +778,13 @@ dtb-$(CONFIG_ARCH_ACTIONS) += \
>         owl-s500-sparky.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>         prima2-evb.dtb
> +dtb-$(CONFIG_ARCH_PXA) += \
> +       pxa300-raumfeld-connector.dtb \
> +       pxa300-raumfeld-controller.dtb \
> +       pxa300-raumfeld-speaker-s.dtb \
> +       pxa300-raumfeld-speaker-m.dtb \
> +       pxa300-raumfeld-speaker-l.dtb \
> +       pxa300-raumfeld-speaker-one.dtb
>  dtb-$(CONFIG_ARCH_OXNAS) += \
>         ox810se-wd-mbwe.dtb \
>         ox820-cloudengines-pogoplug-series-3.dtb
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi b/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
> new file mode 100644
> index 000000000000..55c436546528
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "pxa3xx.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       /* Will be overridden by bootloader */
> +       hw-revision = <0>;
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200 root=ubi0:RootFS rootfstype=ubifs rw ubi.mtd=3";

You can drop console since you have stdout-path.

> +               stdout-path = &ffuart;
> +       };
> +
> +       memory {
> +               reg = <0xa0000000 0x8000000>;   /* 128 MB */
> +       };
> +
> +       reg_3v3: regulator-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3v3-fixed-supply";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       reg_1v8: regulator-1v8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "1v8-fixed-supply";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-always-on;
> +       };
> +
> +       reg_va_5v0: regulator-va-5v0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "va-5v0-fixed-supply";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio 124 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       ssp_dai0: ssp-dai@0 {
> +               compatible = "mrvl,pxa-ssp-dai";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&ssp0_dai_pins>;
> +               port = <&ssp1>;
> +               #sound-dai-cells = <0>;
> +               dmas = <&pdma 13 3
> +                       &pdma 14 3>;
> +               dma-names = "rx", "tx";
> +               clock-names = "extclk";
> +       };
> +
> +       ssp_dai1: ssp-dai@1 {
> +               compatible = "mrvl,pxa-ssp-dai";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&ssp1_dai_pins>;
> +               port = <&ssp2>;
> +               #sound-dai-cells = <0>;
> +               dmas = <&pdma 15 3
> +                       &pdma 16 3>;
> +               dma-names = "rx", "tx";
> +               clock-names = "extclk";
> +       };
> +
> +       spi: spi {
> +               status = "okay";

Don't need this.

> +               compatible = "spi-gpio";
> +               #address-cells = <0x1>;
> +               #size-cells = <0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&spi_pins>;
> +               gpio-sck = <&gpio 95 GPIO_ACTIVE_HIGH>;
> +               gpio-miso = <&gpio 98 GPIO_ACTIVE_HIGH>;
> +               gpio-mosi = <&gpio 97 GPIO_ACTIVE_HIGH>;
> +               cs-gpios = <
> +                       &gpio 34 GPIO_ACTIVE_HIGH
> +                       &gpio 125 GPIO_ACTIVE_HIGH
> +                       &gpio 96 GPIO_ACTIVE_HIGH
> +               >;
> +               num-chipselects = <3>;

Why do we have this when we can just get the length of cs-gpios?

> +
> +               dac: dac@2 {
> +                       compatible = "ti,dac7512";
> +                       reg = <2>;
> +                       spi-max-frequency = <1000000>;
> +                       vcc-supply = <&reg_3v3>;
> +               };
> +       };
> +
> +       keys: gpio-keys {
> +               compatible = "gpio-keys";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&gpio_keys_pins>;
> +
> +               on-off {
> +                       label = "on_off button";
> +                       gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_F6>;
> +               };
> +
> +               rescue-boot {
> +                       label = "rescue boot button";
> +                       gpios = <&gpio 115 GPIO_ACTIVE_HIGH>;
> +                       linux,code = <KEY_F4>;
> +               };
> +
> +               setup {
> +                       label = "setup";
> +                       gpios = <&gpio 119 GPIO_ACTIVE_HIGH>;
> +                       linux,code = <KEY_F3>;
> +               };
> +       };
> +
> +       rotary: rotary-encoder {
> +               compatible = "rotary-encoder";
> +               gpios = <
> +                       &gpio 19 GPIO_ACTIVE_LOW
> +                       &gpio 20 GPIO_ACTIVE_HIGH
> +               >;
> +               linux,axis = <REL_X>;
> +               rotary-encoder,relative-axis;
> +       };
> +
> +       leds: leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&led_pins_a &led_pins_b>;
> +
> +               left {
> +                       label = "raumfeld:1";
> +                       gpios = <&gpio 36 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               right {
> +                       label = "raumfeld:2";
> +                       gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +
> +       poweroff {
> +               compatible = "gpio-poweroff";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&poweroff_pins>;
> +               gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       mmc0_pwrseq: mmc-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&mmc0_pwrseq_pins>;
> +               reset-gpios = <
> +                       &gpio 113 GPIO_ACTIVE_LOW       /* W2W_RESET    */
> +                       &gpio 114 GPIO_ACTIVE_LOW       /* W2W_PDN      */
> +               >;
> +       };
> +
> +       ethernet: ethernet-controller@10000000 {

ethernet@...

> +               compatible = "smsc,lan9115";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&smsc_pins &smsc_bus_pins>;
> +               reg = <0x10000000 0x100000>;
> +               phy-mode = "mii";
> +               interrupt-parent = <&gpio>;
> +               interrupts = <40 IRQ_TYPE_EDGE_FALLING>;
> +               vdd33a-supply = <&reg_3v3>;
> +               vddvario-supply = <&reg_1v8>;
> +               reset-gpio = <&gpio 39 GPIO_ACTIVE_LOW>;

reset-gpios

> +               reg-io-width = <4>;
> +               smsc,save-mac-address;
> +               smsc,irq-push-pull;
> +       };
> +};
> +
> +&ffuart {
> +       status = "okay";
> +};
> +
> +&pwri2c {
> +       status = "okay";
> +
> +       max8660: regulator@34 {
> +               compatible = "maxim,max8660";
> +               reg = <0x34>;
> +
> +               regulators {
> +                       regulator@0 {

Drop the unit-address as there is no reg property. Build your DT with
W=12 and fix any new warnings these new files add (probably some are
from the SoC dtsi).

> +                               regulator-compatible= "V3(DCDC)";
> +                               regulator-min-microvolt = <725000>;
> +                               regulator-max-microvolt = <1800000>;
> +                       };
> +
> +                       regulator@1 {
> +                               regulator-compatible= "V4(DCDC)";
> +                               regulator-min-microvolt = <725000>;
> +                               regulator-max-microvolt = <1800000>;
> +                       };
> +
> +                       regulator@2 {
> +                               regulator-compatible= "V5(LDO)";
> +                               regulator-min-microvolt = <1700000>;
> +                               regulator-max-microvolt = <2000000>;
> +                       };
> +
> +                       reg_vcc_sdio: regulator@3 {
> +                               regulator-compatible= "V6(LDO)";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                       };
> +
> +                       regulator@4 {
> +                               regulator-compatible= "V7(LDO)";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                       };
> +               };
> +       };
> +};
> +
> +&pxai2c1 {
> +       status = "okay";
> +       mrvl,i2c-fast-mode;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pxai2c1_pins>;
> +};
> +
> +&ssp1 {
> +       status = "okay";
> +};
> +
> +&ssp2 {
> +       status = "okay";
> +};
> +
> +&nand_controller {
> +       status = "okay";
> +
> +       nand@0 {
> +               reg = <0>;
> +               nand-rb = <0>;
> +               nand-ecc-mode = "hw";
> +               marvell,nand-keep-config;
> +
> +               partitions {
> +                       compatible = "fixed-partitions";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       partition@0 {
> +                               label = "Bootloader";
> +                               reg = <0x0000000 0xa0000>;
> +                               read-only;
> +                       };
> +
> +                       partition@a0000 {
> +                               label = "BootloaderEnvironment";
> +                               reg = <0x0a0000 0x20000>;
> +                       };
> +
> +                       partition@c0000 {
> +                               label = "BootloaderSplashScreen";
> +                               reg = <0x0c0000 0x60000>;
> +                       };
> +
> +                       partition@120000 {
> +                               label = "UBI";
> +                               reg = <0x120000 0x7ee0000>;
> +                       };
> +               };
> +       };
> +};
> +
> +&pxa3xx_ohci {
> +       status = "okay";
> +       marvell,enable-port1;
> +       marvell,port-mode = <2>; /* PMM_GLOBAL_MODE */
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pxa3xx_ohci_pins>;
> +};
> +
> +&mmc0 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc0_pins>;
> +       pxa-mmc,detect-delay-ms = <200>;
> +       vmmc-supply = <&reg_vcc_sdio>;
> +       mmc-pwrseq = <&mmc0_pwrseq>;
> +       non-removable;
> +       bus-width = <4>;
> +};
> +
> +&pinctrl {
> +       poweroff_pins: poweroff_pins {
> +               pinctrl-single,pins = <MFP_PIN_PXA300(16) MFP_AF0>;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +
> +       led_pins_a: led_pins_a {
> +               pinctrl-single,pins = <MFP_PIN_PXA300(35) MFP_AF0>;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       led_pins_b: led_pins_b {
> +               pinctrl-single,pins = <MFP_PIN_PXA300(36) MFP_AF0>;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_DRIVE_HIGH);
> +       };
> +
> +       pxai2c1_pins: pxai2c1_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(21) MFP_AF1      /* I2C_SCL      */
> +                       MFP_PIN_PXA300(22) MFP_AF1      /* I2C_SDA      */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_HIGH);
> +       };
> +
> +       gpio_keys_pins: gpio_keys_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(14) MFP_AF0      /* SCK          */
> +                       MFP_PIN_PXA300(115) MFP_AF0     /* MOSI         */
> +                       MFP_PIN_PXA300(119) MFP_AF0     /* MISO         */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +
> +       spi_pins: spi_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(95) MFP_AF0      /* SCK          */
> +                       MFP_PIN_PXA300(97) MFP_AF0      /* MOSI         */
> +                       MFP_PIN_PXA300(98) MFP_AF0      /* MISO         */
> +                       MFP_PIN_PXA300(34) MFP_AF0      /* CS#0         */
> +                       MFP_PIN_PXA300(125) MFP_AF0     /* CS#1         */
> +                       MFP_PIN_PXA300(96) MFP_AF0      /* CS#2         */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       pxa3xx_ohci_pins: pxa3xx_ohci_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300_2(0) MFP_AF1     /* USBHPEN      */
> +                       MFP_PIN_PXA300_2(1) MFP_AF1     /* USBHPWR      */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       smsc_pins: smsc_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(39) MFP_AF0      /* RESET        */
> +                       MFP_PIN_PXA300(40) MFP_AF0      /* IRQ          */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       smsc_bus_pins: smsc_bus_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(1) MFP_AF1       /* nCS2         */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +
> +       mmc0_pins: mmc0_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(3) MFP_AF4       /* MMC1_DAT0    */
> +                       MFP_PIN_PXA300(4) MFP_AF4       /* MMC1_DAT1    */
> +                       MFP_PIN_PXA300(5) MFP_AF4       /* MMC1_DAT2    */
> +                       MFP_PIN_PXA300(6) MFP_AF4       /* MMC1_DAT3    */
> +                       MFP_PIN_PXA300(7) MFP_AF4       /* MMC1_CLK     */
> +                       MFP_PIN_PXA300(8) MFP_AF4       /* MMC1_CMD     */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_DRIVE_HIGH);
> +       };
> +
> +       mmc0_pwrseq_pins: mmc0_pwrseq_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(113) MFP_AF0     /* W2W_RESET    */
> +                       MFP_PIN_PXA300(114) MFP_AF0     /* W2W_PDN      */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +
> +       ssp0_dai_pins: ssp0_dai_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(85) MFP_AF1      /* SSP1_SCLK    */
> +                       MFP_PIN_PXA300(86) MFP_AF1      /* SSP1_FRM     */
> +                       MFP_PIN_PXA300(87) MFP_AF1      /* SSP1_TXD     */
> +                       MFP_PIN_PXA300(88) MFP_AF1      /* SSP1_RXD     */
> +                       MFP_PIN_PXA300(89) MFP_AF1      /* SSP1_EXTCLK  */
> +                       MFP_PIN_PXA300(90) MFP_AF1      /* SSP1_SYSCLK  */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       ssp1_dai_pins: ssp1_dai_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(25) MFP_AF2      /* SSP2_SCLK    */
> +                       MFP_PIN_PXA300(26) MFP_AF2      /* SSP2_FRM     */
> +                       MFP_PIN_PXA300(27) MFP_AF2      /* SSP2_TXD     */
> +                       MFP_PIN_PXA300(29) MFP_AF2      /* SSP2_EXTCLK  */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-connector.dts b/arch/arm/boot/dts/pxa300-raumfeld-connector.dts
> new file mode 100644
> index 000000000000..4cc3b1070949
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-connector.dts
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "pxa300-raumfeld-common.dtsi"
> +#include "pxa300-raumfeld-tuneable-clock.dtsi"
> +
> +/ {
> +       model = "Raumfeld Connector (PXA3xx)";
> +       compatible = "raumfeld,raumfeld-connector-pxa303", "marvell,pxa300";
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "Raumfeld Connector";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               simple-audio-card,dai-link@0 {
> +                       reg = <0>;
> +                       format = "i2s";
> +                       bitclock-master = <&dailink_master_analog>;
> +                       frame-master = <&dailink_master_analog>;
> +                       mclk-fs = <256>;
> +
> +                       dailink_master_analog: cpu {
> +                               sound-dai = <&ssp_dai0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&cs4270>;
> +                       };
> +               };
> +
> +               simple-audio-card,dai-link@1 {
> +                       reg = <1>;
> +                       format = "i2s";
> +                       bitclock-master = <&dailink_master_digital>;
> +                       frame-master = <&dailink_master_digital>;
> +                       mclk-fs = <256>;
> +
> +                       dailink_master_digital: cpu {
> +                               sound-dai = <&ssp_dai1>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&ak4104>;
> +                       };
> +               };
> +       };
> +};
> +
> +&ssp1 {
> +       status = "okay";
> +};
> +
> +&ssp2 {
> +       status = "okay";
> +};
> +
> +&spi {
> +       ak4104: optical-transmitter@0 {
> +               compatible = "asahi-kasei,ak4104";
> +               reg = <0>;
> +               vdd-supply = <&reg_3v3>;
> +               spi-max-frequency = <5000000>;
> +               reset-gpio = <&gpio 38 GPIO_ACTIVE_HIGH>;

reset-gpios

> +               #sound-dai-cells = <0>;
> +       };
> +};
> +
> +&rotary {
> +       status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-controller.dts b/arch/arm/boot/dts/pxa300-raumfeld-controller.dts
> new file mode 100644
> index 000000000000..dd85aaee8b79
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-controller.dts
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "pxa300-raumfeld-common.dtsi"
> +
> +/ {
> +       model = "Raumfeld Controller (PXA3xx)";
> +       compatible = "raumfeld,raumfeld-controller-pxa303", "marvell,pxa300";
> +
> +       reg_vbatt: regulator-vbatt {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vbatt-fixed-supply";
> +               regulator-min-microvolt = <3700000>;
> +               regulator-max-microvolt = <3700000>;
> +               regulator-always-on;
> +       };
> +
> +       lcd_supply: regulator-va-tft {
> +               compatible = "regulator-fixed";
> +               regulator-name = "va-tft-fixed-supply";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio 33 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       onewire {
> +               compatible = "w1-gpio";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&w1_pins>;
> +               gpios = <
> +                       &gpio 126 GPIO_OPEN_DRAIN       /* W1 I/O       */
> +                       &gpio 105 GPIO_ACTIVE_HIGH      /* pullup       */
> +               >;
> +
> +               w1_ds2760: slave@0 {
> +                       compatible = "maxim,ds2760";
> +                       power-supplies = <&charger>;
> +               };
> +       };
> +
> +       charger: charger {
> +               compatible = "gpio-charger";
> +               charger-type = "mains";
> +               gpios = <&gpio 101 GPIO_ACTIVE_LOW>;
> +       };
> +
> +       /*
> +        * One of the following two will be set to "okay" by the bootloader,
> +        * depending on the hardware revision.
> +        */
> +       backlight-controller-pwm {
> +               compatible = "pwm-backlight";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pwm0_pins>;
> +               pwms = <&pwm0 10000>;
> +               power-supply = <&reg_vbatt>;
> +               status = "disabled";
> +
> +               brightness-levels = <
> +                        0  1  2  3  4  5  6  7  8  9
> +                       10 11 12 13 14 15 16 17 18 19
> +                       20 21 22 23 24 25 26 27 28 29
> +                       30 31 32 33 34 35 36 37 38 39
> +                       40 41 42 43 44 45 46 47 48 49
> +                       50 51 52 53 54 55 56 57 58 59
> +                       60 61 62 63 64 65 66 67 68 69
> +                       70 71 72 73 74 75 76 77 78 79
> +                       80 81 82 83 84 85 86 87 88 89
> +                       90 91 92 93 94 95 96 97 98 99
> +                       100
> +               >;
> +               default-brightness-level = <100>;
> +       };
> +
> +       backlight-controller {
> +               compatible = "lltc,lt3593";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&lt3593_pins>;
> +               lltc,ctrl-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +               status = "disabled";
> +
> +               led {
> +                       label = "backlight";
> +                       default-state = "on";
> +               };
> +       };
> +};
> +
> +&reg_va_5v0 {
> +       status = "disabled";
> +};
> +
> +&ethernet {
> +       status = "disabled";
> +};
> +
> +&leds {
> +       status = "disabled";
> +};
> +
> +&dac {
> +       status = "disabled";
> +};
> +
> +&pwm0 {
> +       status = "okay";
> +};
> +
> +&keys {
> +       dock-detect {
> +               label = "dock detect";
> +               gpios = <&gpio 116 GPIO_ACTIVE_HIGH>;
> +               linux,code = <KEY_F5>;
> +       };
> +};
> +
> +&spi {
> +       accelerometer@1 {
> +               compatible = "st,lis302dl-spi";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&lis302_pins>;
> +               reg = <1>;
> +               spi-max-frequency = <1000000>;
> +               interrupt-parent = <&gpio>;
> +               interrupts = <104 IRQ_TYPE_EDGE_FALLING>;
> +
> +               st,click-single-x;
> +               st,click-single-y;
> +               st,click-single-z;
> +               st,click-thresh-x = <10>;
> +               st,click-thresh-y = <10>;
> +               st,click-thresh-z = <10>;
> +               st,irq1-click;
> +               st,irq2-click;
> +               st,wakeup-x-lo;
> +               st,wakeup-x-hi;
> +               st,wakeup-y-lo;
> +               st,wakeup-y-hi;
> +               st,wakeup-z-lo;
> +               st,wakeup-z-hi;
> +       };
> +};
> +
> +&lcdc {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&lcdc_pins>;
> +       lcd-supply = <&lcd_supply>;
> +       enable-acceleration;

Not documented.

> +
> +       port {
> +               lcdc_out: endpoint {
> +                       remote-endpoint = <&panel_in>;
> +                       bus-width = <16>;
> +               };
> +       };
> +
> +       panel {
> +               /* Sharp lq043t3dx0 */

This should have a panel specific compatible.

> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: timing {
> +                               clock-frequency = <9009000>;
> +                               pixelclk-active = <0>;  /* negative edge */
> +                               hactive = <480>;
> +                               vactive = <272>;
> +                               hsync-len = <41>;
> +                               hback-porch = <2>;
> +                               hfront-porch = <1>;
> +                               vsync-len = <10>;
> +                               vback-porch = <3>;
> +                               vfront-porch = <1>;
> +                       };
> +               };
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&lcdc_out>;
> +                       };
> +               };
> +       };
> +};
> +
> +&gcu {
> +       status = "okay";
> +};
> +
> +&pxai2c1 {
> +       touchscreen@a {
> +               compatible = "eeti,exc3000-i2c";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&eeti_ts_pins>;
> +               reg = <0xa>;
> +               interrupt-parent = <&gpio>;
> +               interrupts = <32 IRQ_TYPE_EDGE_RISING>;
> +               attn-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>;
> +               touchscreen-inverted-y;
> +       };
> +};
> +
> +&pinctrl {
> +       lis302_pins: lis302_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(104) MFP_AF0     /* IRQ  */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       eeti_ts_pins: eeti_ts_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(32) MFP_AF0      /* IRQ */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +
> +       lt3593_pins: lt3593_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(17) MFP_AF0      /* Backlight    */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       pwm0_pins: pwm0_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(17) MFP_AF1      /* PWM  */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       w1_pins: w1_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(126) MFP_AF0     /* PWM  */
> +                       MFP_PIN_PXA300(105) MFP_AF0     /* PWM  */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +
> +       lcdc_pins: lcdc_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(54) MFP_AF1      /* LDD_0        */
> +                       MFP_PIN_PXA300(55) MFP_AF1      /* LDD_1        */
> +                       MFP_PIN_PXA300(56) MFP_AF1      /* LDD_2        */
> +                       MFP_PIN_PXA300(57) MFP_AF1      /* LDD_3        */
> +                       MFP_PIN_PXA300(58) MFP_AF1      /* LDD_4        */
> +                       MFP_PIN_PXA300(59) MFP_AF1      /* LDD_5        */
> +                       MFP_PIN_PXA300(60) MFP_AF1      /* LDD_6        */
> +                       MFP_PIN_PXA300(61) MFP_AF1      /* LDD_7        */
> +                       MFP_PIN_PXA300(62) MFP_AF1      /* LDD_8        */
> +                       MFP_PIN_PXA300(63) MFP_AF1      /* LDD_9        */
> +                       MFP_PIN_PXA300(64) MFP_AF1      /* LDD_10       */
> +                       MFP_PIN_PXA300(65) MFP_AF1      /* LDD_11       */
> +                       MFP_PIN_PXA300(66) MFP_AF1      /* LDD_12       */
> +                       MFP_PIN_PXA300(67) MFP_AF1      /* LDD_13       */
> +                       MFP_PIN_PXA300(68) MFP_AF1      /* LDD_14       */
> +                       MFP_PIN_PXA300(69) MFP_AF1      /* LDD_15       */
> +                       MFP_PIN_PXA300(70) MFP_AF1      /* LDD_16       */
> +                       MFP_PIN_PXA300(71) MFP_AF1      /* LDD_17       */
> +                       MFP_PIN_PXA300(72) MFP_AF1      /* LCD_FCLK     */
> +                       MFP_PIN_PXA300(73) MFP_AF1      /* LCD_LCLK     */
> +                       MFP_PIN_PXA300(74) MFP_AF1      /* LCD_PCLK     */
> +                       MFP_PIN_PXA300(75) MFP_AF1      /* LCD_BIAS     */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts b/arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
> new file mode 100644
> index 000000000000..5a0f7f17856f
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "pxa300-raumfeld-common.dtsi"
> +#include "pxa300-raumfeld-tuneable-clock.dtsi"
> +
> +/ {
> +       model = "Raumfeld Speaker L (PXA3xx)";
> +       compatible = "raumfeld,raumfeld-speaker-l-pxa303", "marvell,pxa300";
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts b/arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
> new file mode 100644
> index 000000000000..fa10d896282c
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "pxa300-raumfeld-common.dtsi"
> +#include "pxa300-raumfeld-tuneable-clock.dtsi"
> +
> +/ {
> +       model = "Raumfeld Speaker M (PXA3xx)";
> +       compatible = "raumfeld,raumfeld-speaker-m-pxa303", "marvell,pxa300";
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts b/arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
> new file mode 100644
> index 000000000000..8dd6611c2809
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "pxa300-raumfeld-common.dtsi"
> +
> +/ {
> +       model = "Raumfeld Speaker One (PXA3xx)";
> +       compatible = "raumfeld,raumfeld-speaker-one-pxa303", "marvell,pxa300";
> +
> +       wm8782: wm8782 {
> +               compatible = "wm8782";
> +               #sound-dai-cells = <0>;
> +               Vdd-supply = <&reg_3v3>;
> +               Vdda-supply = <&reg_va_5v0>;
> +       };
> +
> +       xo_11mhz: oscillator-11mhz {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <11289600>;
> +               clock-accuracy = <100>;
> +       };
> +
> +       xo_audio: clock-gate {
> +               compatible = "gpio-gate-clock";
> +               pinctrlnames = "default";
> +               pinctrl-0 = <&xo_audio_pins>;
> +               clocks = <&xo_11mhz>;
> +               #clock-cells = <0>;
> +               enable-gpios = <&gpio 111 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       reg_va_30v0: regulator-va-30v0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "va-30v0-fixed-supply";
> +               regulator-min-microvolt = <30000000>;
> +               regulator-max-microvolt = <30000000>;
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "Raumfeld Speaker";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               simple-audio-card,dai-link@0 {
> +                       reg = <0>;
> +                       format = "i2s";
> +                       bitclock-master = <&dailink_master_analog_out>;
> +                       frame-master = <&dailink_master_analog_out>;
> +                       mclk-fs = <256>;
> +
> +                       dailink_master_analog_out: cpu {
> +                               sound-dai = <&ssp_dai0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&sta320>;
> +                       };
> +               };
> +
> +               simple-audio-card,dai-link@1 {
> +                       reg = <1>;
> +                       format = "i2s";
> +                       bitclock-master = <&dailink_master_analog_in>;
> +                       frame-master = <&dailink_master_analog_in>;
> +                       mclk-fs = <256>;
> +
> +                       dailink_master_analog_in: cpu {
> +                               sound-dai = <&ssp_dai0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&wm8782>;
> +                       };
> +               };
> +       };
> +};
> +
> +&ssp_dai0 {
> +       clocks = <&xo_audio>;
> +};
> +
> +&spi {
> +       dac@2 {
> +               compatible = "ti,dac7512";
> +               reg = <2>;
> +               spi-max-frequency = <1000000>;
> +               vcc-supply = <&reg_3v3>;
> +       };
> +};
> +
> +&rotary {
> +       status = "okay";
> +};
> +
> +&pxai2c1 {
> +       sta320: codec@1a {
> +               compatible = "st,sta32x";
> +               reg = <0x1a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&sta320_pins>;
> +               clocks = <&xo_audio>;
> +               clock-names = "xti";
> +               reset-gpios = <&gpio 120 GPIO_ACTIVE_HIGH>;
> +               Vdda-supply = <&reg_3v3>;
> +               Vdd3-supply = <&reg_3v3>;
> +               Vcc-supply = <&reg_va_30v0>;
> +               #sound-dai-cells = <0>;
> +               st,thermal-warning-adjustment;
> +               st,thermal-warning-recovery;
> +               st,fault-detect-recovery;
> +               st,drop-compensation-ns = <80>;
> +               st,max-power-use-mpcc;
> +               st,invalid-input-detect-mute;
> +               /* 2 (half-bridge) and 1 (full-bridge) on-board power */
> +               st,output-conf = /bits/ 8 <0x1>;
> +               st,needs_esd_watchdog;
> +       };
> +};
> +
> +&pinctrl {
> +       xo_audio_pins: xo_audio_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(111) MFP_AF0     /* ENABLE */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       sta320_pins: sta320_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(120) MFP_AF0     /* CODEC_RESET  */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_FLOAT);
> +       };
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts b/arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
> new file mode 100644
> index 000000000000..36e20cbf8704
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "pxa300-raumfeld-common.dtsi"
> +#include "pxa300-raumfeld-tuneable-clock.dtsi"
> +
> +/ {
> +       model = "Raumfeld Speaker S (PXA3xx)";
> +       compatible = "raumfeld,raumfeld-speaker-s-pxa303", "marvell,pxa300";
> +};
> diff --git a/arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi b/arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi
> new file mode 100644
> index 000000000000..e267ef48c879
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/clock/maxim,max9485.h>
> +
> +/ {
> +       xo_27mhz: oscillator-27mhz {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <27000000>;
> +               clock-accuracy = <100>;
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "Raumfeld Speaker";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               simple-audio-card,dai-link@0 {
> +                       reg = <0>;
> +                       format = "i2s";
> +                       bitclock-master = <&dailink_master_analog>;
> +                       frame-master = <&dailink_master_analog>;
> +                       mclk-fs = <256>;
> +
> +                       dailink_master_analog: cpu {
> +                               sound-dai = <&ssp_dai0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&cs4270>;
> +                       };
> +               };
> +       };
> +};
> +
> +&ssp_dai0 {
> +       clocks = <&max9485 MAX9485_CLKOUT1>;
> +};
> +
> +&ssp_dai1 {
> +       clocks = <&max9485 MAX9485_CLKOUT1>;
> +};
> +
> +&pxai2c1 {
> +       cs4270: codec@48 {
> +               compatible = "cirrus,cs4270";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&cs4270_pins>;
> +               reg = <0x48>;
> +               va-supply = <&reg_va_5v0>;
> +               vd-supply = <&reg_3v3>;
> +               vlc-supply = <&reg_3v3>;
> +               reset-gpio = <&gpio 120 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells = <0>;
> +       };
> +
> +       max9485: clock-generator@63 {
> +               compatible = "maxim,max9485";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&max9485_pins>;
> +               reg = <0x63>;
> +               vdd-supply = <&reg_3v3>;
> +               clock-names = "xclk";
> +               clocks = <&xo_27mhz>;
> +               reset-gpios = <&gpio 111 GPIO_ACTIVE_HIGH>;
> +               #clock-cells = <1>;
> +       };
> +};
> +
> +&pinctrl {
> +       cs4270_pins: cs4270_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(120) MFP_AF0     /* RESET */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +
> +       max9485_pins: max9485_pins {
> +               pinctrl-single,pins = <
> +                       MFP_PIN_PXA300(111) MFP_AF0     /* RESET */
> +               >;
> +               pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW);
> +       };
> +};
> --
> 2.17.2
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
