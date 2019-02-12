Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BE9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE47222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ohf/2dw+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qbwgb9dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE47222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n3/IhuXoU1Jqkd604XU+eoO5TstCVPLl0tfta3EBIBA=; b=Ohf/2dw+SIiZvM
	wY6T8UT7Pm+6tf6xmDqiY0Yw5svsTLsa/xJPrdaHsooB76GJp8YYvkrCZxXESIlf/B1Zdd8Uwj3Jm
	XAJXghlIRdLhSgWR9Vq3bOWlTGwIGzGwRTAiLSZNf0yWZAr3sZuG3ABUVPLrfsOLzkAuqVm3re4g2
	M2ImttHRHDDu8as/XBXkVqh4VV0S0DOsQu6V1mtIradapNjZM90gnq+J2dIe9GgfmhFtpyenKICEb
	dBAGibAW32+lxjNXzl471pI48llfKMap5Rm159sP1R2AxQrDesZBw1tIINO8awtgg2gGc9pbvdhTR
	Tuxg3GNxduHM+exIGOXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtf91-0005t3-39; Tue, 12 Feb 2019 20:59:07 +0000
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtf8v-0005rE-V1
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5gxLQptAnT1sOCYDmnoPANitDBw5NYiur2Gd2xvkv0=;
 b=qbwgb9dJe1tbhM0HZ3M81WgfzHcKGtFgsLmoWHU/LFtAfGIgy2M1pfM+ICeNzjcEWH2+IaUSTiOCqjwIiC/4eR2X+2bj4BM/8UJ7+vvDHcuW8X2l5m8JqEoDKKyKJP25yTclXe+Jx2+J0XRE9gCo9SU7T1nkIUAJ94xbFuJVp58=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 20:58:55 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 20:58:55 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 1/4] drivers/perf: imx_ddr: Add ddr performance counter
 support
Thread-Topic: [PATCH V2 1/4] drivers/perf: imx_ddr: Add ddr performance
 counter support
Thread-Index: AQHUwxXE4963f5pIQkCS/A4OlfDKLw==
Date: Tue, 12 Feb 2019 20:58:55 +0000
Message-ID: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0021.namprd04.prod.outlook.com
 (2603:10b6:803:21::31) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1613;
 6:MBJE1sjqH+Zh73eQchAANJTHdHE4vSZ+YUM7A2f7Ygx9tctgLUKM5AHp64AJDSPRomV3+44qVsvVceDCbKEnCsjyZ8YE4cHqWbYHDkfuYEksQN7ubVLzS8P3UTssExMV5CQJG20LOvWFLrniI3qSSKZTJ23mkPqqtKv8uU6odbVW+GBFhvfksTUDV0vC+dkWlxIdh8XJdmW0SnLZnAexp2fplkiyPTvppeRFDUzR6x8p+zYIw4dp8aOwvn6olNlCTUlNu5Wj9bFzK3Zf4MaDGZ8nSrBjj40CWefvqvxggUTZM5dc/YFYTpRWA2MBvtSr7zpzFojSlQTzGJT/8HjYswyjJby7chFizmTpYmhgnHvnZkdtBCIShRjr/B3rh6h29y7glg4d6SvsvuC49uEdtQGSlhALtJ+K4f9K7NEIkqmSZhwXEbRGELqtRaG0PDdEQLP2x1+098JlXPRCRWBW2w==;
 5:vWg7MvyGTn1vJzLKWoL/d4C2ctYApqO9g5ZnjNr+0+Jcqrxmm3daLR7VH/MmKtaAs/kNPUqesmo2CZIUovDUegasVWGQU0ybZYgARwulgISsMYuv5DFXcholEZQHkZ/8VhxVYbXTkLbxYqstFCFZCFvtTLTaVUVGf7PK/0teuIYM0E82MqCPVIhf1BnzC7QuyWEG24v9yDq5L1J8d9DZvQ==;
 7:sw/PgaqBpJvz/FcmrtvLCZ5JWK1dxTdkgFlxg3SG3o3H9pUuotRa4A9QVZ2uTbQ/rXtAUBp3HbHsq95eIeEQ1ZMU/wAaUZVTdpwE3y6OEtiX4f8B+sna+4LGMZItVHE0VDPctAT5wLX0wuQdSQukiw==
x-ms-office365-filtering-correlation-id: a4ccbff1-8c50-4540-afae-08d6912ce66d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1613; 
x-ms-traffictypediagnostic: VI1PR04MB1613:
x-microsoft-antispam-prvs: <VI1PR04MB1613F3A27D7280E3994EE2FE88650@VI1PR04MB1613.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(97736004)(30864003)(71190400001)(81156014)(26005)(5024004)(81166006)(102836004)(50226002)(25786009)(386003)(6506007)(8936002)(8676002)(53946003)(68736007)(99286004)(14444005)(6116002)(3846002)(71200400001)(7736002)(256004)(316002)(110136005)(305945005)(7416002)(53936002)(2906002)(86362001)(14454004)(2501003)(2201001)(52116002)(186003)(105586002)(478600001)(6486002)(4326008)(6436002)(6512007)(486006)(36756003)(106356001)(476003)(2616005)(66066001)(921003)(1121003)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1613;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3NwTO53r79dycvrv58SJlfXfpeVSKRqpEv+mg7BNYiJhZD/T2YA7lBIkO7B41lZS6bjJ2KwYUM/jeF2jBDHxFjx7IBEYHRJSy7F7WI+qTYi2Qbvfs3zdOLD6jlKsnPC0XEVSx1CY0mlRHA6auboKPFtOX+hnZQ7KaiOCrDH5B87bZAkzMgv0C0S7EBhSDqrThkacKtlpM6ed3bdOqEvdqePZoGDYJgzCPMk2NaK3+01UvK3DrqXmv9poSEQ+KHVCsjkO+M2Z5ozhFBG+pDYGE3Lxq2LSNbRWO97yTBqFec9tgZwYkj0UK71Upk+BC/+6Z3GPIvr+ubmSCusyR7RcWcXDQ4gnumqdO2jPdtMq2Jmz0sPYClglbJ2OyX6dySghEo/LI37ROuQL87pXC9JbJnCD3FLZeXySzASHVShAoSY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ccbff1-8c50-4540-afae-08d6912ce66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 20:58:52.8735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_125902_200518_BA359EAB 
X-CRM114-Status: GOOD (  14.48  )
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
 drivers/perf/fsl_imx8_ddr_perf.c | 571 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 579 insertions(+)
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
index 0000000..c74e106
--- /dev/null
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -0,0 +1,571 @@
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
+	kfree(pmu);
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
