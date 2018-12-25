Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E62218D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uycz9EQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E62218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Cx7beWlnUFcc2PlyS7jTVHp5XOZt1gd8GNCNBegEOnE=; b=Uycz9EQU+MyIxQP5mRNNCyPXSM
	PPjhjPPncwrkdasE6dszwqtRJRPQ369p6KJfsVQelB7UYMoCI5ikW3QEcLNDBwSSipNrTy5R1C5I0
	mcFAcEd0fN8ptjn12IfRbX1frJ/HnCCELIajF3vHZVV9rJIezPrDp8yFfV5zUPZY0mKSGLCdAssmw
	fVwcPpoe8JKnv05Rw4f2jtnf3BthsS+OsH1udKrjLCQfIgOyt344I1vfcJ4C0G1SjeQMWjX9u6hE2
	MJk7s+0RZC9O5r7hx8FqLhXUORr7strGVTUxSwke+19wXf6UvRP8JDUjJfEo7VsM82tkjeT6uUS/v
	VXX1ZAhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbw15-0007z8-Dm; Tue, 25 Dec 2018 23:21:39 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbw0n-0007b4-RK; Tue, 25 Dec 2018 23:21:23 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MtOSu-1hVPEo2j8w-00uqD9; Wed, 26 Dec 2018 00:21:00 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V4 2/3] ARM: dts: add Raspberry Pi 3 A+
Date: Wed, 26 Dec 2018 00:20:07 +0100
Message-Id: <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:71mJ+IUN/2USUQdiEWxboUPZCFKCmLpHZ0m0FpFOUfRJZKQK0T3
 V+HllhxsZUJLAyXJvLM/5VvqQ9l59yxGkQGCi3OahOzLPB61FmBPRGrqh6ixu7PZ0uJ2WZ+
 J8e1Ny4gIWm7qGkBB7H/ZKuz4I/K7ptcLRH8lc4Pr/bD5BqJ8jzBoVtO9HXP0BJSkZKOvgY
 nguj5jO7FsjNqjyKnmXcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NmzmW+pvYzY=:CltIxe47WmMW3GHn7YrXly
 faPPIhOPT8WwV8W09jauQKOgsb0s6h425mLHueZ1Gi/hVUO1xZX/BeHMt2dvyzSmja9I2i8qe
 9EaU0laiAAExRE7xYdCFzSZNfC1AhAjYEkcFrEgKo09E5obVDBSeIl6E4iwOE5vsewXdebvo1
 6zzpVw8PLKxntOl1hR8Kck+qekMtmLJ3k+Q0iNLwVj3AhMNMrhHR5ZEveg2Qfh5IDpfCEVKpq
 F8LaMKiFEKWSTQaEaumI92iJl5JUTWDqmIQo4Y5bpFxLLojWnfZ1RCw723UGdvYMs+DQFidjx
 Wl9xCAYa2c+J6YR7UHtvoS1rwEIvswHoPnqzYRLnYa7jRMyH13oaLssGTHvk2wc158GZU6Qo3
 TMGhXrnIB4n6bssmnflHh/QHn+RWkmUC+oirsGIgfk28fIB1r8peSO5Pwk6QzgNrWDVzka1Qx
 JmPiR1XHg9N1zqh8XiVJTaG8C1z/+dQy0cqC/KMMJXPGME9WR858DPvBzEHR95L84itBBt9rO
 2BF4dQQNQLBcVoLqVAu3n7pqvbLuCuojjOYAZBQm4dTWOfE21i+h4O6qqr7JUh/HlEZEOdl/0
 LjgtTCW00xWSRLvRvrrx2jFH3ZnD9CLxVpGKN1CCeqhTb+ixVHfQi/Z538JZTmANMKCGZFjtS
 p01zbsZm+IklHJfzP9jTB2DJQF51xOo66UDQLPHByAxWsI4tG6DUIRcfaobBGoOU96WAo64lt
 G3FbzTI4/cGASeZmcJiWL4LqLu+IxXAib6jXmKAb11x3Hl2Or0lXfEGM4Tk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_152122_185806_D2F57100 
