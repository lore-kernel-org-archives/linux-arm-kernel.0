Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B28C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 13:50:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E50E20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 13:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ak7rqmN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E50E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aGT5jpYUeeURoeRrqXiG3Nkj4b7hQrePuc03ThPmQJA=; b=Ak7rqmN74YBuL1
	G283VT9ArfBVEkBhTisS7noSSocVXCkqWBTi4tr+Uh79jkSiDuGOomMQgyVFwqSYoGrfCGEx2bWyr
	6DV31I3HZ/02RlaVCxN8p0gNJzeTu8iS3tdAzgQxnZYxcTYXJr7e+/tRq7MIqhXVietZyftHdpG8H
	sEcwJs56RnX0p63K37YGD80hg/NZKvK/eHPl7Z5aoImbRdPGKun1R2AUpb+CIWCv3JD5CrGscM37n
	Ow06vzEcdQKozC2+76bPdeuoDivEkqgIY+igr4VLIAGnnKn8rufA6C8vMHCX1/S3+3L7+YxNPAOaY
	G1wJrUPylKXZcyT2zRpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcW3i-0004ZL-BY; Thu, 27 Dec 2018 13:50:46 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcW3e-0004Yh-LV; Thu, 27 Dec 2018 13:50:44 +0000
Received: from oxbsltgw01.schlund.de ([212.227.220.145]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N94uf-1hOSLM1wTH-0166zb; Thu, 27 Dec 2018 14:50:19 +0100
Date: Thu, 27 Dec 2018 14:50:17 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Phil Elwell <phil@raspberrypi.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Eric Anholt <eric@anholt.net>, marcel@holtmann.org
Message-ID: <768451960.268414.1545918617617@email.ionos.de>
In-Reply-To: <11816ec8-9824-8825-b9c3-6790b6171261@raspberrypi.org>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
 <1542322805-6211-3-git-send-email-stefan.wahren@i2se.com>
 <11816ec8-9824-8825-b9c3-6790b6171261@raspberrypi.org>
Subject: Re: [PATCH V2 2/3] ARM: dts: add Raspberry Pi 3 A+
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:t1iiNbofzbkkd7/mSq5YskTiRz7kpkTX28MBhFzUO7bKJyM7B93
 CQw81DUNOxldwwGCHXwKUkbJATWJP1OoD284mtNQSqWRODPRjJqKqg2Xac70LiZe3KVAi6B
 wAzJboTVnlTrx9SVvXkShIQlcJavPBosFpp+nnUOiNNURrI1l5Xnyr2si9EZMN9PLHCxvWZ
 4Hc7vp8g9cgQ2KotyDPcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2vVz6I8Pl8o=:58cHD93Pxd+HE3zLNdy/jQ
 ymBZFy0qaEE/W/j6IGliaUIcmukT2WcLU0EOOwSguPStYPPo11e4ReM6xLOEGTsBYzj05++7X
 K0jkIrThJ/FR9PxW1J5TyOxiSCfvx7/14nJlfyJv5lW/GpKlzLyvUUjEQ7JO7beYWTVJmVpMO
 4aTrtzbREtNCv1TBGQkWaQsq/1BA5YacdCvB/V3NNyYqPWffH6/D2yzuLdf3l7nJbbQnj0bQj
 2wa8vJoeTZqaRwYyAZGnhYkKCeJs9TEFjFWtUTfZPEmc8Whj8DNFVxmJHT2i1YJVO8gSYRJnA
 avtgg80UevkJKothMQbm63eorABGfGDCGkR3ubifzY5rm46IABXeWwTKnFofebh0sopTs0sdx
 tbdy1ffONlOrMQTeAAwgRF8CdO0W0V0RSTorH/hJDpOG5mwj3O9OqUuo0yLpNNSHnhzEwO+dC
 UdrLjAR5FkvV9nmEZkJaLGunZ27gBa/VVKfQ8H8V39KIHgA7eyKPHjJCic88d3WXBUi9/u7Sk
 KljQJKcrYn4nBudgCKum9ia9//xdfNdBm/m6pzMDe5mdzxdkp0tezwrl9jjqJ5RgFBEN49in/
 7SARkTqUXdztD+qkw5JBdePgWEFeH5aJ3+je+tKzkLQWHZsstaH4Ad6mnEcNMy0oe59B8CQPi
 N/IrcphWS5vldtaCvQh/HTzGk+RkvIbC2J8qQ2eEWG3lAixSLJlpDmSzs1gd68LofkJugyIqh
 s/XzpaVTrCLAEqtwbGqWEvp1ri6V+uY760JoloHDzFjedwI7VcCSjtyUxXI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_055043_007497_3915A11B 
X-CRM114-Status: GOOD (  29.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Phil,

[add Marcel to CC]

> Phil Elwell <phil@raspberrypi.org> hat am 14. Dezember 2018 um 22:49 geschrieben:
> 
> 
> Hi Stefan,
> 
> On 15/11/2018 23:00, Stefan Wahren wrote:
> > The Raspberry Pi 3 A+ is similar to the Pi 3 B+ but has only 512 MB RAM,
> > 1 USB 2.0 port and no Ethernet.
> > 
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >   arch/arm/boot/dts/Makefile                 |   1 +
> >   arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 107 +++++++++++++++++++++++++++++
> >   2 files changed, 108 insertions(+)
> >   create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index b0e966d..15bbd0d 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
> >   	bcm2835-rpi-a-plus.dtb \
> >   	bcm2835-rpi-cm1-io1.dtb \
> >   	bcm2836-rpi-2-b.dtb \
> > +	bcm2837-rpi-3-a-plus.dtb \
> >   	bcm2837-rpi-3-b.dtb \
> >   	bcm2837-rpi-3-b-plus.dtb \
> >   	bcm2837-rpi-cm3-io3.dtb \
> > diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> > new file mode 100644
> > index 0000000..75785dd
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/dts-v1/;
> > +#include "bcm2837.dtsi"
> > +#include "bcm2836-rpi.dtsi"
> > +#include "bcm283x-rpi-usb-host.dtsi"
> > +
> > +/ {
> > +	compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
> > +	model = "Raspberry Pi 3 Model A+";
> > +
> > +	chosen {
> > +		/* 8250 auxiliary UART instead of pl011 */
> > +		stdout-path = "serial1:115200n8";
> > +	};
> > +
> > +	memory {
> > +		reg = <0 0x20000000>;
> > +	};
> > +
> > +	leds {
> > +		act {
> > +			gpios = <&gpio 29 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		pwr {
> > +			label = "PWR";
> > +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +
> > +	wifi_pwrseq: wifi-pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
> > +	};
> > +};
> > +
> > +&firmware {
> > +	expgpio: gpio {
> > +		compatible = "raspberrypi,firmware-gpio";
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-line-names = "BT_ON",
> > +				  "WL_ON",
> > +				  "STATUS_LED",
> > +				  "",
> > +				  "",
> > +				  "CAM_GPIO0",
> > +				  "CAM_GPIO1",
> > +				  "";
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&hdmi {
> > +	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
> > +};
> > +
> > +&pwm {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
> > +	status = "okay";
> > +};
> > +
> > +/* SDHCI is used to control the SDIO for wireless */
> > +&sdhci {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&emmc_gpio34>;
> > +	status = "okay";
> > +	bus-width = <4>;
> > +	non-removable;
> > +	mmc-pwrseq = <&wifi_pwrseq>;
> > +
> > +	brcmf: wifi@1 {
> > +		reg = <1>;
> > +		compatible = "brcm,bcm4329-fmac";
> > +	};
> > +};
> > +
> > +/* SDHOST is used to drive the SD card */
> > +&sdhost {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sdhost_gpio48>;
> > +	status = "okay";
> > +	bus-width = <4>;
> > +};
> > +
> > +/* uart0 communicates with the BT module */
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32 &gpclk2_gpio43>;
> > +	status = "okay";
> > +
> > +	bluetooth {
> > +		compatible = "brcm,bcm43438-bt";
> > +		max-speed = <2000000>;
> > +		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
> > +	};
> > +};
> > +
> > +/* uart1 is mapped to the pin header */
> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart1_gpio14>;
> > +	status = "okay";
> > +};
> > 
> 
> Although this DTS originally looked correct to me, I learnt yesterday from
> poring over the schematic that, due to routing congestion around the WiFi combo
> chip, the 3A+ drives the BT_ON pin from the same source - GPIO1 on the expander -
> as the WL_ON pin. GPIO0 on the expander is not connected. This means that the
> shutdown-gpios property of the bluetooth node is incorrect.

thanks for pointing out. I tested this on my RPi 3 A+ with some gpio-exp hacking and can confirm this behavior.

I don't know the reason for this design decision, but both drivers (wifi and BT) can't share the control of GPIO1. Additionally we can't give the control to only one of them, because the other one could be unexpectedly tied into reset. So i decided to drop the reset control of both ones with all the consequences (no power management, default baudrate usage of BT) in V4 of this series.

> 
> Furthermore, I've been told that the current production 3B+ is the same in this
> regard - a change since the 3B+ schematic with which the firmware support was
> developed - so the 3B+ DTS should ideally also be changed, although leaving it
> as it stands is likely to make little practical difference.

Oh dear. I think there is no hurry for changing 3B+. So i would like to wait until this series has been applied.

Stefan

> 
> Phil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
