Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95DBC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C682086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JKQxg/zN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgIg4aNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C682086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=R9S72yzXrdh7Oolq9+kPkxlyVxZmr1t5BSTu9s02pTs=; b=JKQxg/zNfTUDhP4bREsH1v2Tj6
	9Cc09CvQnhfBzjSMvhK2nRILBjk/rq52RM4f0DqFqwxUQ87Q5hjAU+9+V3sNCCUP0Dk0Aw8B6Or+6
	Pc907QoHvIgkHzj5DfG7ELOTn/IY+OcjQSXN7RDCC+G7S9jsbVex3DAS0p0jC2RUTO+3DJW25Cvpl
	AW4rVsV9x7jS6g2O/UF098SyNySfiuoEI3DxSj3GMuJIJ8A0VKpBon4YmMAiqL8+dFmZ7hsThYrut
	RHzWgKOXOd/b+VbjJbT4n3k3BMi+arKW21yZZNjgcGwyhXOJvRWyf9ZA1AV3m0YbznEvwHRB4ywlM
	RtKABK9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5ML-0004aF-5M; Mon, 28 Jan 2019 11:45:49 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5Lq-000488-8P
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:45:21 +0000
Received: by mail-wr1-x441.google.com with SMTP id q18so17659202wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gEin10wITYyCqicq46mLMVeg/RPtwJrVbzK6bPS5rhQ=;
 b=SgIg4aNfIY6ktUvXinoIGmO4ZeY8EblDbNTHZpaZANAm/nn+VharupMi+feQnMaSeC
 aCIegvxWIUBi1gjpkwgQblDuUlN/VOfNQcviFQbBIGytbly0qpeZg7G0o8ea1ufFtRri
 +wA9DdWsFJby8DtlnbeZsFcq0QiHJ7RMH2AKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gEin10wITYyCqicq46mLMVeg/RPtwJrVbzK6bPS5rhQ=;
 b=miQm31eOlxIpp+Adbf8slNzDJ17T9crqCaJGNPNNlQGTl4hs54yecmB0wPDtHN+fNI
 L7T9m0YQUy9QLb8wXcPyyx7Q8QOAJkDmQPZKJqcFGDBL7hIhPI+OPPX1gYmBy6YKhQ5d
 tVJHQzbsjx6Eb4Pm2Q/K4PVSrKyssmF5IduIonPOewYsNocUHyfQs9t+EvrF7xkLbSrH
 pfbrYzi52WMAFFRVWBN+qvRFAhuzPkGJxc9/4ASDCSmcao7QPrO0qfDxTEw5YB2V8lx1
 YdZ8AtmQOcxWXxeocYqezeVj2dfXF9IPNeHpDD7Zf2v49xYy3GvNcSa7NR7YkrVA5RwD
 EKqA==
X-Gm-Message-State: AJcUuke9G/zUvZn2lM1aX1FS0e9erLji/haUROgCc+QZtryGDcQ3yf+W
 EJmQoGnRpfagB2onxMmUJSGpcA==
X-Google-Smtp-Source: ALg8bN4kjKdJv1H1If6fssP4bW5Fwr293GNNyNh9LDOrRxY3LfZjRegZzTiKWZ7lW56Vek3cKqcmuw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr22011837wro.262.1548675916193; 
 Mon, 28 Jan 2019 03:45:16 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 03:45:15 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
Date: Mon, 28 Jan 2019 12:45:03 +0100
Message-Id: <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_034518_305887_F1EC8ECD 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: devicetree@vger.kernel.org, vinod.koul@linaro.org,
 linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The PMS405 has 5 HFSMPS and 13 LDO regulators,

This commit adds support for one of the 5 HFSMPS regulators (s3) to
the spmi regulator driver.

The PMIC HFSMPS 430 regulators have 8 mV step size and a voltage
control scheme consisting of two  8-bit registers defining a 16-bit
voltage set point in units of millivolts

S3 controls the cpu voltages (s3 is a buck regulator of type HFS430);
it is therefore required so we can enable voltage scaling for safely
running cpufreq.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 197 +++++++++++++++++++++++++++++---
 1 file changed, 180 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 53a61fb..6b8dc9c 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -99,6 +99,7 @@ enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_VS,
 	SPMI_REGULATOR_LOGICAL_TYPE_BOOST,
 	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS,
+	SPMI_REGULATOR_LOGICAL_TYPE_HFS430,
 	SPMI_REGULATOR_LOGICAL_TYPE_BOOST_BYP,
 	SPMI_REGULATOR_LOGICAL_TYPE_LN_LDO,
 	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS,
