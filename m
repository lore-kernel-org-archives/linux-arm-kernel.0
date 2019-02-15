Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC00FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6932192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Os6da72X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKeEb0j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6932192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=2Zx0QB6uV6j5+pQsXRbw7UhNKXU4sdfe/AyCLW3ZLtU=; b=Os6
	da72X6Jxnj7Et5aXB8fAbh/IppIK0xuW5sBT+yDxeV4Qmzcj9ItIJOPOFpW7FEhyeljTh4BVojbP0
	NF9ZJa5HMAht0LRbcSIzNqpiTpl6YVTqltERBxVALydw/4SjTCWTnzymatlqe7ngJkpgTd8W+9EYG
	tK/C2+uWdsU+giKn3MzTORn/Zhg/xUzBmhAQgswyxAqGcwh0/TX58EEyFCu3R2x0IfBXwHNZ58/hs
	T34gWdTSmY3qS3Pb+zOfaPhcxs8dbT+7eYMeEvOX2h6p7pGmBK6AMfKj0H8K6q9IvhVpz6duJL9+r
	mlvmEEzuHlUjbFUAlVAZZj2GL6huEqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVYg-00076u-PP; Fri, 15 Feb 2019 04:57:06 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVYd-00075f-1X
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 04:57:04 +0000
Received: by mail-pg1-x541.google.com with SMTP id m1so4203513pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 20:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=kSA1TWJhCcW942nec5H5KUTcw9lD/Qj1J6bxw+KVpGs=;
 b=IKeEb0j6DAR83CuSjVdt+YyIhrkgUdVyBUvbEEJELqkUf4I5O2LdHtKSQF3GXDVXr8
 p+lBX83Z8AvVqicqN6dgQpD90KQr6K48FvDCOEOuqkW+KYy9yRqDXj7PC2yKwQ7bsSJA
 kf6eR03uJ2NwVMbFYaGO08gzKuLMJ5dOQwZcfRP8oxrJWlps6mpeosxAbOA0+Mksm341
 HpsUizT8a2SB9VvjXR6BMuDHyDh5i8VRHiVbIffyNCG7PIQ0ojP8GrEw23oylLkbfTSo
 n+f0ZEXu3X7tk8LvrL+bY22Ljry9OscxM/fZtUz5oaYUs9KlH+y5fir2gCmRAhtcTi5C
 koJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kSA1TWJhCcW942nec5H5KUTcw9lD/Qj1J6bxw+KVpGs=;
 b=kHNwuQZJPgw5gFIYw8ZN5NTVIR56Pl8oL8PqbtWNc8mUPL7iBidWeSgUZzEwZXcNH4
 GRvJ/CBMRYMfSP5lKuSZw6Iv2+vfJpGABK4j3ly+dJflfc9eN5fLtSnu8cma012RPeTs
 vYwenqEvUkG3sLg9dIoAcYtbc/K94OBxm74XRv33sG3Wd5ZIQl/fHLQBBdNYb6koaO7E
 lOEyp931lcX6noHvlR2+YkS62sfvYPUCGVzfnOeX2s2o42wl8C56WUF2EFUorpuRZS6P
 r3mB82PAmqyjRIJhG0NWTqm18BzXKrIlLvXfvk+xijXQ97SneKjHH/ZYY36xFr8gBNtM
 lBnA==
X-Gm-Message-State: AHQUAuZkGrT9Rx8y51qM3OyX2k9vfIF9WYqesZJM5gRbRWZW8dhBlbqU
 CBtESq6RXG8drBm/GXDcsQJJ
X-Google-Smtp-Source: AHgI3IYEo2fZJzhKYguqyf8Kkk3NMjRd9PiChuOsx5/5A+QXOd7rdaa/TR826KA2AgI9mwkoiO9rJQ==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr3592785pgc.165.1550206621218; 
 Thu, 14 Feb 2019 20:57:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
 by smtp.gmail.com with ESMTPSA id
 y12sm9021267pgh.38.2019.02.14.20.56.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 20:57:00 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: heiko@sntech.de
Subject: [PATCH v2] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
Date: Fri, 15 Feb 2019 10:26:48 +0530
Message-Id: <20190215045648.26380-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_205703_110845_4ECCFF0C 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: tom@vamrs.com, mani@kernel.org, linux-kernel@vger.kernel.org, dev@vamrs.com,
 linux-rockchip@lists.infradead.org, pbrobinson@gmail.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 ezequiel@collabora.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
on AP6356S and Ficus based on AP6354 wireless modules.

Firmwares for the respective boards are available here:

http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Added address and size cells property to sdio0 node

 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 98 ++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 56abbb08c133..d33cd441dee9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -9,6 +9,15 @@
 #include "rk3399-opp.dtsi"
 
 / {
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+	};
+
 	vcc1v8_s0: vcc1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s0";
@@ -362,6 +371,20 @@
 };
 
 &pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_bus1: sdmmc-bus1 {
 			rockchip,pins =
@@ -387,6 +410,26 @@
 		};
 	};
 
+	sdio0 {
+		sdio0_bus4: sdio0-bus4 {
+			rockchip,pins =
+				<2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
+				<2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
+				<2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
+				<2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
+		};
+
+		sdio0_cmd: sdio0-cmd {
+			rockchip,pins =
+				<2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
+		};
+
+		sdio0_clk: sdio0-clk {
+			rockchip,pins =
+				<2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins =
@@ -403,6 +446,19 @@
 				<1 14 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins =
+				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_host_wake_l: wifi-host-wake-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm2 {
@@ -413,6 +469,35 @@
 	status = "okay";
 };
 
+&sdio0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <50000000>;
+	bus-width = <4>;
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	no-emmc;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
@@ -439,8 +524,19 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts>;
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+	};
 };
 
 &uart2 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
