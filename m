Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F57CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7E8218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5iALuaM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OiJm/PJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7E8218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=63fKUW+Raxp5e2iSmqYIdeUJCY58lXIPSihcj1shchc=; b=c5iALuaMOTwv0/
	DtESMH2U4seu9lF6iSsoRy47bBWIHfdpCk4tQbKfFyJ3k4bPfpleYvcFcUuqfZTBR7D2Kz8vJiAlN
	xzfrSWX6puL6rQspPKLrYhOy6iZCGDEvolXBngHSITP1ziDsR5S7AnbtPFGZ8rrhY0FR4sI/OfONt
	Fs6ZWBiEgwIJjn/3WSHsJdhzjq46ewcZk4kYT2fJ3mhvfQs2D+lN2M6nnn84NInjo9B9Fa0ew7Wol
	35z1BvPPBecapuAvYcwMQSYOYgR/cmZgwDRa7tZSklwQV9rnY/C8f0ZHDRZ2oWLxxCqsxKjQ6IsGK
	V02aAsz5NvJDETTu5nHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtz1R-0004fT-Sv; Wed, 13 Feb 2019 18:12:37 +0000
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz1M-0004dy-PV
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApwFb5/sT5KkD71pIt20eGXPdTDML+CVY9yfHsMaOI8=;
 b=OiJm/PJ57fWWOm+hpnCuSnZuDLjNfY5XMvQ8IRx+5YWHWICEthEM73+rm78we6qbdDsDG5aaKRc4F2llgqO4sHf11PfGTj4d2QJO9kUvjIJ58RsntZD3JXFpOhfVSc9Axe8rPom4ia+qpjDgm1d+WcryyRDaJwrm3GkLzdtbJec=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB6223.eurprd04.prod.outlook.com (20.179.26.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 18:12:28 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 18:12:27 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V3 1/4] drivers/perf: imx_ddr: Add ddr performance counter
 support
Thread-Topic: [PATCH V3 1/4] drivers/perf: imx_ddr: Add ddr performance
 counter support
Thread-Index: AQHUw8etuwfer1253kmEHqnHL4Ypig==
Date: Wed, 13 Feb 2019 18:12:27 +0000
Message-ID: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:805:3e::49) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f270e6-704f-4d4c-9ad3-08d691decfd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6223; 
x-ms-traffictypediagnostic: VI1PR04MB6223:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6223;
 23:IC/cAyQKfPOoBqFmSAyyWli/408nztTOtBthii+?=
 =?iso-8859-1?Q?9DH0M/UjGh/IktnF1pIgrBS/anGEb/EDXQeXQkuDlCtauHOzJ/JTBXu7ch?=
 =?iso-8859-1?Q?iw7+qMw9JxLHKg3ns2glmhFw002GlZWciFmyPFPGzKL7rhz7j3Y8oUHLyr?=
 =?iso-8859-1?Q?ItdDvLVhaecpBEc2WJLLZbyauSUx+Fak3oKMqOii28eYlUEl87Ip8cY9jb?=
 =?iso-8859-1?Q?3ooLlnJRrDr0/32Hd7UtehZFZiN7Q4R8tFKQF1iuc29nxR2YZjC4fWbw5D?=
 =?iso-8859-1?Q?mBULjGNq4bQpylkEkJtDzfMNDP5PpRzwrfRAYsA0pALODOcNs33ZD78c0U?=
 =?iso-8859-1?Q?xwJtaGZl7maWdfapft9PXLRgqq+yH7cYSCgs/mChQ9N6ax3OB4M/TtgGTH?=
 =?iso-8859-1?Q?9yx3eXTrr+3rqJ1ChV62dMIt4mrM+AM4KgRACGCOvQUfM60tGBmGMpyXTC?=
 =?iso-8859-1?Q?ZOX9qlDTY51GJI7xwmmVazAIknhIe/T6XtTeNGYlaBzuVemgy8l6igZNx+?=
 =?iso-8859-1?Q?h/kGMA4c4Gc0qV3aClFXyAJYSakZKVJsu+sBZql80vHSe/Bb4zr0b7Y0sz?=
 =?iso-8859-1?Q?LaFxMx5DpzKDBAQUV0MA0T94xNZ08UjnWei2zbaBEXijXJCx1ajtsqvANs?=
 =?iso-8859-1?Q?8/tvpXO81qNApcAxLU2cFKX6/QTvcymOJqgFRQH5rPn4q98zAnCGzepO3b?=
 =?iso-8859-1?Q?lK/ezIyMaxVxC5+23G1FtMmXcxQaHgIOXHixQ/XUnUefvz4tD2vxlr9TXx?=
 =?iso-8859-1?Q?1TMv2GaKYJrslbdZ1mVPZiWK8dcZT4PEqUG+mfsZtTUos0bWS9WLop0K/2?=
 =?iso-8859-1?Q?La5K5tRjmu9gSITcnO6bFtGmlDIoEmc44c73ZAQTA/NiAHJzNNr3D7+SUY?=
 =?iso-8859-1?Q?C/zKGmOwzpyEINNmfFIx0A46QcL3kFXMu8m1RUCGaZKWtiRDtV+qcUj6+9?=
 =?iso-8859-1?Q?KXpwwB2rpB/mOAHiXsIwKb0cdk0ofkOshaDQp8h/JNYNBrlodTOcs+5YR8?=
 =?iso-8859-1?Q?6m6rSPZjOkw8VZafuUkWwcLkvHuVOhhK0U07J7T4iA8yRnLomAPZ5CSOf2?=
 =?iso-8859-1?Q?XTDEJ6uNrHJ0sdTLdKZZd0dFlKGiWrNnKBQfNVc36sgawfM5pD5SiHOgtD?=
 =?iso-8859-1?Q?FStph1DwNToG5ugbK8mfYF9D9jO0pfss4XJN2H/+rrT4rCeSY3bYyFKmLR?=
 =?iso-8859-1?Q?J5cRl3RkQLTEHzcvslrzV2uOglbE9KLgpknKg7gGdmq1XfrKocyTTiSU05?=
 =?iso-8859-1?Q?XrWgnqY6fkpCtXT8o4/r5H4VdU7kJhinMoXDPb+jKI50XscvPt1aAWAz6/?=
 =?iso-8859-1?Q?1wFuEr6yF5K/drxYg3o4T19?=
