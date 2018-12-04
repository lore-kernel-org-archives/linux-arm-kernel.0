Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C965C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA8820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZSMe5bip";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ItgtNHa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA8820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RTXVeQPAkdYAICkpvoYVQ6pQc/idGAPmGn+PRE2gZL8=; b=ZSMe5bipg+Pjqn
	kjoLJkGyXVSUP6SFH0kvpWPazcKmVFBWGvT8qqRfq26t6LLpX83pJq4irtwVynFiT7H4B5QnIFFNm
	7GWkfa0FZ3FILAO6pfTTgRAUuh8z7/EdVfAluSu1FbQ2XpYv7OLIRzyW7cblWnNhrVjWHhbuZI0SO
	0nRmXZYe6LBrOrxmTML0KoOv+RQ3ieGHx3t7V0bG21T1uFKY2OO+sjk2VsaM2z2Q6xR1tPD6E7lZm
	Kf8H/IVTc7ezYRNA0oeyKDhdpa3q4wnArO+JcdHRAqDZePG6o7XUTHk0QE6SLan1pYBYDJaoIP0lr
	0vyg0eQaDdOocYSnLHUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6zL-0000de-TT; Tue, 04 Dec 2018 09:27:31 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yg-0008JV-0G
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:01 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648580000>; Tue, 04 Dec 2018 01:26:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:48 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:26:48 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:48 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648570000>; Tue, 04 Dec 2018 01:26:48 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 06/19] clk: tegra: dfll: CVB calculation alignment with the
 regulator
Date: Tue, 4 Dec 2018 17:25:35 +0800
Message-ID: <20181204092548.3038-7-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915608; bh=+XcDnjn2X0MQX5PdnSMI4QdykdpfPcxcaejusl4gSmA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=ItgtNHa183FzHlT47ji8sSAFeueDt4NKhf9BG/VB7PWajWoDw2CsMpDOlrM6wyuzT
 oEU43wj3SBpBF53V5LtOlRAnDqRUCqLahYb+64NDuq6+fv0adEoyeBmgandcpr9p9J
 CIJLM7mNxAkKDk+wcsmWBA+d7asK8T5Lfrs+dnqyEnKL6DHVOt0Tn8L4rmqnIHIoCc
 91dHVSGZRb/f1YPHimvsQ7gFWYq1MqcPkifcLmRm8XjF5Qc6xtNkr72rviFqovRCMO
 /AeiHKSnPCTTQTjt84vS8yZqieA7/+GhXKEbwxDeS7rv1wMUfCzb2GGg1kVTkC+47i
 SYjkYqVi68iHg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012650_815223_2A460EFD 
X-CRM114-Status: GOOD (  18.74  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CVB table contains calibration data for the CPU DFLL based on
process charaterization. The regulator step and offset parameters depend
on the regulator supplying vdd-cpu , not on the specific Tegra SKU.

When using a PWM controlled regulator, the voltage step and offset are
determined by the regulator type in use. This is specified in DT. When
using an I2C controlled regulator, we can retrieve them from CPU regulator
or DT (if specified). Then pass this information to the CVB table
calculation function.

Based on the work done of "Peter De Schrijver <pdeschrijver@nvidia.com>"
and "Alex Frid <afrid@nvidia.com>".

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.h               |  6 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 65 ++++++++++++++++++++--
 drivers/clk/tegra/cvb.c                    | 12 ++--
 drivers/clk/tegra/cvb.h                    |  6 +-
 4 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
index 83352c8078f2..ecc43cb9b6f1 100644
--- a/drivers/clk/tegra/clk-dfll.h
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -1,6 +1,6 @@
 /*
  * clk-dfll.h - prototypes and macros for the Tegra DFLL clocksource driver
- * Copyright (C) 2013 NVIDIA Corporation.  All rights reserved.
+ * Copyright (C) 2013-2018 NVIDIA Corporation.  All rights reserved.
  *
  * Aleksandr Frid <afrid@nvidia.com>
  * Paul Walmsley <pwalmsley@nvidia.com>
@@ -22,11 +22,14 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
+#include "cvb.h"
+
 /**
  * struct tegra_dfll_soc_data - SoC-specific hooks/integration for the DFLL driver
  * @dev: struct device * that holds the OPP table for the DFLL
  * @max_freq: maximum frequency supported on this SoC
  * @cvb: CPU frequency table for this SoC
+ * @alignment: parameters of the regulator step and offset
  * @init_clock_trimmers: callback to initialize clock trimmers
  * @set_clock_trimmers_high: callback to tune clock trimmers for high voltage
  * @set_clock_trimmers_low: callback to tune clock trimmers for low voltage
@@ -35,6 +38,7 @@ struct tegra_dfll_soc_data {
 	struct device *dev;
 	unsigned long max_freq;
 	const struct cvb_table *cvb;
+	struct rail_alignment alignment;
 
 	void (*init_clock_trimmers)(void);
 	void (*set_clock_trimmers_high)(void);
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 1a2cc113e5c8..071a5c674832 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <soc/tegra/fuse.h>
 
 #include "clk.h"
@@ -50,9 +51,6 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 		.process_id = -1,
 		.min_millivolts = 900,
 		.max_millivolts = 1260,
-		.alignment = {
-			.step_uv = 10000, /* 10mV */
-		},
 		.speedo_scale = 100,
 		.voltage_scale = 1000,
 		.entries = {
@@ -105,11 +103,43 @@ static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
 	{ },
 };
 
