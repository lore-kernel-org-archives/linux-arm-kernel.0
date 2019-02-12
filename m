Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B88220842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHtw89iE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARqAT/am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B88220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vh4bQTB8gESbF4akHoDDmH9DPinMF1h1D4cZEqQ5Uao=; b=iHtw89iENTyMd2
	KC9PIPFYAXZ3/3BkmQs/wWdQk847yBS8GNRiizU2m8cZSIVL/2pZGHVd/xUwavAE3IyAKBa+Iq39I
	WqkM2wdP3iw53ZbNx8qflG6rz4h0N6RfHMhkvxe9eTdGugw7qJZtVvfD9J9hjDw9WsPbWykxu8jDQ
	YN1GFIO03Hspvaak82dCBla1sVe2oHlMMP6UXoIwO/gEgqUljfk6kMyeRBh/2Kjj4GEQDAu6uwXPM
	bnWgeUJImNNckztY6sb4qcXdVWSJmL7bl3MZJypKteJYlm0gpIilLwPdbuX00y6cCR2dDxxIlT263
	bIa1M1lkQdlnndugxnPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtcE3-0007ft-Nh; Tue, 12 Feb 2019 17:52:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtcDD-0006uS-T2
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:51:19 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 69EEA222C6;
 Tue, 12 Feb 2019 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549993875;
 bh=qkw3O4E7e4tXgXtsfkToypcXwzk8xFe3GB37b5ckw64=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ARqAT/amEUpNOiZ6eDTkzZ35JSQjeNy/5RlYjg4GvB/cm1h28cKmZW/DRVxArU6E5
 +TGAUJYtL98YVS7C6SYJWgru1x2ouZgRJkO7wB9Z1BxJXP9bjL5k44ttxtGhiPwZ6V
 CXbme9Zo8Zt+nDFvTv9S1hsXLlIr0Y+9iJc+D/3U=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU
Date: Tue, 12 Feb 2019 18:50:52 +0100
Message-Id: <20190212175052.6310-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212175052.6310-1-krzk@kernel.org>
References: <20190212175052.6310-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_095116_763292_0E54CC92 
X-CRM114-Status: GOOD (  13.83  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move the ADC from exynos5420.dtsi to a shared file between Exynos5410 and
Exynos542x: exynos54xx.dtsi.  Enable the ADC on Odroid XU board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts |  5 +++++
 arch/arm/boot/dts/exynos5410.dtsi         |  6 ++++++
 arch/arm/boot/dts/exynos5420.dtsi         | 18 ++++++------------
 arch/arm/boot/dts/exynos54xx.dtsi         |  9 +++++++++
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 434a7591ff63..282600a1e08d 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -87,6 +87,11 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo10_reg>;
+	status = "okay";
+};
+
 &audi2s0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 57fc9c949e54..e6f78b1cee7c 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -260,6 +260,12 @@
 	};
 };
 
+&adc {
+	clocks = <&clock CLK_TSADC>;
+	clock-names = "adc";
+	samsung,syscon-phandle = <&pmu_system_controller>;
+};
+
 &arm_a15_pmu {
 	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff15880761..149badfca74d 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -548,18 +548,6 @@
 			status = "disabled";
 		};
 
-		adc: adc@12d10000 {
-			compatible = "samsung,exynos-adc-v2";
-			reg = <0x12D10000 0x100>;
-			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_TSADC>;
-			clock-names = "adc";
-			#io-channel-cells = <1>;
-			io-channel-ranges;
-			samsung,syscon-phandle = <&pmu_system_controller>;
-			status = "disabled";
-		};
-
 		hsi2c_8: i2c@12e00000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E00000 0x1000>;
@@ -1363,6 +1351,12 @@
 	};
 };
 
+&adc {
+	clocks = <&clock CLK_TSADC>;
+	clock-names = "adc";
+	samsung,syscon-phandle = <&pmu_system_controller>;
+};
+
 &dp {
 	clocks = <&clock CLK_DP1>;
 	clock-names = "dp";
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index de26e5ee0d2d..e21ed6eb6c4c 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -96,6 +96,15 @@
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		adc: adc@12d10000 {
+			compatible = "samsung,exynos-adc-v2";
+			reg = <0x12d10000 0x100>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
+
 		/* i2c_0-3 are defined in exynos5.dtsi */
 		hsi2c_4: i2c@12ca0000 {
 			compatible = "samsung,exynos5250-hsi2c";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
