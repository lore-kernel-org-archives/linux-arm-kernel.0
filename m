Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FCA206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fr+W1ekj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FCA206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cnqm8Lbf3/CcwkiiSDqdlbBeWnH7pjf7jCn9XcWN3DE=; b=fr+W1ekjngsWsD
	ZNf0kC/lZtXDvswySoeFwiOkBKrlzh6AGizcwxO7xdn0PJawPaQjJj/yaK6qNxLdq9OtGEtVNHjCi
	wGbc3yrLjOB8G5e4WcB667vDio4I6rtHnVSj9j6A//HFY3G/tlS/EOt3kXg6avwKgXyFe1WrAMhAg
	3oat2pKNq8ydnLtsNHDX2RVvHJl/uLs65fhCxYl+5idmoV2xthPOtHQe2MmOCYrOnntoWv14seNC/
	eWnk69O1M+cqO32w5IvwSY3JvgsaOxTzwfpxw3sPev5rkJu2HTk928432GWKSDzsTQYajS3ZV/69m
	LXjWAkU/1hK8DyURn0Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoYq-00020R-FO; Fri, 14 Dec 2018 14:35:28 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoY3-0008I1-8V
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:34:41 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBEEXEM8026266; Fri, 14 Dec 2018 15:34:22 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p83ydv0pf-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 14 Dec 2018 15:34:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 36FBD34;
 Fri, 14 Dec 2018 14:34:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 194BD52EC;
 Fri, 14 Dec 2018 14:34:22 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:34:21 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:34:21 +0100
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: [PATCH v8 1/6] dt-bindings: mfd: document stpmic1
Thread-Topic: [PATCH v8 1/6] dt-bindings: mfd: document stpmic1
Thread-Index: AQHUk7oa3egoGj+bnkaRLfXgE0IyKA==
Date: Fri, 14 Dec 2018 14:34:21 +0000
Message-ID: <1544798057-1499-2-git-send-email-p.paillet@st.com>
References: <1544798057-1499-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1544798057-1499-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_063439_758215_2DA6D3D3 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Pascal PAILLET-LME <p.paillet@st.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
regulators, 3 power switches, a watchdog and an input for a power on key.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
changes in v8: nothing

 .../devicetree/bindings/mfd/st,stpmic1.txt         | 61 ++++++++++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               | 50 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
new file mode 100644
index 0000000..afd45c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
@@ -0,0 +1,61 @@
+* STMicroelectronics STPMIC1 Power Management IC
+
+Required properties:
+- compatible:		: "st,stpmic1"
+- reg:			: The I2C slave address for the STPMIC1 chip.
+- interrupts:		: The interrupt line the device is connected to.
+- #interrupt-cells:	: Should be 1.
+- interrupt-controller:	: Marks the device node as an interrupt controller.
+			    Interrupt numbers are defined at
+			    dt-bindings/mfd/st,stpmic1.h.
+
+STPMIC1 consists in a varied group of sub-devices.
+Each sub-device binding is be described in own documentation file.
+
+Device			 Description
+------			------------
+st,stpmic1-onkey	: Power on key, see ../input/st,stpmic1-onkey.txt
+st,stpmic1-regulators	: Regulators, see ../regulator/st,stpmic1-regulator.txt
+st,stpmic1-wdt		: Watchdog, see ../watchdog/st,stpmic1-wdt.txt
+
+Example:
+
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+pmic: pmic@33 {
+	compatible = "st,stpmic1";
+	reg = <0x33>;
+	interrupt-parent = <&gpioa>;
+	interrupts = <0 2>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	onkey {
+		compatible = "st,stpmic1-onkey";
+		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+		interrupt-names = "onkey-falling", "onkey-rising";
+		power-off-time-sec = <10>;
+	};
+
+	watchdog {
+		compatible = "st,stpmic1-wdt";
+	};
+
+	regulators {
+		compatible = "st,stpmic1-regulators";
+
+		vdd_core: buck1 {
+			regulator-name = "vdd_core";
+			regulator-boot-on;
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vdd: buck3 {
+			regulator-name = "vdd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-pull-down;
+		};
+	};
diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
new file mode 100644
index 0000000..321cd087
--- /dev/null
+++ b/include/dt-bindings/mfd/st,stpmic1.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#ifndef __DT_BINDINGS_STPMIC1_H__
+#define __DT_BINDINGS_STPMIC1_H__
+
+/* IRQ definitions */
+#define IT_PONKEY_F	0
+#define IT_PONKEY_R	1
+#define IT_WAKEUP_F	2
+#define IT_WAKEUP_R	3
+#define IT_VBUS_OTG_F	4
+#define IT_VBUS_OTG_R	5
+#define IT_SWOUT_F	6
+#define IT_SWOUT_R	7
+
+#define IT_CURLIM_BUCK1	8
+#define IT_CURLIM_BUCK2	9
+#define IT_CURLIM_BUCK3	10
+#define IT_CURLIM_BUCK4	11
+#define IT_OCP_OTG	12
+#define IT_OCP_SWOUT	13
+#define IT_OCP_BOOST	14
+#define IT_OVP_BOOST	15
+
+#define IT_CURLIM_LDO1	16
+#define IT_CURLIM_LDO2	17
+#define IT_CURLIM_LDO3	18
+#define IT_CURLIM_LDO4	19
+#define IT_CURLIM_LDO5	20
+#define IT_CURLIM_LDO6	21
+#define IT_SHORT_SWOTG	22
+#define IT_SHORT_SWOUT	23
+
+#define IT_TWARN_F	24
+#define IT_TWARN_R	25
+#define IT_VINLOW_F	26
+#define IT_VINLOW_R	27
+#define IT_SWIN_F	30
+#define IT_SWIN_R	31
+
+/* BUCK MODES definitions */
+#define STPMIC1_BUCK_MODE_NORMAL 0
+#define STPMIC1_BUCK_MODE_LP 2
+
+#endif /* __DT_BINDINGS_STPMIC1_H__ */
-- 
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