@@ -120,6 +121,7 @@ enum spmi_regulator_type {
 enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_GP_CTL		= 0x08,
 	SPMI_REGULATOR_SUBTYPE_RF_CTL		= 0x09,
+	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
 	SPMI_REGULATOR_SUBTYPE_N50		= 0x01,
 	SPMI_REGULATOR_SUBTYPE_N150		= 0x02,
 	SPMI_REGULATOR_SUBTYPE_N300		= 0x03,
@@ -183,6 +185,12 @@ enum spmi_boost_byp_registers {
 	SPMI_BOOST_BYP_REG_CURRENT_LIMIT	= 0x4b,
 };
 
+enum spmi_hfs430_registers {
+	SPMI_HFS430_REG_VOLTAGE_LB		= 0x40,
+	SPMI_HFS430_REG_VOLTAGE_VALID_LB	= 0x42,
+	SPMI_HFS430_REG_MODE			= 0x45,
+};
+
 enum spmi_saw3_registers {
 	SAW3_SECURE				= 0x00,
 	SAW3_ID					= 0x04,
@@ -260,20 +268,61 @@ enum spmi_common_control_register_index {
 #define SPMI_FTSMPS_STEP_CTRL_DELAY_MASK	0x07
 #define SPMI_FTSMPS_STEP_CTRL_DELAY_SHIFT	0
 
-/* Clock rate in kHz of the FTSMPS regulator reference clock. */
+#define SPMI_HFS430_STEP_CTRL_STEP_MASK		0
+#define SPMI_HFS430_STEP_CTRL_STEP_SHIFT	0
+#define SPMI_HFS430_STEP_CTRL_DELAY_MASK	0x3
+#define SPMI_HFS430_STEP_CTRL_DELAY_SHIFT	0
+
+/* Clock rate in kHz of the FTSMPS and HFS430 regulator reference clocks. */
 #define SPMI_FTSMPS_CLOCK_RATE		19200
+#define SPMI_HFS430_CLOCK_RATE		1600
 
 /* Minimum voltage stepper delay for each step. */
 #define SPMI_FTSMPS_STEP_DELAY		8
+#define SPMI_HFS430_STEP_DELAY		2
 #define SPMI_DEFAULT_STEP_DELAY		20
 
 /*
- * The ratio SPMI_FTSMPS_STEP_MARGIN_NUM/SPMI_FTSMPS_STEP_MARGIN_DEN is used to
+ * The ratio SPMI_xxxxx_STEP_MARGIN_NUM/SPMI_xxxxx_STEP_MARGIN_DEN is used to
  * adjust the step rate in order to account for oscillator variance.
  */
 #define SPMI_FTSMPS_STEP_MARGIN_NUM	4
 #define SPMI_FTSMPS_STEP_MARGIN_DEN	5
 
+#define SPMI_HFS430_STEP_MARGIN_NUM	10
+#define SPMI_HFS430_STEP_MARGIN_DEN	11
+
+#define SPMI_STEP_MASK(__x)	SPMI_##__x##_STEP_CTRL_STEP_MASK
+#define SPMI_STEP_SHIFT(__x)	SPMI_##__x##_STEP_CTRL_STEP_SHIFT
+#define SPMI_DELAY_MASK(__x)	SPMI_##__x##_STEP_CTRL_DELAY_MASK
+#define SPMI_DELAY_SHIFT(__x)	SPMI_##__x##_STEP_CTRL_DELAY_SHIFT
+#define SPMI_CLOCK_RATE(__x)	SPMI_##__x##_CLOCK_RATE
+#define SPMI_STEP_DELAY(__x)	SPMI_##__x##_STEP_DELAY
+#define SPMI_MARGIN_NUM(__x)	SPMI_##__x##_STEP_MARGIN_NUM
+#define SPMI_MARGIN_DEN(__x)	SPMI_##__x##_STEP_MARGIN_DEN
+
+struct slew_rate_config {
+	unsigned int delay_mask;
+	unsigned int delay_shift;
+	unsigned int step_mask;
+	unsigned int step_shift;
+	unsigned int margin_num;
+	unsigned int margin_den;
+	unsigned int step_delay;
+	unsigned int clock_rate;
+};
+
+#define SLEW_RATE_CONFIG(x)  {			\
+	.delay_shift = SPMI_DELAY_SHIFT(x),	\
+	.delay_mask = SPMI_DELAY_MASK(x),	\
+	.step_shift = SPMI_STEP_SHIFT(x),	\
+	.step_mask = SPMI_STEP_MASK(x),		\
+	.margin_num = SPMI_MARGIN_NUM(x),	\
+	.margin_den = SPMI_MARGIN_DEN(x),	\
+	.step_delay = SPMI_STEP_DELAY(x),	\
+	.clock_rate = SPMI_CLOCK_RATE(x),	\
+}
+
 /* VSET value to decide the range of ULT SMPS */
 #define ULT_SMPS_RANGE_SPLIT 0x60
 
@@ -472,6 +521,11 @@ static struct spmi_voltage_range ult_pldo_ranges[] = {
 	SPMI_VOLTAGE_RANGE(0, 1750000, 1750000, 3337500, 3337500, 12500),
 };
 
+/* must be only one range */
+static struct spmi_voltage_range hfs430_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 320000, 320000, 2040000, 2040000, 8000),
+};
+
 static DEFINE_SPMI_SET_POINTS(pldo);
 static DEFINE_SPMI_SET_POINTS(nldo1);
 static DEFINE_SPMI_SET_POINTS(nldo2);