+static void get_alignment_from_dt(struct device *dev,
+				  struct rail_alignment *align)
+{
+	align->step_uv = 0;
+	align->offset_uv = 0;
+
+	if (of_property_read_u32(dev->of_node, "nvidia,align-step-uv",
+				  &align->step_uv))
+		align->step_uv = 0;
+
+	if (of_property_read_u32(dev->of_node,
+				"nvidia,align-offset-uv", &align->offset_uv))
+		align->offset_uv = 0;
+}
+
+static int get_alignment_from_regulator(struct device *dev,
+					 struct rail_alignment *align)
+{
+	struct regulator *reg = devm_regulator_get(dev, "vdd-cpu");
+
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	align->offset_uv = regulator_list_voltage(reg, 0);
+	align->step_uv = regulator_get_linear_step(reg);
+
+	devm_regulator_put(reg);
+
+	return 0;
+}
+
 static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 {
 	int process_id, speedo_id, speedo_value, err;
 	struct tegra_dfll_soc_data *soc;
 	const struct dfll_fcpu_data *fcpu_data;
+	struct rail_alignment align;
 
 	fcpu_data = of_device_get_match_data(&pdev->dev);
 	if (!fcpu_data)
@@ -135,12 +165,37 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	get_alignment_from_dt(&pdev->dev, &align);
+	if (of_property_read_bool(pdev->dev.of_node, "nvidia,pwm-to-pmic")
+		 && (!align.step_uv || !align.offset_uv)) {
+		dev_info(&pdev->dev, "Missing required align data in DT");
+		return -EINVAL;
+	} else {
+		if (!align.step_uv) {
+			dev_info(&pdev->dev,
+				 "no align data in DT, try from vdd-cpu\n");
+			err = get_alignment_from_regulator(&pdev->dev, &align);
+			if (err == -EPROBE_DEFER) {
+				dev_info(&pdev->dev,
+					 "defer probe to get vdd-cpu\n");
+				return -EPROBE_DEFER;
+			}
+		}
+	}
+
+	if (!align.step_uv) {
+		dev_err(&pdev->dev, "missing step uv\n");
+		return -EINVAL;
+	}
+
 	soc->max_freq = fcpu_data->cpu_max_freq_table[speedo_id];
 
 	soc->cvb = tegra_cvb_add_opp_table(soc->dev, fcpu_data->cpu_cvb_tables,
 					   fcpu_data->cpu_cvb_tables_size,
-					   process_id, speedo_id, speedo_value,
-					   soc->max_freq);
+					   &align, process_id, speedo_id,
+					   speedo_value, soc->max_freq);
+	soc->alignment = align;
+
 	if (IS_ERR(soc->cvb)) {
 		dev_err(&pdev->dev, "couldn't add OPP table: %ld\n",
 			PTR_ERR(soc->cvb));
diff --git a/drivers/clk/tegra/cvb.c b/drivers/clk/tegra/cvb.c
index da9e8e7b5ce5..81dcb97a9e0a 100644
--- a/drivers/clk/tegra/cvb.c
+++ b/drivers/clk/tegra/cvb.c
@@ -1,7 +1,7 @@
 /*
  * Utility functions for parsing Tegra CVB voltage tables
  *
- * Copyright (C) 2012-2014 NVIDIA Corporation.  All rights reserved.
+ * Copyright (C) 2012-2018 NVIDIA Corporation.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -62,9 +62,9 @@ static int round_voltage(int mv, const struct rail_alignment *align, int up)
 }
 
 static int build_opp_table(struct device *dev, const struct cvb_table *table,
+			   struct rail_alignment *align,
 			   int speedo_value, unsigned long max_freq)
 {
-	const struct rail_alignment *align = &table->alignment;
 	int i, ret, dfll_mv, min_mv, max_mv;
 
 	min_mv = round_voltage(table->min_millivolts, align, UP);
@@ -109,8 +109,9 @@ static int build_opp_table(struct device *dev, const struct cvb_table *table,
  */
 const struct cvb_table *
 tegra_cvb_add_opp_table(struct device *dev, const struct cvb_table *tables,
-			size_t count, int process_id, int speedo_id,
-			int speedo_value, unsigned long max_freq)
+			size_t count, struct rail_alignment *align,
+			int process_id, int speedo_id, int speedo_value,
+			unsigned long max_freq)
 {
 	size_t i;
 	int ret;
@@ -124,7 +125,8 @@ tegra_cvb_add_opp_table(struct device *dev, const struct cvb_table *tables,
 		if (table->process_id != -1 && table->process_id != process_id)
 			continue;
 
-		ret = build_opp_table(dev, table, speedo_value, max_freq);
+		ret = build_opp_table(dev, table, align, speedo_value,
+				      max_freq);
 		return ret ? ERR_PTR(ret) : table;
 	}
 
diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
index c1f077993b2a..bcf15a089b93 100644
--- a/drivers/clk/tegra/cvb.h
+++ b/drivers/clk/tegra/cvb.h
@@ -49,7 +49,6 @@ struct cvb_table {
 
 	int min_millivolts;
 	int max_millivolts;
-	struct rail_alignment alignment;
 
 	int speedo_scale;
 	int voltage_scale;
@@ -59,8 +58,9 @@ struct cvb_table {
 
 const struct cvb_table *
 tegra_cvb_add_opp_table(struct device *dev, const struct cvb_table *cvb_tables,
-			size_t count, int process_id, int speedo_id,
-			int speedo_value, unsigned long max_freq);
+			size_t count, struct rail_alignment *align,
+			int process_id, int speedo_id, int speedo_value,
+			unsigned long max_freq);
 void tegra_cvb_remove_opp_table(struct device *dev,
 				const struct cvb_table *table,
 				unsigned long max_freq);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