X-CRM114-Status: GOOD (  20.00  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Raspberry Pi 3 A+ is similar to the Pi 3 B+ but has only 512 MB RAM,
1 USB 2.0 port and no Ethernet.

Compared to the Raspberry Pi 3 B it isn't possible to control BT_ON and
WL_ON separately.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 175 +++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 78551c4..764fe91 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-a-plus.dtb \
 	bcm2835-rpi-cm1-io1.dtb \
 	bcm2836-rpi-2-b.dtb \
+	bcm2837-rpi-3-a-plus.dtb \
 	bcm2837-rpi-3-b.dtb \
 	bcm2837-rpi-3-b-plus.dtb \
 	bcm2837-rpi-cm3-io3.dtb \
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
new file mode 100644
index 0000000..61f4e4d
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2837.dtsi"
+#include "bcm2836-rpi.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
+
+/ {
+	compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
+	model = "Raspberry Pi 3 Model A+";
+
+	chosen {
+		/* 8250 auxiliary UART instead of pl011 */
+		stdout-path = "serial1:115200n8";
+	};
+
+	memory {
+		reg = <0 0x20000000>;
+	};
+
+	leds {
+		act {
+			gpios = <&gpio 29 GPIO_ACTIVE_HIGH>;
+		};
+
+		pwr {
+			label = "PWR";
+			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&gpio {
+	/*
+	 * This is mostly based on the official GPU firmware DT blob.
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
+			  "SDA1",
+			  "SCL1",
+			  "GPIO_GCLK",
+			  "GPIO5",
+			  "GPIO6",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "GPIO12",
+			  "GPIO13",
+			  /* Serial port */
+			  "TXD1",
+			  "RXD1",
+			  "GPIO16",
+			  "GPIO17",
+			  "GPIO18",
+			  "GPIO19",
+			  "GPIO20",
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "GPIO26",
+			  "GPIO27",
+			  "HDMI_HPD_N",
+			  "STATUS_LED",
+			  /* Used by BT module */
+			  "CTS0",
+			  "RTS0",
+			  "TXD0",
+			  "RXD0",
+			  /* Used by Wifi */
+			  "SD1_CLK",
+			  "SD1_CMD",
+			  "SD1_DATA0",
+			  "SD1_DATA1",
+			  "SD1_DATA2",
+			  "SD1_DATA3",
+			  "PWM0_OUT",
+			  "PWM1_OUT",
+			  "NC", /* GPIO42 */
+			  "WIFI_CLK",
+			  "SDA0",
+			  "SCL0",
+			  "SMPS_SCL",
+			  "SMPS_SDA",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+};
+
+&firmware {
+	expgpio: gpio {
+		compatible = "raspberrypi,firmware-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "",
+				  "BT_WL_ON",
+				  "STATUS_LED",
+				  "",
+				  "",
+				  "CAM_GPIO0",
+				  "CAM_GPIO1",
+				  "";
+		status = "okay";
+	};
+};
+
+&hdmi {
+	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
+	status = "okay";
+};
+
+/*
+ * SDHCI is used to control the SDIO for wireless
+ *
+ * WL_REG_ON and BT_REG_ON of the CYW43455 Wifi/BT module are driven
+ * by a single GPIO. We can't give GPIO control to one of the drivers,
+ * otherwise the other part would get unexpectedly disturbed.
+ */
+&sdhci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio34>;
+	status = "okay";
+	bus-width = <4>;
+	non-removable;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* SDHOST is used to drive the SD card */
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	status = "okay";
+	bus-width = <4>;
+};
+
+/* uart0 communicates with the BT module */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32 &gpclk2_gpio43>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <2000000>;
+	};
+};
+
+/* uart1 is mapped to the pin header */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_gpio14>;
+	status = "okay";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
