Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:16:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB750222E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OIsUWRT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB750222E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hAtmyc2fY3Mjs/PUypeEZ3ZNLcuVWxlmY9P/duZo69I=; b=OIsUWRT16Mkgbg
	Jl5zy8d/oYGJYjswvvvpT9JH96j1/uZYqd89QjOyWyXF5yOmxjdXKDUBikWqyhDzXLPWhNIcNosaG
	GN3ow+rOic+3qtASCvn0Wq71EaN09fOb02an9t5ehYtok8GAvuTBPC9xn5FYn6ntulU+RkpRcTE5S
	WKFW5+TQKBdriy9EA6Ggqcd4Izc8mLZpcUd+OJsYUUpmqRvvEgTpjIshan6W/S7ElGAeNHtvaZA4W
	WdLys14A7a/aqpNUCY7UlSds+TsFFfo4tkKUdQpbfHWz+7MGIfMkQBxNbFK5PFB3i+yTUz8wlV4Ct
	M/TihW1gGqSQWxfx0KqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvLND-0007cB-QZ; Sun, 17 Feb 2019 12:16:43 +0000
Received: from avasout06.plus.net ([212.159.14.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvLMx-00078F-RE
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 12:16:32 +0000
Received: from localhost.localdomain ([87.114.170.31]) by smtp with ESMTP
 id vLLzgM2tCHd2LvLMGgaQAn; Sun, 17 Feb 2019 12:15:44 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=FK01Odgs c=1 sm=1 tr=0
 a=IwDniP0DpuMObaUqJdRMiQ==:117 a=IwDniP0DpuMObaUqJdRMiQ==:17
 a=X63dCvaKAAAA:20 a=OvfN7MOIAAAA:8 a=AI1YhfOiAAAA:8 a=V5NFcaBHAAAA:8
 a=5mpuRNi4AAAA:8 a=rvHh0E1XO6TprAeEZs4A:9 a=N-hkzyawj4u5XedJ:21
 a=09-r2RrawWPGnzw1:21 a=5YTr_Nlhc76s4ZyS:21 a=WKcxsw4WtVgA:10
 a=naW0c5UNiJ17WtinOetU:22 a=ZRk3jL6q91YNeXra8VxS:22 a=AIFGTXQOaoIMFke0skzX:22
 a=eHWn0xJZPbZ7L6UZR85b:22
From: David Summers <beagleboard@davidjohnsummers.uk>
To: heiko@sntech.de,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
Date: Sun, 17 Feb 2019 12:15:12 +0000
Message-Id: <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfCWdXPU/DNP3jKkyuJiUWnmXRLkR2o7FCPTCxXKuXx5VGBSmjaBmQHYNyKOy8h2qNxAYfbSIX3qX9k4aNPeO0wTcZ9lfkXBlqfK/aZiy3b/cm5+DfA6s
 Klf5B/gchs6FBhI3npjiT9ZI6S0YIEKez1YOUtuDOMEfChq8P6WH7pr4ZnIZnECsUa2dGpUySvpjGoZf7lP6B/vdRL/3Dxb87Yw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_041628_346961_00D85FB1 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-rockchip@lists.infradead.org,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the wifi to the ASUS Tinker Board (S) machines.

Unfortunatly neither the Tinker Board nor the Tinker Board S schematic
indicate how the WiFi is wired up on these devices. The WiFi is
provided by the RTL8723BS device, that has sdio WiFi and UART
Bluetooth. This patch just adds the WiFi interface.

With no schematic, most of the wiring has been derived from the ASUS
patch to Debian:

https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678

In conjunction with the pin out of the RTL8723BS device:

http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf

The only unusual part is that to bring the card up, both the pins
RK_PD3 and RK_PD4 need to be pulled. Why this needs to be done is not
clear, best explaination is that they are connected to the RTL8723BS
pins WL_DIS# and BT_DIS#, which the data sheet vaguely says:

Shared with GPIO9 This Pin Can Externally Shutdown the RTL8723BS WLAN
function when BT_DISn is Pulled Low. When this pin deasserted, SDIO
interface will be disabled. This pin can also support the WLAN Ra
dio-off function with host interface remaining connected.

Anyway extensive testing the TheSaint on ArchLinux Arm Forum 

https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=120#p60548

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 39 +++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index fceaeed44e34..e1796f340eef 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -3,8 +3,9 @@
  * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
  */
 
 #include "rk3288.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/rockchip,rk808.h>
 
 / {
 	chosen {
@@ -98,6 +97,15 @@
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 RK808_CLKOUT1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable>;
+		reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &cpu0 {
@@ -337,8 +345,8 @@
 
 &io_domains {
 	status = "okay";
-
 	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc_18>;
 };
 
 &pinctrl {
@@ -417,6 +425,12 @@
 			rockchip,pins = <7 8 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	sdio {
+		wifi_enable: wifi-enable {
+			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>, <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm0 {
@@ -440,6 +454,25 @@
 	vqmmc-supply = <&vccio_sd>;
 };
 
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
+	max-frequency = <50000000>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc_18>;
+	status = "okay";
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
-- 
beagleboard@davidjohnsummers.uk


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