x-microsoft-antispam-prvs: <VI1PR04MB62239DE842199C02108CFBFD88660@VI1PR04MB6223.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6436002)(2616005)(66066001)(52116002)(2906002)(99286004)(6486002)(386003)(478600001)(102836004)(256004)(53946003)(26005)(186003)(53936002)(6506007)(7416002)(5024004)(14444005)(36756003)(2501003)(110136005)(316002)(476003)(486006)(68736007)(6512007)(105586002)(14454004)(106356001)(86362001)(25786009)(30864003)(2201001)(50226002)(8936002)(71190400001)(71200400001)(4326008)(305945005)(7736002)(8676002)(97736004)(81156014)(6116002)(81166006)(3846002)(921003)(1121003)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6223;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mmwzw1u6oK7WDWxnnbUFcaTYF81HyUIMWvMWyc/Wt7pPxPmco6iadxuWxu64HUqSjgHVl0FSJ9JOjmSP+RUblCHYcPM7L0NyI/JOMZ1mZc1Z41S3tX2GN6j0B8aV/s8t9EkzmIbNLgDzQCq4AdcQVhGHqd1VCTSoFFUwljkWyTB4AsUxEK4C0ozG/B3/Q1XypXRlKhpAusNMyPAVORQ4V0ZNYCKw2J75hhPPEg9eg1B7qCbFobtzvHl5tM9Ps1a23UGp38kTbsQVtVEeL/5GJWrDMRugw+YDuS+spGUi7yckp9DDHdmftPZmo0AxflLYR+/82NMGXc6F0h90l/BrtTXvIof4XV9/kc3T9GGOWHamw+9dTa+0sRus9N48YDzQbab3QVyyO6ytcuPzY2/ARQsYCAQWY5n3ZEFdKZa/mWk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f270e6-704f-4d4c-9ad3-08d691decfd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 18:12:25.3864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6223
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_101233_044217_0B7E263C 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

event 41: axid-read and event 42: axi-write support count only
for special axi id. config1 is axi master id. please refer chip
manual to get axi master id information.

