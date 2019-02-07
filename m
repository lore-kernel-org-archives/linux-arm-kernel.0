Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A55C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:54:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E452147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okbYcYRy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I93jGVOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E452147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1o82b5Gukpcd6M9ImlezpbRJuDj45z1gKMl3sasNkyQ=; b=okb
	YcYRy9OgKyz0VYsaWoKapBV5Mxp7pEqVRWppNXy9QZveC+PNqcKqcW8n6Yspw93ZFAynaq2jaWROW
	PoLFXQB1uIMxM7rPX8LQ9KfQCJKqJOFMqRIslK20vMttm6EWTmawT3LjV77eBRb4BGqq6OUC8AkNH
	T0Zr2KdfiVQNJoiycAa6VdXNLKwud1VqoqVvxTGmNQ/e+XO13B+HrnciHm4ZiE0va8pS9SoIuKgnj
	p5u1tloeOcTxf21s5V91nH227AgYrC1J51oSwyFMzYtuGUkih/Lh7SotbVB6nhLnVcT7SRfQrFUF7
	d28g2tnWw2HwyKVUEFqj4H6VilLtVVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grcdX-0003g3-Q0; Thu, 07 Feb 2019 05:54:11 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grcdU-0003f3-I8
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 05:54:10 +0000
Received: by mail-pl1-x643.google.com with SMTP id k15so4297869pls.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 21:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=swvbNBv+LvJQkqr26tX9fTzwidgI0RC66IvI6f27eJ4=;
 b=I93jGVOLhr1IScjguAw11x4BSytMhirVNDJLqV4trKpyxqSXZqWzeMsaEownUtXxfC
 zx5uS++CWxWaUdXT7mf/NILyhPcR7PkNT8xPPiFltsy9h0yLmKbN+ALNa/rdDEJhKTTZ
 /H3KdoOnupPf7H8gx2HlhHwIyZKJGBNV3PPY6gIWhdqf1iNLI6PWZXwO89tcIan09rhM
 459mvTqWEpcsQiCDtfVEo8/8uGdUrIuLhjeze9P6/B1zlp4PconxO/4kyWndGgcf9UdI
 FQ6eJPG6hGobXHDtwF0VEIYiYvhG/dCGp6EfytQzp1AWoSPv0Tm71ygvglVV/uhl83c0
 H4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=swvbNBv+LvJQkqr26tX9fTzwidgI0RC66IvI6f27eJ4=;
 b=RgP/mxHhyUP6e8hPsUJyxOyEj22c9aRA9Xz472nq7wxSZi3dcs9+wKWnGPx+rwY1TF
 +tLGvC+UHLvIWzfOTP809XeumvLQ8W9hZpfYh1ke33nnYVQCxCG9dQqGFWKHbhP5VfLX
 SdWHWr4xPhtVRB502Ixk3dOwmqSnS9ZQ+xIgb9OliA2/jULHg0YKLqarzspaElqVptiI
 397/hgBCiYHcfyHr+WlAIq3iu7QSiu87tWpxrzuJFdfhJSoEaV8xi4kPqW1lqPnf3Dyh
 c2r67oKfQE4GAJsT3GXOvHJP8PCsx8qgaN/IvipltX7ga0Q7ebnVBAK78v1h4UgvOCkA
 KZaw==
X-Gm-Message-State: AHQUAuamODV21Wq9p4omCWsBH+FfycSrSuQLfWwiNK4BQjbr0Zd199Ob
 uyHGQY+fTeSZxGo+rkSW0KeMtT3WBQ==
X-Google-Smtp-Source: AHgI3IZYXmH6xWwIA/mxI4AW/NlCyIWiNufAJdcB8RxL7hLJmRWiEdS8r3/hHfsqYvtU06qrNWTFaw==
X-Received: by 2002:a17:902:449:: with SMTP id
 67mr6093465ple.310.1549518847371; 
 Wed, 06 Feb 2019 21:54:07 -0800 (PST)
Received: from localhost.localdomain ([2405:204:730d:914e:a8b4:2532:ae24:7d86])
 by smtp.gmail.com with ESMTPSA id l19sm19256807pfi.71.2019.02.06.21.54.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 21:54:06 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: heiko@sntech.de
Subject: [PATCH] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
Date: Thu,  7 Feb 2019 11:23:49 +0530
Message-Id: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_215408_606072_02B92F52 
X-CRM114-Status: GOOD (  14.42  )
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
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 56abbb08c133..1b2f7cd82244 100644
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
@@ -413,6 +469,33 @@
 	status = "okay";
 };
 
+&sdio0 {
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
@@ -439,8 +522,19 @@
 
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
