Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1432C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:11:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D61206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Noxu3cF1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="NF0IeoiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D61206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orpaltech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cEe+6S0x2kKn/O+n2ZndK4WcK6PngAh4ovphKLsyF1I=; b=Noxu3cF1rESn4+F19rqQBCuc6
	kCJsvTSrC2R+mZ+66ujmpehpVaJq8M7exw5290LVym9yWLcr9+XDLBpOl3jlF//pxruY4W8Zl3dfr
	JtkbKiADNFl87kmELJXLXwkolYx8qMLIJ9jD409Dx3iBLMMslRkdMM7i+tYLzDOfbFHoQCZGYbleC
	I5GxJjep+zXwGM03ThtXTFAhtLGkH3EkvzDbhmWoyFJchWFvmj+5vs2PIJankEjTeULbc8ozq5a2R
	nRlLLXs4nUIQmMv0K84ub7sTh1X6S/9ypu6vcJ+4HFD8yIjHqwRNxeRvsRdYl+1iF3WYTamELJ279
	94uG84H1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giNlF-0004hM-JL; Sat, 12 Jan 2019 18:11:57 +0000
Received: from smtpng3.m.smailru.net ([94.100.177.149])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giNlC-0004gm-51; Sat, 12 Jan 2019 18:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=orpaltech.com; s=mailru; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=ZreV689AZFtqCxLWcyLduHGjkVmvAcfbQ4C5UwBaNLY=; 
 b=NF0IeoiANZUNpT/OCY2kWjXr/WW26+etW78swdJcE4Tb1PzqyWvrU+pcjwOHCLe2djSkznMaF44Cuih2l/3XzYvAFHnTiyx5OPyk1i2mc0EL45Hw6+PyEAmler2BDri3Y8j5ZHdoZSk1w9YeOnKKSBf8zwhZ6wN6Ol2becnw87g=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from
 <ssuloev@orpaltech.com>)
 id 1giNl5-0007E2-WB; Sat, 12 Jan 2019 21:11:48 +0300
Subject: Re: [PATCH V4 2/3] ARM: dts: add Raspberry Pi 3 A+
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
 <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <2da60463-f536-84f4-a176-4f8df30f6eaf@orpaltech.com>
Date: Sat, 12 Jan 2019 21:11:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
Authentication-Results: smtpng3.m.smailru.net;
 auth=pass smtp.auth=ssuloev@orpaltech.com
 smtp.mailfrom=ssuloev@orpaltech.com
X-77F55803: 260C666A7D66B36A5A78504BD2AC2941AFB9CFB8EF66CEBF3176FBAA7B7AD4AC903F7C0CA79A97368FA626EE7A7DB81E
X-7FA49CB5: 0D63561A33F958A5259A95865190188776D6322BB6E5E08678ADE0CE481A162C8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4931B544F03EFBC4D576E14D64434357A22CEBD745134792CBC731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 689FA8AB762F7393E78166CB31B43AE4B4698DE072787CEF0DCEFBFB41C26998778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_101154_446495_6002CFF5 
X-CRM114-Status: GOOD (  23.93  )
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
Cc: devicetree@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Stefan,

is this patch the only update required to run Rpi3 A+ with kernel 4.20?

Thank you,
Sergey