event 'cycles' must be enabled because hardware requirement.

Add ddr performance monitor support for iMX8QXP.
Support below events.

  ddr0/activate/                                     [Kernel PMU event]
  ddr0/axid-read/                                    [Kernel PMU event]
  ddr0/axid-write/                                   [Kernel PMU event]
  ddr0/cycles/                                       [Kernel PMU event]
  ddr0/hp-read-credit-cnt/                           [Kernel PMU event]
  ddr0/hp-read/                                      [Kernel PMU event]
  ddr0/hp-req-nodcredit/                             [Kernel PMU event]
  ddr0/hp-xact-credit/                               [Kernel PMU event]
  ddr0/load-mode/                                    [Kernel PMU event]
  ddr0/lp-read-credit-cnt/                           [Kernel PMU event]
  ddr0/lp-req-nocredit/                              [Kernel PMU event]
  ddr0/lp-xact-credit/                               [Kernel PMU event]
  ddr0/mwr/                                          [Kernel PMU event]
  ddr0/precharge/                                    [Kernel PMU event]
  ddr0/raw-hazard/                                   [Kernel PMU event]
  ddr0/read-access/                                  [Kernel PMU event]
  ddr0/read-activate/                                [Kernel PMU event]
  ddr0/read-command/                                 [Kernel PMU event]
  ddr0/read-cycles/                                  [Kernel PMU event]
  ddr0/read-modify-write-command/                    [Kernel PMU event]
  ddr0/read-queue-depth/                             [Kernel PMU event]
  ddr0/read-write-transition/                        [Kernel PMU event]
  ddr0/read/                                         [Kernel PMU event]
  ddr0/refresh/                                      [Kernel PMU event]
  ddr0/selfresh/                                     [Kernel PMU event]
  ddr0/wr-xact-credit/                               [Kernel PMU event]
  ddr0/write-access/                                 [Kernel PMU event]
  ddr0/write-command/                                [Kernel PMU event]
  ddr0/write-credit-cnt/                             [Kernel PMU event]
  ddr0/write-cycles/                                 [Kernel PMU event]
  ddr0/write-queue-depth/                            [Kernel PMU event]
  ddr0/write/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
 * remove kfree

Change from V1 to V2
 * update Kconfig by use i.MX8 instead of i.MX8 QXP
 * remove gpl statememnt since SPDX tag
 * use dev_kzalloc
 * use dev_err
 * commit message show axi_read 0x41\axi_write 0x42
 * commit message show cycles must be enabled
 * Irq only issue at cycles overflow
 * use NUM_COUNTER
 * use devm_request_irq
 * add hotplug callback to handle context migration

 drivers/perf/Kconfig             |   7 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/fsl_imx8_ddr_perf.c | 570 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 578 insertions(+)
 create mode 100644 drivers/perf/fsl_imx8_ddr_perf.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index af9bc17..6e279e6 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -61,6 +61,13 @@ config ARM_DSU_PMU
 	  system, control logic. The PMU allows counting various events related
 	  to DSU.
 
+config FSL_IMX8_DDR_PERF
+	tristate "Freescale i.MX8 DDR perf monitor"
+	depends on ARCH_MXC
+	  help
+	  Provides support for ddr perfomance monitor in i.MX8. Provide memory
+	  througput information.
+
 config HISI_PMU
        bool "HiSilicon SoC PMU"
        depends on ARM64 && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 909f27f..f832de7 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_FSL_IMX8_DDR_PERF) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
