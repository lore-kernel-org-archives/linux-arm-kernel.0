Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0886C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EE42081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JYnUBDrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EE42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=USNsthoN3FFEFx7U+2NkiWI+CturV+888pKSb0RNCqA=; b=JYnUBDrCnTGKB2TAy2JjiZd2Ra
	7AIas3zU/1y8q3AUyA90EFhuWPBAgj9XUbNlVZT/pYLLuI9jMywztAmG5bhh4aERhKkZXtVrijKX/
	ZnnEUmTQ9oGvuhDAxtjOS1TzHp5EI2iy/R9iLdiUYXCEOdlkcYdPIO3+PTb6AlQhWo42QCKG0xWcl
	pATIUVoDrXEf0jXEYsAiwd/wG3ukFNJ3lfvIfgNA+JPs3Ngu7quNxiYXJ2D1JvR8XkmfwRG1K0hZh
	7DT1bNn/DjqE6gArdDbTN7Zsg/0hZ/vtFrtguHfISa/W9rfkCCC5p6dzWGnOiTbHJhXWSEwrBTKkx
	Ts1HiMfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFuf-00074u-IN; Tue, 04 Dec 2018 18:59:17 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFuc-000737-AF; Tue, 04 Dec 2018 18:59:16 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTfgb-1gvyxH1xQz-00TyQt; Tue, 04 Dec 2018 19:58:54 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V3 2/3] ARM: dts: add Raspberry Pi 3 A+
Date: Tue,  4 Dec 2018 19:58:18 +0100
Message-Id: <1543949899-13380-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
References: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:3DMMDYjsCTx6IxBf2WC2ooKMnJiVzq9RVmh0csGsajg6lyIrJhZ
 1Bxu2ZSF3G0pHYpWlUkunk+gbYzjwXHLe7l8Qt331s0uI7iQlNoKYnDPTnSttqFWy6REewG
 TGQ/wBenT40TkCKYB4Jzxzm/sBnOCRuCRNOESZRNHpPgNmq54dplz7pgEsWcSC+rJNqDZ57
 hZVdKs0sW1HDASHCi5bwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xL1UKc14icc=:ywcRqmyL4hAvJKGdv9SW2+
 nB4fjCvnj/X2wxnBW6IGj37m5w0vogpA8hZ8T6OzOMSxYREPfeTGl0fgSVwKdAAfQTilDe5XN
 wVJ+fvkM/SVIA7FUaeR+eechsklUZrJKVpjZMrIYH7GLwVl6OVF7VFhlvxC3o1DUlYE3m4GKL
 DrhSdB9wcKUO+KrQc67I4PhdhKePc2EaA1/fDGNkQFkCVlXsw1vdrfla5T/tetBlHQq+qCPcl
 vuLv5NeXx2KtC0zqEdEKZn7KqcA//KMtDQCWmXnc9jvjqx17DF5Iji1xQe4vXA196P9ZcF1U0
 vpv6mSI3SPtCJEn48zHMTIt6tVRJ6Ao0HmZEkFDyRW3c8sgK4OFLnLUjSx4YoSHB9RKnC+Psz
 5QZLWBT81RHxqPiLa49EXhaHkyDXtiinriofvqJqogtl+X0J9Rmn7wczjqYRaQzp1iBTrpXNT
 sC/ZLyTJ25ZAAMrotIK1UgL9S4CFgdwDk0AKcVUycNoVsWeIrCC743fQazerXkOFNeuBW9t55
 G5gQD5pmEvQkOjb+cExnODkM9L7eOIrrJzsap98bS0Bsu7inAsXOIObRVJWtKpEwXQ5PUo3gt
 Ku6C8Xgr5A2ydsc9LegxF5JXOM9UPx9+eN3hHsH3aW5+eW80KDN6INGwBoJnvwPHDdlK2PRH/
 nEOKWJBTLqRcf39DMKyzTJirlz/jNbWra0qisP3AYgQv2lF0jM5hs64oQ2nDzHbFAKljBdf+0
 wMfkYx1QgW1uF+G+3OEXmrPRKSqUFihd4VBKZ0WYsMkKX+VEO9T1n75KUNU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_105914_660350_5C19EA39 
X-CRM114-Status: GOOD (  18.48  )
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
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Raspberry Pi 3 A+ is similar to the Pi 3 B+ but has only 512 MB RAM,
1 USB 2.0 port and no Ethernet.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 107 +++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d..15bbd0d 100644
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
index 0000000..b2df7cf
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -0,0 +1,107 @@
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
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&firmware {
+	expgpio: gpio {
+		compatible = "raspberrypi,firmware-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "BT_ON",
+				  "WL_ON",
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
+/* SDHCI is used to control the SDIO for wireless */
+&sdhci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio34>;
+	status = "okay";
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&wifi_pwrseq>;
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
+		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
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