On 12/26/18 2:20 AM, Stefan Wahren wrote:
> The Raspberry Pi 3 A+ is similar to the Pi 3 B+ but has only 512 MB RAM,
> 1 USB 2.0 port and no Ethernet.
>
> Compared to the Raspberry Pi 3 B it isn't possible to control BT_ON and
> WL_ON separately.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   arch/arm/boot/dts/Makefile                 |   1 +
>   arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 175 +++++++++++++++++++++++++++++
>   2 files changed, 176 insertions(+)
>   create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 78551c4..764fe91 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>   	bcm2835-rpi-a-plus.dtb \
>   	bcm2835-rpi-cm1-io1.dtb \
>   	bcm2836-rpi-2-b.dtb \
> +	bcm2837-rpi-3-a-plus.dtb \
>   	bcm2837-rpi-3-b.dtb \
>   	bcm2837-rpi-3-b-plus.dtb \
>   	bcm2837-rpi-cm3-io3.dtb \
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> new file mode 100644
> index 0000000..61f4e4d
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2837.dtsi"
> +#include "bcm2836-rpi.dtsi"
> +#include "bcm283x-rpi-usb-host.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
> +	model = "Raspberry Pi 3 Model A+";
> +
> +	chosen {
> +		/* 8250 auxiliary UART instead of pl011 */
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0 0x20000000>;
> +	};
> +
> +	leds {
> +		act {
> +			gpios = <&gpio 29 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		pwr {
> +			label = "PWR";
> +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&gpio {
> +	/*
> +	 * This is mostly based on the official GPU firmware DT blob.
> +	 *
> +	 * Legend:
> +	 * "NC" = not connected (no rail from the SoC)
> +	 * "FOO" = GPIO line named "FOO" on the schematic
> +	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +	 */
> +	gpio-line-names = "ID_SDA",
> +			  "ID_SCL",
> +			  "SDA1",
> +			  "SCL1",
> +			  "GPIO_GCLK",
> +			  "GPIO5",
> +			  "GPIO6",
> +			  "SPI_CE1_N",
> +			  "SPI_CE0_N",
> +			  "SPI_MISO",
> +			  "SPI_MOSI",
> +			  "SPI_SCLK",
> +			  "GPIO12",
> +			  "GPIO13",
> +			  /* Serial port */
> +			  "TXD1",
> +			  "RXD1",
> +			  "GPIO16",
> +			  "GPIO17",
> +			  "GPIO18",
> +			  "GPIO19",
> +			  "GPIO20",
> +			  "GPIO21",
> +			  "GPIO22",
> +			  "GPIO23",
> +			  "GPIO24",
> +			  "GPIO25",
> +			  "GPIO26",
> +			  "GPIO27",
> +			  "HDMI_HPD_N",
> +			  "STATUS_LED",
> +			  /* Used by BT module */
> +			  "CTS0",
> +			  "RTS0",
> +			  "TXD0",
> +			  "RXD0",
> +			  /* Used by Wifi */
> +			  "SD1_CLK",
> +			  "SD1_CMD",
> +			  "SD1_DATA0",
> +			  "SD1_DATA1",
> +			  "SD1_DATA2",
> +			  "SD1_DATA3",
> +			  "PWM0_OUT",
> +			  "PWM1_OUT",
> +			  "NC", /* GPIO42 */
> +			  "WIFI_CLK",
> +			  "SDA0",
> +			  "SCL0",
> +			  "SMPS_SCL",
> +			  "SMPS_SDA",
> +			  /* Used by SD Card */
> +			  "SD_CLK_R",
> +			  "SD_CMD_R",
> +			  "SD_DATA0_R",
> +			  "SD_DATA1_R",
> +			  "SD_DATA2_R",
> +			  "SD_DATA3_R";
> +};
> +
> +&firmware {
> +	expgpio: gpio {
> +		compatible = "raspberrypi,firmware-gpio";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "",
> +				  "BT_WL_ON",
> +				  "STATUS_LED",
> +				  "",
> +				  "",
> +				  "CAM_GPIO0",
> +				  "CAM_GPIO1",
> +				  "";
> +		status = "okay";
> +	};
> +};
> +
> +&hdmi {
> +	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
> +	status = "okay";
> +};
> +
> +/*
> + * SDHCI is used to control the SDIO for wireless
> + *
> + * WL_REG_ON and BT_REG_ON of the CYW43455 Wifi/BT module are driven
> + * by a single GPIO. We can't give GPIO control to one of the drivers,
> + * otherwise the other part would get unexpectedly disturbed.
> + */
> +&sdhci {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_gpio34>;
> +	status = "okay";
> +	bus-width = <4>;
> +	non-removable;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +/* SDHOST is used to drive the SD card */
> +&sdhost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhost_gpio48>;
> +	status = "okay";
> +	bus-width = <4>;
> +};
> +
> +/* uart0 communicates with the BT module */
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32 &gpclk2_gpio43>;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		max-speed = <2000000>;
> +	};
> +};
> +
> +/* uart1 is mapped to the pin header */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_gpio14>;
> +	status = "okay";
> +};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