new file mode 100644
index 0000000..a15bb46
--- /dev/null
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2017 NXP
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#define COUNTER_CNTL		0x0
+#define COUNTER_READ		0x20
+
+#define COUNTER_DPCR1		0x30
+
+#define CNTL_OVER		0x1
+#define CNTL_CLEAR		0x2
+#define CNTL_EN			0x4
+#define CNTL_EN_MASK		0xFFFFFFFB
+#define CNTL_CLEAR_MASK		0xFFFFFFFD
+#define CNTL_OVER_MASK		0xFFFFFFFE
+
+#define CNTL_CSV_SHIFT		24
+#define CNTL_CSV_MASK		(0xFF << CNTL_CSV_SHIFT)
+
+#define EVENT_CYCLES_ID		0
+#define EVENT_CYCLES_COUNTER	0
+#define NUM_COUNTER		4
+#define MAX_EVENT		3
+
+#define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
+
+#define DDR_PERF_DEV_NAME	"ddr_perf"
+
+static DEFINE_IDA(ddr_ida);
+
+PMU_EVENT_ATTR_STRING(cycles, ddr_perf_cycles, "event=0x00");
+PMU_EVENT_ATTR_STRING(selfresh, ddr_perf_selfresh, "event=0x01");
+PMU_EVENT_ATTR_STRING(read-access, ddr_perf_read_accesses, "event=0x04");
+PMU_EVENT_ATTR_STRING(write-access, ddr_perf_write_accesses, "event=0x05");
+PMU_EVENT_ATTR_STRING(read-queue-depth, ddr_perf_read_queue_depth,
+		"event=0x08");
+PMU_EVENT_ATTR_STRING(write-queue-depth, ddr_perf_write_queue_depth,
+		"event=0x09");
+PMU_EVENT_ATTR_STRING(lp-read-credit-cnt, ddr_perf_lp_read_credit_cnt,
+		"event=0x10");
+PMU_EVENT_ATTR_STRING(hp-read-credit-cnt, ddr_perf_hp_read_credit_cnt,
+		"event=0x11");
+PMU_EVENT_ATTR_STRING(write-credit-cnt, ddr_perf_write_credit_cnt,
+		"event=0x12");
+PMU_EVENT_ATTR_STRING(read-command, ddr_perf_read_command, "event=0x20");
+PMU_EVENT_ATTR_STRING(write-command, ddr_perf_write_command, "event=0x21");
+PMU_EVENT_ATTR_STRING(read-modify-write-command,
+		ddr_perf_read_modify_write_command, "event=0x22");
+PMU_EVENT_ATTR_STRING(hp-read, ddr_perf_hp_read, "event=0x23");
+PMU_EVENT_ATTR_STRING(hp-req-nodcredit, ddr_perf_hp_req_nocredit, "event=0x24");
+PMU_EVENT_ATTR_STRING(hp-xact-credit, ddr_perf_hp_xact_credit, "event=0x25");
+PMU_EVENT_ATTR_STRING(lp-req-nocredit, ddr_perf_lp_req_nocredit, "event=0x26");
+PMU_EVENT_ATTR_STRING(lp-xact-credit, ddr_perf_lp_xact_credit, "event=0x27");
+PMU_EVENT_ATTR_STRING(wr-xact-credit, ddr_perf_wr_xact_credit, "event=0x29");
+PMU_EVENT_ATTR_STRING(read-cycles, ddr_perf_read_cycles, "event=0x2a");
+PMU_EVENT_ATTR_STRING(write-cycles, ddr_perf_write_cycles, "event=0x2b");
+PMU_EVENT_ATTR_STRING(read-write-transition, ddr_perf_read_write_transition,
+		"event=0x30");
+PMU_EVENT_ATTR_STRING(precharge, ddr_perf_precharge, "event=0x31");
+PMU_EVENT_ATTR_STRING(activate, ddr_perf_activate, "event=0x32");
+PMU_EVENT_ATTR_STRING(load-mode, ddr_perf_load_mode, "event=0x33");
+PMU_EVENT_ATTR_STRING(mwr, ddr_perf_mwr, "event=0x34");
+PMU_EVENT_ATTR_STRING(read, ddr_perf_read, "event=0x35");
+PMU_EVENT_ATTR_STRING(read-activate, ddr_perf_read_activate, "event=0x36");
+PMU_EVENT_ATTR_STRING(refresh, ddr_perf_refresh, "event=0x37");
+PMU_EVENT_ATTR_STRING(write, ddr_perf_write, "event=0x38");
+PMU_EVENT_ATTR_STRING(raw-hazard, ddr_perf_raw_hazard, "event=0x39");
+
+PMU_EVENT_ATTR_STRING(axid-read, ddr_perf_axid_read, "event=0x41");
+PMU_EVENT_ATTR_STRING(axid-write, ddr_perf_axid_write, "event=0x42");
+
+#define DDR_CAP_AXI_ID 0x1
+
+struct fsl_ddr_devtype_data {
+	unsigned int flags;
+};
+
+static const struct fsl_ddr_devtype_data imx8_data;
+static const struct fsl_ddr_devtype_data imx8m_data = {
+	.flags = DDR_CAP_AXI_ID,
+};
+
+static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
+	{ .compatible = "fsl,imx8-ddr-pmu", .data = (void *)&imx8_data},
+	{ .compatible = "fsl,imx8m-ddr-pmu", .data = (void *)&imx8m_data},
+	{ /* sentinel */ }
+};
+
+struct ddr_pmu {
+	struct pmu pmu;
+	void __iomem *base;
+	cpumask_t cpu;
+	struct	hlist_node node;
+	struct	device *dev;
+	struct perf_event *active_events[NUM_COUNTER];
+	int total_events;
+	enum cpuhp_state cpuhp_state;
+	bool cycles_active;
+	struct fsl_ddr_devtype_data *devtype;
+};
+
+static ssize_t ddr_perf_cpumask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->cpu);
+}
+
+static struct device_attribute ddr_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, ddr_perf_cpumask_show, NULL);
+
+static struct attribute *ddr_perf_cpumask_attrs[] = {
+	&ddr_perf_cpumask_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ddr_perf_cpumask_attr_group = {
+	.attrs = ddr_perf_cpumask_attrs,
+};
+
+static struct attribute *ddr_perf_events_attrs[] = {
+	&ddr_perf_cycles.attr.attr,
+	&ddr_perf_selfresh.attr.attr,
+	&ddr_perf_read_accesses.attr.attr,
+	&ddr_perf_write_accesses.attr.attr,
+	&ddr_perf_read_queue_depth.attr.attr,
+	&ddr_perf_write_queue_depth.attr.attr,
+	&ddr_perf_lp_read_credit_cnt.attr.attr,
+	&ddr_perf_hp_read_credit_cnt.attr.attr,
+	&ddr_perf_write_credit_cnt.attr.attr,
+	&ddr_perf_read_command.attr.attr,
+	&ddr_perf_write_command.attr.attr,
+	&ddr_perf_read_modify_write_command.attr.attr,
+	&ddr_perf_hp_read.attr.attr,
+	&ddr_perf_hp_req_nocredit.attr.attr,
+	&ddr_perf_hp_xact_credit.attr.attr,
+	&ddr_perf_lp_req_nocredit.attr.attr,
+	&ddr_perf_lp_xact_credit.attr.attr,
+	&ddr_perf_wr_xact_credit.attr.attr,
+	&ddr_perf_read_cycles.attr.attr,
+	&ddr_perf_write_cycles.attr.attr,
+	&ddr_perf_read_write_transition.attr.attr,
+	&ddr_perf_precharge.attr.attr,
+	&ddr_perf_activate.attr.attr,
+	&ddr_perf_load_mode.attr.attr,
+	&ddr_perf_mwr.attr.attr,
+	&ddr_perf_read.attr.attr,
+	&ddr_perf_read_activate.attr.attr,
+	&ddr_perf_refresh.attr.attr,
+	&ddr_perf_write.attr.attr,
+	&ddr_perf_raw_hazard.attr.attr,
+	&ddr_perf_axid_read.attr.attr,
+	&ddr_perf_axid_write.attr.attr,
+	NULL,
+};
+
+static struct attribute_group ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = ddr_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-63");
+PMU_FORMAT_ATTR(axi_id, "config1:0-63");
+
+static struct attribute *ddr_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_axi_id.attr,
+	NULL,
+};
+
+static struct attribute_group ddr_perf_format_attr_group = {
+	.name = "format",
+	.attrs = ddr_perf_format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&ddr_perf_events_attr_group,
+	&ddr_perf_format_attr_group,
+	&ddr_perf_cpumask_attr_group,
+	NULL,
+};
+
+static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
+{
+	int i;
+
+	/* Always map cycle event to counter 0 */
+	if (event == EVENT_CYCLES_ID)
+		return EVENT_CYCLES_COUNTER;
+
+	for (i = 1; i < NUM_COUNTER; i++)
+		if (pmu->active_events[i] == NULL)
+			return i;
+
+	return -ENOENT;
+}
+
+static u32 ddr_perf_free_counter(struct ddr_pmu *pmu, int counter)
+{
+	if (counter < 0 || counter >= NUM_COUNTER)
+		return -ENOENT;
+
+	pmu->active_events[counter] = NULL;
+
+	return 0;
+}
+
+static u32 ddr_perf_read_counter(struct ddr_pmu *pmu, int counter)
+{
+	return readl(pmu->base + COUNTER_READ + counter * 4);
+}
+
+static int ddr_perf_event_init(struct perf_event *event)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0) {
+		dev_warn(pmu->dev, "Can't provide per-task data!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->attr.exclude_user        ||
+	    event->attr.exclude_kernel      ||
+	    event->attr.exclude_hv          ||
+	    event->attr.exclude_idle        ||
+	    event->attr.exclude_host        ||
+	    event->attr.exclude_guest       ||
+	    event->attr.sample_period)
+		return -EINVAL;
+
+	event->cpu = cpumask_first(&pmu->cpu);
+	hwc->idx = -1;
+
+	return 0;
+}
+
+
+static void ddr_perf_event_update(struct perf_event *event)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+	int counter = hwc->idx;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = ddr_perf_read_counter(pmu, counter);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+			new_raw_count) != prev_raw_count);
+
+	delta = (new_raw_count - prev_raw_count) & 0xFFFFFFFF;
+
+	local64_add(delta, &event->count);
+}
+
+static void ddr_perf_event_enable(struct ddr_pmu *pmu, int config,
+				  int counter, bool enable)
+{
+	u8 reg = counter * 4 + COUNTER_CNTL;
+	int val;
+
+	if (enable) {
+		/* Clear counter, then enable it. */
+		writel(0, pmu->base + reg);
+		val = CNTL_EN | CNTL_CLEAR;
+		val |= (config << CNTL_CSV_SHIFT) & CNTL_CSV_MASK;
+	} else {
+		/* Disable counter */
+		val = readl(pmu->base + reg) & CNTL_EN_MASK;
+	}
+
+	writel(val, pmu->base + reg);
+
+	if (config == EVENT_CYCLES_ID)
+		pmu->cycles_active = enable;
+}
+
+static void ddr_perf_event_start(struct perf_event *event, int flags)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	if (pmu->devtype->flags & DDR_CAP_AXI_ID) {
+		if (event->attr.config == 0x41 ||
+		    event->attr.config == 0x42) {
+			int val = event->attr.config1;
+
+			writel(val, pmu->base + COUNTER_DPCR1);
+		}
+	}
+
+	local64_set(&hwc->prev_count, 0);
+
+	ddr_perf_event_enable(pmu, event->attr.config, counter, true);
+	/*
+	 * If the cycles counter wasn't explicitly selected,
+	 * we will enable it now.
+	 */
+	if (counter > 0 && !pmu->cycles_active)
+		ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
+				      EVENT_CYCLES_COUNTER, true);
+}
+
+static int ddr_perf_event_add(struct perf_event *event, int flags)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter;
+	int cfg = event->attr.config;
+
+	counter = ddr_perf_alloc_counter(pmu, cfg);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
+	pmu->active_events[counter] = event;
+	pmu->total_events++;
+	hwc->idx = counter;
+
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
+	local64_set(&hwc->prev_count, ddr_perf_read_counter(pmu, counter));
+
+	return 0;
+}
+
+static void ddr_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	ddr_perf_event_enable(pmu, event->attr.config, counter, false);
+	ddr_perf_event_update(event);
+}
+
+static void ddr_perf_event_del(struct perf_event *event, int flags)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	ddr_perf_event_stop(event, PERF_EF_UPDATE);
+
+	ddr_perf_free_counter(pmu, counter);
+	pmu->total_events--;
+	hwc->idx = -1;
+
+	/* If all events have stopped, stop the cycles counter as well */
+	if ((pmu->total_events == 0) && pmu->cycles_active)
+		ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
+				      EVENT_CYCLES_COUNTER, false);
+}
+
+static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
+			 struct device *dev)
+{
+	*pmu = (struct ddr_pmu) {
+		.pmu = (struct pmu) {
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = attr_groups,
+			.event_init  = ddr_perf_event_init,
+			.add	     = ddr_perf_event_add,
+			.del	     = ddr_perf_event_del,
+			.start	     = ddr_perf_event_start,
+			.stop	     = ddr_perf_event_stop,
+			.read	     = ddr_perf_event_update,
+		},
+		.base = base,
+		.dev = dev,
+	};
+
+	return ida_simple_get(&ddr_ida, 0, 0, GFP_KERNEL);
+}
+
+static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
+{
+	int i;
+	u8 reg;
+	int val;
+	int counter;
+	struct ddr_pmu *pmu = (struct ddr_pmu *) p;
+	struct perf_event *event;
+
+	/* Only cycles counter overflowed can issue irq. all counters will
+	 * be stopped when cycles counter overflow. but other counter don't stop
+	 * when overflow happen. Update all of the local counter values,
+	 * then reset the cycles counter, so the others can continue
+	 * counting.
+	 */
+	for (i = 0; i < NUM_COUNTER; i++) {
+
+		if (!pmu->active_events[i])
+			continue;
+
+		event = pmu->active_events[i];
+		counter = event->hw.idx;
+		reg = counter * 4 + COUNTER_CNTL;
+		val = readl(pmu->base + reg);
+
+		ddr_perf_event_update(event);
+
+		if (counter == EVENT_CYCLES_COUNTER) {
+			ddr_perf_event_enable(pmu,
+					      EVENT_CYCLES_ID,
+					      EVENT_CYCLES_COUNTER,
+					      true);
+			ddr_perf_event_update(event);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct ddr_pmu *pmu = hlist_entry_safe(node, struct ddr_pmu, node);
+	int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &pmu->cpu))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	cpumask_set_cpu(target, &pmu->cpu);
+
+	return 0;
+}
+
+static int ddr_perf_probe(struct platform_device *pdev)
+{
+	struct ddr_pmu *pmu;
+	struct device_node *np;
+	void __iomem *base;
+	struct resource *iomem;
+	char *name;
+	char *hpname;
+	int num;
+	int ret;
+	u32 irq;
+	const struct of_device_id *of_id =
+		of_match_device(imx_ddr_pmu_dt_ids, &pdev->dev);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	np = pdev->dev.of_node;
+
+	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	num = ddr_perf_init(pmu, base, &pdev->dev);
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ddr%d", num);
+	if (!name)
+		return -ENOMEM;
+
+	hpname = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				"perf/imx/ddr%d:online", num);
+	if (!hpname)
+		return -ENOMEM;
+
+	pmu->devtype = (struct fsl_ddr_devtype_data *)of_id->data;
+
+	cpumask_set_cpu(raw_smp_processor_id(), &pmu->cpu);
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, hpname, NULL,
+					 ddr_perf_offline_cpu);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
+		goto ddr_perf_err;
+	}
+
+	pmu->cpuhp_state = ret;
+
+	/* Register the pmu instance for cpu hotplug */
+	cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+
+	ret = perf_pmu_register(&(pmu->pmu), name, -1);
+	if (ret)
+		goto ddr_perf_err;
+
+	/* Request irq */
+	irq = of_irq_get(np, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq: %d", irq);
+		ret = irq;
+		goto ddr_perf_irq_err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq,
+					ddr_perf_irq_handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					DDR_PERF_DEV_NAME,
+					pmu);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Request irq failed: %d", ret);
+		goto ddr_perf_irq_err;
+	}
+
+	return 0;
+
+ddr_perf_irq_err:
+	perf_pmu_unregister(&(pmu->pmu));
+
+ddr_perf_err:
+	if (pmu->cpuhp_state)
+		cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+
+	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
+	return ret;
+}
+
+static int ddr_perf_remove(struct platform_device *pdev)
+{
+	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	perf_pmu_unregister(&pmu->pmu);
+
+	return 0;
+}
+
+static struct platform_driver imx_ddr_pmu_driver = {
+	.driver         = {
+		.name   = "imx-ddr-pmu",
+		.of_match_table = imx_ddr_pmu_dt_ids,
+	},
+	.probe          = ddr_perf_probe,
+	.remove         = ddr_perf_remove,
+};
+
+static int __init imx_ddr_pmu_init(void)
+{
+	return platform_driver_register(&imx_ddr_pmu_driver);
+}
+
+module_init(imx_ddr_pmu_init);
+
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