@@ -486,6 +540,7 @@ static DEFINE_SPMI_SET_POINTS(ult_lo_smps);
 static DEFINE_SPMI_SET_POINTS(ult_ho_smps);
 static DEFINE_SPMI_SET_POINTS(ult_nldo);
 static DEFINE_SPMI_SET_POINTS(ult_pldo);
+static DEFINE_SPMI_SET_POINTS(hfs430);
 
 static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
 				 int len)
@@ -653,6 +708,10 @@ spmi_regulator_find_range(struct spmi_regulator *vreg)
 	range = vreg->set_points->range;
 	end = range + vreg->set_points->count;
 
+	/* we know we only have one range for this type */
+	if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
+		return range;
+
 	spmi_vreg_read(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, &range_sel, 1);
 
 	for (; range < end; range++)
@@ -1135,6 +1194,82 @@ spmi_regulator_saw_set_voltage(struct regulator_dev *rdev, unsigned selector)
 					&voltage_sel, true);
 }
 
+#define SPMI_HFS430_MODE_PWM	0x07
+#define SPMI_HFS430_MODE_AUTO	0x06
+
+static unsigned int spmi_regulator_hfs430_get_mode(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 reg;
+	int ret;
+
+	ret = spmi_vreg_read(vreg, SPMI_HFS430_REG_MODE, &reg, 1);
+	if (ret) {
+		dev_err(&rdev->dev, "failed to get mode");
+		return ret;
+	}
+
+	if (reg == SPMI_HFS430_MODE_PWM)
+		return REGULATOR_MODE_NORMAL;
+
+	return REGULATOR_MODE_IDLE;
+}
+
+static int spmi_regulator_hfs430_set_mode(struct regulator_dev *rdev,
+					  unsigned int mode)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 reg = mode == REGULATOR_MODE_NORMAL ? SPMI_HFS430_MODE_PWM :
+						 SPMI_HFS430_MODE_AUTO;
+
+	return spmi_vreg_write(vreg, SPMI_HFS430_REG_MODE, &reg, 1);
+}
+
+int spmi_regulator_hfs430_get_voltage(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 val[2];
+	int ret, uV;
+
+	ret = spmi_vreg_read(vreg, SPMI_HFS430_REG_VOLTAGE_VALID_LB, val, 2);
+	if (ret) {
+		dev_err(&rdev->dev, "failed to get voltage");
+		return ret;
+	}
+
+	uV = 1000 * (((unsigned int) val[1] << 8) | val[0]);
+	dev_dbg(&rdev->dev, "read = %d", uV);
+
+	return uV;
+}
+
+static int spmi_regulator_hfs430_set_voltage(struct regulator_dev *rdev,
+					     unsigned selector)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	const struct spmi_voltage_range *range;
+	int uV, vlevel;
+	u8 val[2];
+
+	range = spmi_regulator_find_range(vreg);
+	if (!range)
+		return -EINVAL;
+
+	uV = spmi_regulator_common_list_voltage(rdev, selector);
+	if (uV <= 0)
+		return uV;
+
+	vlevel = roundup(uV, range->step_uV) / 1000;
+
+	dev_dbg(&rdev->dev, "write (%d, %d), mode (%d)", uV, vlevel,
+		spmi_regulator_hfs430_get_mode(rdev));
+
+	val[0] = vlevel & 0xFF;
+	val[1] = (vlevel >> 8) & 0xFF;
+
+	return spmi_vreg_write(vreg, SPMI_HFS430_REG_VOLTAGE_LB, val, 2);
+}
+
 static struct regulator_ops spmi_saw_ops = {};
 
 static struct regulator_ops spmi_smps_ops = {
@@ -1264,12 +1399,24 @@ static struct regulator_ops spmi_ult_ldo_ops = {
 	.set_soft_start		= spmi_regulator_common_set_soft_start,
 };
 
+static struct regulator_ops spmi_hfs430_ops = {
+	/* always on regulators */
+	.set_voltage_sel	= spmi_regulator_hfs430_set_voltage,
+	.set_voltage_time_sel	= spmi_regulator_set_voltage_time_sel,
+	.get_voltage		= spmi_regulator_hfs430_get_voltage,
+	.map_voltage		= spmi_regulator_common_map_voltage,
+	.list_voltage		= spmi_regulator_common_list_voltage,
+	.get_mode		= spmi_regulator_hfs430_get_mode,
+	.set_mode		= spmi_regulator_hfs430_set_mode,
+};
+
 /* Maximum possible digital major revision value */
 #define INF 0xFF
 
 static const struct spmi_regulator_mapping supported_regulators[] = {
-	/*           type subtype dig_min dig_max ltype ops setpoints hpm_min */
+	/*        type subtype dig_min dig_max ltype ops setpoints hpm_min */
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
+	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
 	SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
 	SPMI_VREG(LDO,   N600,     0,   0, LDO,    ldo,    nldo2,   10000),
 	SPMI_VREG(LDO,   N1200,    0,   0, LDO,    ldo,    nldo2,   10000),
@@ -1396,8 +1543,12 @@ static int spmi_regulator_init_slew_rate(struct spmi_regulator *vreg)
 {
 	int ret;
 	u8 reg = 0;
-	int step, delay, slew_rate, step_delay;
+	int step, delay, slew_rate;
 	const struct spmi_voltage_range *range;
+	struct slew_rate_config *config, configs[] = {
+		[0] = SLEW_RATE_CONFIG(HFS430),
+		[1] = SLEW_RATE_CONFIG(FTSMPS),
+	};
 
 	ret = spmi_vreg_read(vreg, SPMI_COMMON_REG_STEP_CTRL, &reg, 1);
 	if (ret) {
@@ -1410,25 +1561,26 @@ static int spmi_regulator_init_slew_rate(struct spmi_regulator *vreg)
 		return -EINVAL;
 
 	switch (vreg->logical_type) {
-	case SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS:
-		step_delay = SPMI_FTSMPS_STEP_DELAY;
+	case SPMI_REGULATOR_LOGICAL_TYPE_HFS430:
+		config = &configs[0];
 		break;
 	default:
-		step_delay = SPMI_DEFAULT_STEP_DELAY;
-		break;
-	}
+		config = &configs[1];
+		if (vreg->logical_type != SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS)
+			config->step_delay =  SPMI_STEP_DELAY(DEFAULT);
+	};
 
-	step = reg & SPMI_FTSMPS_STEP_CTRL_STEP_MASK;
-	step >>= SPMI_FTSMPS_STEP_CTRL_STEP_SHIFT;
+	step = reg & config->step_mask;
+	step >>= config->step_shift;
 
-	delay = reg & SPMI_FTSMPS_STEP_CTRL_DELAY_MASK;
-	delay >>= SPMI_FTSMPS_STEP_CTRL_DELAY_SHIFT;
+	delay = reg & config->delay_mask;
+	delay >>= config->delay_shift;
 
 	/* slew_rate has units of uV/us */
-	slew_rate = SPMI_FTSMPS_CLOCK_RATE * range->step_uV * (1 << step);
-	slew_rate /= 1000 * (step_delay << delay);
-	slew_rate *= SPMI_FTSMPS_STEP_MARGIN_NUM;
-	slew_rate /= SPMI_FTSMPS_STEP_MARGIN_DEN;
+	slew_rate = config->clock_rate * range->step_uV * (1 << step);
+	slew_rate /= 1000 * (config->step_delay << delay);
+	slew_rate *= config->margin_num;
+	slew_rate /= config->margin_den;
 
 	/* Ensure that the slew rate is greater than 0 */
 	vreg->slew_rate = max(slew_rate, 1);
@@ -1445,6 +1597,9 @@ static int spmi_regulator_init_registers(struct spmi_regulator *vreg,
 
 	type = vreg->logical_type;
 
+	if (type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
+		return 0;
+
 	ret = spmi_vreg_read(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, ctrl_reg, 8);
 	if (ret)
 		return ret;
@@ -1572,9 +1727,11 @@ static int spmi_regulator_of_parse(struct device_node *node,
 	case SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS:
 	case SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS:
 	case SPMI_REGULATOR_LOGICAL_TYPE_SMPS:
+	case SPMI_REGULATOR_LOGICAL_TYPE_HFS430:
 		ret = spmi_regulator_init_slew_rate(vreg);
 		if (ret)
 			return ret;
+
 	default:
 		break;
 	}
@@ -1731,12 +1888,18 @@ static const struct spmi_regulator_data pmi8994_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pms405_regulators[] = {
+	{ "s3", 0x1a00, }, /* supply name in the dts only */
+	{ }
+};
+
 static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm8841-regulators", .data = &pm8841_regulators },
 	{ .compatible = "qcom,pm8916-regulators", .data = &pm8916_regulators },
 	{ .compatible = "qcom,pm8941-regulators", .data = &pm8941_regulators },
 	{ .compatible = "qcom,pm8994-regulators", .data = &pm8994_regulators },
 	{ .compatible = "qcom,pmi8994-regulators", .data = &pmi8994_regulators },
+	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
