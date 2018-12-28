Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F03217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LBw1BUTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F03217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=U43f15oCW1JpRrfoxUSwHpiimSpSc+vZMp+0DzmYScE=; b=LBw1BUTOXh0fDLci2KF5DL2E/B
	AurlY4APbhopzblg/1v+aFUzylLGnNZiZ5aWW3dox3aPvuHRMdhFZCmHf1gUD53Ri+GE4KzDDoSCX
	/yjnZTfQ4iCQpTdoBLkXYOMZ36K0i9sYe/ty2yLWWhwsNspLJBuFzsLntEuiHKS3Xqtm6p0Vtq0TR
	bkB1y/S9X9/hjNON6gQ9QGpyjELcJsZScU8isfyIzLn39CfzGKTV2kFiRze+xXD8X+/E2/Wgh0O8h
	EuHoznr4xFm6WZ+zyJD7oVsYR/71Ul5n7ApwuKLAqQNPS+YyW+SDnMXSkiVHPNr+flxYCs/Id+vaX
	5pVW63zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0Lm-0001WM-OP; Fri, 28 Dec 2018 22:11:26 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0L8-0000zw-Qj; Fri, 28 Dec 2018 22:10:49 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N79q6-1hQRAN1MFA-017Re1; Fri, 28 Dec 2018 23:10:27 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V5 2/3] ARM: dts: add Raspberry Pi 3 A+
Date: Fri, 28 Dec 2018 23:09:26 +0100
Message-Id: <1546034967-2427-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
References: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:X9W0gxRD0/RIFc8ZuVTXA+J0H2yBa5tMQ7/XC/wRgFGZksN7dtq
 YnVNim9/RRO3WANmRUCXfbmwV8w+jpXiNmCG+aryN4WbpYC+m+S3af39yxEC77GesF+Rkb2
 ae/7mgRtF8mzx1MJa2krWphQBC2UjVcBvnl25v+110buN8Rn19jo/7gp6HxA5MrjqwVtKOV
 93WmrxiyicV/ArnF0zmKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hH/wJ0DSpRM=:F3eUvp/XnOYkdDYalKxXd2
 9Iiqo+laOZ0e4ObXHwdrDnS781GUB4Lkv/LyUlqQKgvIVynmpMBsN7C5uIDaaUXDz8xiJzGds
 yciFKr+KJsdEHRHv6w/AD6/93OYn+YkeqUVmO02aZ5jXPfQq0XPWOkoQtENVDhRo2NWRw80tR
 9RMatz0WqCtLCo53oKC/hj8AWbglls4NHOjgdYCptewEi3PmjL8awNsyWfMQ3wotU6ekG7DU4
 6q1ql/zfArOoQAyY00L7TXJ0ZPjPcyOyrRN4G3/FrZSM7IplHCjcuBpRNI9XYN15akKUSDdKq
 dz5etpHO4F347mnMMQPs8YsYmFWmEhuhZhj9opaEI2gIgfXFexg3kDuJcYsg0ZFAkh4TIyIiH
 AY+ZwnhRwOx0k4AIqjXEPCHspVsBN2VGQsGeByHKFy5PbI6C0sixa3Z5TvwLvWirtNoS18ZuP
 K9euhVqiVZSU9lWmmivu/CP9qpRGtKSwEEfI6y+sbepIzeWux0QCSH9sDFzAm1OpBbAmu3lc5
 y94qkmhIz3P6aXYKZxc7zjmXg1LhqrAsNbEw+DW41i4LNWTRjU2gGHRySlf4hif0lCahuK4HI
 BOuvL0v0k7Y9FeEpnf/d+xvlKF7L2N9Zcooo2Es7FICoyY1Jz0JkR8mLYmfNaEuNDyaN6NwNI
 jRTH5LcGkqeVhbC6lcMj4mQbCp0OT+bwKmU/s+sKQp5bzjkE8bfElqySpf6QhADApTi9kqSu0
 HbkN7MhDFUyuU9MGNwVCdxbfqtNGiaQaG9mDFFyaW1HtfqjF8Js+/5H5iNc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_141047_184825_85FA566C 
X-CRM114-Status: GOOD (  20.04  )
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
index 0000000..e9fadd3
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
+&firmware {
+	expgpio: gpio {
+		compatible = "raspberrypi,firmware-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "",
+				  "BT_WL_ON",
+				  "STATUS_LED_R",
+				  "",
+				  "",
+				  "CAM_GPIO0",
+				  "CAM_GPIO1",
+				  "";
+		status = "okay";
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
+			  "STATUS_LED_G",
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
+			  "", /* GPIO42 */
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
