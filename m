Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0768C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:35:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57A12080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjwKVIDo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Rph6AINk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57A12080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/DLV0yBdLcTOG7J7hdLI8pgZp7NRlO3POVlEhvAg+oU=; b=fjwKVIDoKJ5pDD
	Tbo2Jf6mb0+KmjRir7UGQYmx5Jb7ne0+FEL9Cz46W0P27U/esKBo4kIpG2eTdBAAEp5DsFKjXQW0x
	xm3TrYUl93LHdbdflGKq5UnGA2pzfAo6Se0Amhv4wWjmU6Lf3TYX/vl0KPT7l4h5ZYv8rCEf1rg6/
	GFLKSSUcc5TPwG5AyGabpTEXTNHcFRx9G4uZI6uhN+BzM0rS+Hq5id7WeqdGdj/1Gdb4H+Z9X92mm
	1g6VytJKSNwcguMYnKwfie7moQosN1CEiauX4fYmnTnoSkbehZhGyDsh2mdj8u6LuJ6MSGknFwxyv
	8KDDxujMd7Wu6hdzUz4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNPB-0000bm-TO; Thu, 13 Dec 2018 09:35:41 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNOY-0007H5-S6
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:35:06 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1227b70002>; Thu, 13 Dec 2018 01:34:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 01:34:52 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 01:34:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:34:51 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:34:51 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c1227ba0002>; Thu, 13 Dec 2018 01:34:51 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 01/21] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
Date: Thu, 13 Dec 2018 17:34:18 +0800
Message-ID: <20181213093438.29621-2-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213093438.29621-1-josephl@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544693687; bh=rFGSZ0H3Wp9DaEGcVopw2NZQbBN0zr5+WWCzFUB5efw=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Rph6AINkioD+OWK5CQFJLeKcThEead0L71EmGOoFmmHjTAshbqIQerRYj/puoSIjA
 I1vGXvg5DBScTceJA+sqjqJbCAKqTK3pSpRjy/6p2FuP+HGomGpPGX0zwW+m3yj/wa
 ht9ZZuxmmqknGYKqAGN+xbasenuvKpNc95VbpoIc7mvWzu88yGImIrx5N3UOMlOkNx
 Ny6Ty24qPxb9+l6Au0p8ussgw5B2ptkYJCRmVIEUyWB27TvOe4xfSbJhv8XTTS0lUV
 W9paDq1QoarLVuxFoibbjMkOn4GK1VAFeWQVwX3n7zZVmp0FI76UyOFaEOqWp87Lm8
 gbm6Ieqejm7OQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013502_941824_CA2DEA6C 
X-CRM114-Status: GOOD (  11.19  )
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
