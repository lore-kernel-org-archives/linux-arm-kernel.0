Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8FE2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hlaXF/im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8FE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=82eyVmb/teUkiyYOgrWbVJQLYtsQCWdr3DQ80Lmv67M=; b=hlaXF/imjWGlkQaYvfkXxNWuWq
	ykX2bMX+AkU9gjMGkXPIggo7p7YbQrL3l+WpsoatS16743+4NsCW+2hE6//jt12gqZwSSKFBOsB4H
	iC+ZyU25g9WyLf2JJ/ZWd4rMwqYoMSueq/tGam5sdrPqu3BWwhf7ne8n3lz5fOwldQ10ZH82Ml0N6
	Y0u1ZzTDHLLN/PPmx3fJgMhe4ONOoFa3lLte8hD7rnbJhJ9aLNgwrEBNUNKDjtNhuKMg+GhKHhRD7
	0TuNnC6AFhsMTfDyDjsKNNBizb1CYxnfpU4zb6ZXwyhGgjZ1MrIi+W218nbA8qNGvW64wR+zSg6N5
	wTNxqhjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIes-0006aX-9H; Sat, 12 Jan 2019 12:45:02 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005so-Jc; Sat, 12 Jan 2019 12:44:14 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdNLi-1hHMPa2aSu-00ZS8f; Sat, 12 Jan 2019 13:44:02 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 6/6] ARM: dts: bcm283x: Add missing GPIO line names
Date: Sat, 12 Jan 2019 13:43:28 +0100
Message-Id: <1547297008-2740-7-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:/sSYu93iPiHSiQiCSqyyEbNwieia6j63s13TxvEtjTitqqKhXZY
 Ndi57wMqrE5bTZ8lYFXctODn+3Waj7YdUxRqgtgOyriZsRo+dZTH75NfP6Sk3hJ6S2x5aaK
 eyuiMQSayQ9tx7JhPdOO6tz1iI3FIciYxVPKX2tlTlYma/gLie0yQZihf6fXXaTYlsqVG7B
 nBa3cKKDG58JlTCUxIRug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pc6olJVBpeU=:bSjBpD1/Zl36Ndgv3Lwgod
 4iRxQ7dg3/EQQjEM/FD1X4YIDT8D9gEynLUDO72+Dq6J4ErpP3nQxciEXHpEkXy6Q95+lPPWS
 JpJSicn8M4hUV45oYPxHItC4dfs1fSPyjKL5IcBYnAnv6KBryrAoINloUB+u/6tb4m/HJdETE
 38J4LKOsaml5xJIX8PGRNrUaRbkasqzCgavggKlhqCYA4xeIebX1VHDlTUsTAzj5IvxDPzBGn
 BlPFBGTaFmTKTAIUsvIwuk+EeDu8HqE4h7CpIhoP9LwTXaDSzsW/fDBI+FNFeCoN3IG90Y0XZ
 r38YdbUR16ZCIQ/3jW0YTGUE5ZknqtU/TMdMHvEBZQumO0FH5D2DuApq073PCM8xvddUa2h3W
 eN4eNWs+SplSMUaNH+AIHo4CsuSMCU/0Xn3cHToYdNv3K6iGaAQFklUU6OfWTkhkXGgclj/mq
 OQTa4N/FtEjROBJiWVKpmfzGZ4a8ZAHGkhYjtIaEfOtXxJtErSJ7lnlFKopSb6KFKCIMXwNuK
 niWNkruTCikAopZSsY0+fINBM/GXpti4QrmBt9n9b2gM5BKXDgbWm32O/E3W8OcYicvKh6bo6
 YBkz5NVDHDbgzdD34VbCoiY9j+ZRZbJdpqjjS30Mb8eM6deMJLfMKTmXqUOQXSjHde9v735ij
 d0pZymyAENGC0/CbfavX9Zz30PmvM7H4xl91vSQN2S84+cJUoWkE8Yu1nHdHiNrvSvCmN/Pxe
 T9+48w0iw/AHd02Hg3inGhcdzrmGuAsxkOVzWpQQlCVUQiAN/dnOy8bK29Y=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044412_167985_7F7DC01D 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: Gottfried Haider <gottfried.haider@gmail.com>, devicetree@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>,
 bcm-kernel-feedback-list@broadcom.com, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GPIO sysfs is deprecated and disabled in the defconfig files.
So in order to motivate the usage of the new GPIO character device API
add the missing GPIO line names for Raspberry Pi 2 and 3. In the lack
of full schematics i would leave all undocumented pins as unnamed.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 66 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 70 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 70 ++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 871fc4a..7b4e651 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -28,6 +28,72 @@
 };
 
 &gpio {
+	/*
+	 * Taken from rpi_SCH_2b_1p2_reduced.pdf and
+	 * the official GPU firmware DT blob.
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
+			  "TXD0",
+			  "RXD0",
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
+			  "SDA0",
+			  "SCL0",
+			  "", /* GPIO30 */
+			  "LAN_RUN",
+			  "CAM_GPIO1",
+			  "", /* GPIO33 */
+			  "", /* GPIO34 */
+			  "PWR_LOW_N",
+			  "", /* GPIO36 */
+			  "", /* GPIO37 */
+			  "USB_LIMIT",
+			  "", /* GPIO39 */
+			  "PWM0_OUT",
+			  "CAM_GPIO0",
+			  "SMPS_SCL",
+			  "SMPS_SDA",
+			  "ETHCLK",
+			  "PWM1_OUT",
+			  "HDMI_HPD_N",
+			  "STATUS_LED",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index d3ec6cd..c6fa34c 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -52,6 +52,76 @@
 	};
 };
 
+&gpio {
+	/*
+	 * Taken from rpi_SCH_3bplus_1p0_reduced.pdf and
+	 * the official GPU firmware DT blob.
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
+			  "ETHCLK",
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
 &hdmi {
 	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 31b1c03..ce71f57 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -47,6 +47,76 @@
 	};
 };
 
+&gpio {
+	/*
+	 * Taken from rpi_SCH_3b_1p2_reduced.pdf and
+	 * the official GPU firmware DT blob.
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
+			  "", /* GPIO 28 */
+			  "LAN_RUN_BOOT",
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
+			  "ETHCLK",
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
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
