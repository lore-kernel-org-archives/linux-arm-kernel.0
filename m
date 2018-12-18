Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:13:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E5A217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ukXpe3FB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j8EHjiqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E5A217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=82FSZaV9uRvRXJa5v+LhSiLQjojbbmcrlWLG6fQEqtM=; b=ukXpe3FBRTqfLq
	4PqW6gX86WDy1tgaypVUaKE6hFT57Vi68RQU471eCO/fpnJshzo6xGS08SCatJJpoAiBHXcIXXUsI
	Dg/LQvq61wTQgwgbVhlDB5jCpeSfxMVamM1ddg+VgHkgU6aZtoLwqpHptuz+NXKKX01jU6R1spOXI
	I+ezs0b9rIaAVLe1sJcYO/3sjJz3NMId71r99zb5aC4AHp3ttia77fnRHs/RD0MfgTB3NjzQZ+GmJ
	9rVVKcDgRWa7h9y5PorKHTquPw7ov7J/u5y5RGCXpGPEUdze5rlcXWGqvybCebLyxIvYPNjOeAsa6
	erjWtGWVZCWgx2l0xcUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBRf-0005DV-A6; Tue, 18 Dec 2018 09:13:43 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBR0-0004cr-2P
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:13:03 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18ba0c0003>; Tue, 18 Dec 2018 01:12:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 01:12:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 01:12:50 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:12:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 18 Dec 2018 09:12:49 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c18ba100000>; Tue, 18 Dec 2018 01:12:49 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 01/20] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
Date: Tue, 18 Dec 2018 17:12:13 +0800
Message-ID: <20181218091232.23532-2-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218091232.23532-1-josephl@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545124364; bh=l8HDE5HmPvPgqCsQ1PjWehBWBGArqYvrPDnmgG4qoXw=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=j8EHjiqK1CMBZGnhX3+jV+erqlLPD/TW3QQCX/bT2z5fQw1nG/wBsCe6VLe6fj2xI
 ehp56hFoOdRRu9CsIOvl5G0cJU68/PqNo+ocmMeEsRGjEGzHPt23G6xFN8/90DCNfe
 04r6cSNOo2RUG0uzr2jaIf7KnIh1QOMkMn37W7/uPU/goT/wND/cXkgNpMDwNGNCZd
 newbKSqvYT73oUhNAjYcwTOlPm5sT/UZ5G1ftaWR5HAu9e41MLzk+AbMt74FskOADM
 fdWmRRgRh43tw+Aq9KKQVdsSnaq5763JNG8r5HClOr+Zb294kodZvBf2qhpOgDbBM3
 //gqkvRQB2thQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_011302_120981_8E9F4FE4 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

Add new properties to configure the DFLL PWM regulator support.

Cc: devicetree@vger.kernel.org
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
*V3:
 - no change
*V2:
 - update the binding strings and descriptions for
 nvidia,pwm-tristate-microvolts
 nvidia,pwm-min-microvolts
 nvidia,pwm-voltage-step-microvolts
---
 .../bindings/clock/nvidia,tegra124-dfll.txt   | 79 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index dff236f524a7..38e8cc8c70a8 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
 oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
 control module that will automatically adjust the VDD_CPU voltage by
 communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
-Currently only the I2C mode is supported by these bindings.
 
 Required properties:
 - compatible : should be "nvidia,tegra124-dfll"
@@ -45,10 +44,31 @@ Required properties for the control loop parameters:
 Optional properties for the control loop parameters:
 - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
 
+Optional properties for mode selection:
+- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
+
 Required properties for I2C mode:
 - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
 
-Example:
+Required properties for PWM mode:
+- nvidia,pwm-period: period of PWM square wave in microseconds.
+- nvidia,pwm-tristate-microvolts: Regulator voltage in micro volts when PWM
+  control is disabled and the PWM output is tristated. Note that this voltage is
+  configured in hardware, typically via a resistor divider.
+- nvidia,pwm-min-microvolts: Regulator voltage in micro volts when PWM control
+  is enabled and PWM output is low. Hence, this is the minimum output voltage
+  that the regulator supports when PWM control is enabled.
+- nvidia,pwm-voltage-step-microvolts: Voltage increase in micro volts
+  corresponding to a 1/33th increase in duty cycle. Eg the voltage for 2/33th
+  duty cycle would be: nvidia,pwm-min-microvolts +
+  nvidia,pwm-voltage-step-microvolts * 2.
+- pinctrl-0: I/O pad configuration when PWM control is enabled.
+- pinctrl-1: I/O pad configuration when PWM control is disabled.
+- pinctrl-names: must include the following entries:
+  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
+  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
+
+Example for I2C:
 
 clock@70110000 {
         compatible = "nvidia,tegra124-dfll";
@@ -76,3 +96,58 @@ clock@70110000 {
 
         nvidia,i2c-fs-rate = <400000>;
 };
+
+Example for PWM:
+
+clock@70110000 {
+	compatible = "nvidia,tegra124-dfll";
+	reg = <0 0x70110000 0 0x100>, /* DFLL control */
+	      <0 0x70110000 0 0x100>, /* I2C output control */
+	      <0 0x70110100 0 0x100>, /* Integrated I2C controller */
+	      <0 0x70110200 0 0x100>; /* Look-up table RAM */
+	interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&tegra_car TEGRA210_CLK_DFLL_SOC>,
+	         <&tegra_car TEGRA210_CLK_DFLL_REF>,
+		 <&tegra_car TEGRA124_CLK_I2C5>;;
+	clock-names = "soc", "ref", "i2c";
+	resets = <&tegra_car TEGRA124_RST_DFLL_DVCO>;
+	reset-names = "dvco";
+	#clock-cells = <0>;
+	clock-output-names = "dfllCPU_out";
+
+	nvidia,sample-rate = <25000>;
+	nvidia,droop-ctrl = <0x00000f00>;
+	nvidia,force-mode = <1>;
+	nvidia,cf = <6>;
+	nvidia,ci = <0>;
+	nvidia,cg = <2>;
+
+	nvidia,pwm-min-microvolts = <708000>; /* 708mV */
+	nvidia,pwm-period = <2500>; /* 2.5us */
+	nvidia,pwm-to-pmic;
+	nvidia,pwm-tristate-microvolts = <1000000>;
+	nvidia,pwm-voltage-step-microvolts = <19200>; /* 19.2mV */
+
+	pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
+	pinctrl-0 = <&dvfs_pwm_active_state>;
+	pinctrl-1 = <&dvfs_pwm_inactive_state>;
+};
+
+/* pinmux nodes added for completeness. Binding doc can be found in:
+ * Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
+ */
+
+pinmux: pinmux@700008d4 {
+	dvfs_pwm_active_state: dvfs_pwm_active {
+		dvfs_pwm_pbb1 {
+			nvidia,pins = "dvfs_pwm_pbb1";
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+		};
+	};
+	dvfs_pwm_inactive_state: dvfs_pwm_inactive {
+		dvfs_pwm_pbb1 {
+			nvidia,pins = "dvfs_pwm_pbb1";
+			nvidia,tristate = <TEGRA_PIN_ENABLE>;
+		};
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
