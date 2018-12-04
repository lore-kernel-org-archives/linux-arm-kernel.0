Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB90C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4112920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a7+iUXwA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eV0vFeu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4112920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o9Bji/IwBYVTyQJNEUyC1qYDx4wCFi6ecc1Ff42WHvk=; b=a7+iUXwA0Lz3he
	7iftAf1pI1AUqqwWYqK5hhmCNeX7JeCki4WpGuMG3yglomHv7j/NjuUSyoD0otecpBQMI1g/GYFku
	n40NyfOmzztJqUvF3ZGj9YpJ09yOzMQCwemnWecMuwNcU8XrM1D7cdl7YVBU/B02xALmU4f7Pm4BU
	mts5EfWO5+WKukdHufCtgpsLVwqNJc35R9vBm/SnnlFIj5bgNHruehxhU1xyIVcx5e8bRDefpnmCa
	E2ARjmRu4yoPM7h7AenYOa/5p1ZdaYx8SNb4sjMwUuIQmDtBHxxMrodfud4k/+j1hiJmwoQM8062A
	3CgSAjiRjED01d/KJcxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6yQ-00082L-Mp; Tue, 04 Dec 2018 09:26:34 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yN-00081m-MG
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:26:33 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648480000>; Tue, 04 Dec 2018 01:26:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:30 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 04 Dec 2018 01:26:30 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:30 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648440002>; Tue, 04 Dec 2018 01:26:30 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL binding
 for PWM regulator
Date: Tue, 4 Dec 2018 17:25:30 +0800
Message-ID: <20181204092548.3038-2-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915593; bh=tJnc+qAFHVRJa54L5yE057fC3CXa15Vw8eOrB3IE/70=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=eV0vFeu+TMsgfnsvP9cwRRu6LPbfFF11pHcAOmgI95zB4Xw7PJWjX1AOwP9Lf33Dg
 42RAUoOQben7XGhrCSgS6ZeKYwm4gl0sMQteVq6iQePH1sxhLHPG5MHV4SVQuPjt/s
 90/LBNGtFu5e0qOWKMd1JmXC8jbC4FE9UMljXELKJsG4s3fH1pR+aZbj93KCRV1DJd
 t7XK7bAdQ1MyGH1Zrd7ee7NA/Tzd5LNv0Tya1JRIptpKUWT7qoz53MiUL20uJ+/e5o
 crPnd7Z+RCCs34wejaKAj8oOxtY30LChUBFp2F+Yi4Ux9jflAa5r1x8ZI3mlOGgIpi
 /ZuZEh/Bicxhg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012631_742683_F78F2A47 
X-CRM114-Status: GOOD (  11.60  )
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

Add new properties to configure the DFLL PWM regulator support. Also
add an example and make the I2C clock only required when I2C support is
used.

Cc: devicetree@vger.kernel.org
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 .../bindings/clock/nvidia,tegra124-dfll.txt   | 73 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index dff236f524a7..8c97600d2bad 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
 oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
 control module that will automatically adjust the VDD_CPU voltage by
 communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
-Currently only the I2C mode is supported by these bindings.
 
 Required properties:
 - compatible : should be "nvidia,tegra124-dfll"
@@ -45,10 +44,28 @@ Required properties for the control loop parameters:
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
+- nvidia,init-uv: Regulator voltage in micro volts when PWM control is disabled.
+- nvidia,align-offset-uv: Regulator voltage in micro volts when PWM control is
+			  enabled and PWM output is low.
+- nvidia,align-step-uv: Voltage increase in micro volts corresponding to a
+			1/33th increase in duty cycle. Eg the voltage for 2/33th
+			duty cycle would be:
+			nvidia,align-offset-uv + nvidia,align-step-uv * 2.
+- pinctrl-0: I/O pad configuration when PWM control is enabled.
+- pinctrl-1: I/O pad configuration when PWM control is disabled.
+- pinctrl-names: must include the following entries:
+  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
+  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
+
+Example for I2C:
 
 clock@70110000 {
         compatible = "nvidia,tegra124-dfll";
@@ -76,3 +93,55 @@ clock@70110000 {
 
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
+	nvidia,pwm-to-pmic;
+	nvidia,init-uv = <1000000>;
+	nvidia,align-step-uv = <19200>; /* 19.2mV */
+	nvidia,align-offset-uv = <708000>; /* 708mV */
+	nvidia,sample-rate = <25000>;
+	nvidia,droop-ctrl = <0x00000f00>;
+	nvidia,force-mode = <1>;
+	nvidia,cf = <6>;
+	nvidia,ci = <0>;
+	nvidia,cg = <2>;
+	nvidia,pwm-period = <2500>; /* 2.5us */
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
