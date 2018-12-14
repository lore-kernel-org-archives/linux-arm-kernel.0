Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA43C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AE22086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2m3jUul";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PFvJvwqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AE22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8cOi7148R6oyQ5s1Y9tGQqGYy+YFphy2Uv3fqHh5960=; b=l2m3jUulQtpSnW
	hkbNFNXnGfpIsGYg0YuxC0vop7gFIWL0xaM91boj/hpbeQQO6v2LSwaJuHLLPEB2x9OMqPhfYAnGa
	pOSdoSKXsfWMcOiOAc4NsOXSO8ZKT5RFzFgRXgpROM+D6Gbtg7ARiLcJpMNzDnpGLqBYdm+H4NLEM
	1LN3iV1N6CpBAxIzCh5KQnjnS8YwFfdK+UwX/TGb7fdgg5BW5UnjEOYzguHj+JsPpbjuQGq8j75FF
	nnl8dh2/Ye+Tpx6kL6pcoQM6S+oe9EHEFzeAwl9eHTLvox9HQlmaoQtJPFOUQlaqkDJOd0Nc4xCdo
	ycBR+OkV8wDEOeiJIEmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXil5-0003Cy-UX; Fri, 14 Dec 2018 08:23:43 +0000
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXil1-0003Ca-SK
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 08:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhY+LIcWiDlLbiDIn9klntQJRX5msaT2LNgrzAw0Jxc=;
 b=PFvJvwqtLpf7In5f8lvLEErGPY7xfBd7f99zcHEEt4ogTGrEFS6QHNBMNmdmrRdwx+lWo2eE/iBI2imarCv15JPb8zQ+BmWDjOviTvphhhWbm7pLi1qYBDoQ3bE6mqB3bXLmGIcaPeMmMO2CVBS/BVki1R1+UbVZC6O1IwLEnXo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3691.eurprd04.prod.outlook.com (52.134.66.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 08:23:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:23:25 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: imx: add i.MX7ULP cpuidle support
Thread-Topic: [PATCH] ARM: imx: add i.MX7ULP cpuidle support
Thread-Index: AQHUk4ZIRjPFoid9+UiCQ98N5HjNIw==
Date: Fri, 14 Dec 2018 08:23:25 +0000
Message-ID: <1544775444-31544-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:2e::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3691;
 6:OX1GQvuKnCCopnvRqbng9UkQyO46FzDR+QVhD/EjkNwcdbVbcifhGvcbTdMlfs4M4zDzODx1k5PIyzYPWOyiIAhWsYOSoXcv3HOPOYYYIvGpLqRiyogkq/12nidx3FxPoAdDrgWUlZYmF5XZiHihVYHl0sPqovLJkGoiFdxjr0Xd5sB5SdllF0biPxHVeduogfBX7IzBvCw5MDmFqPsGHaAFN45OmBj3mb22odyEZIFxvte0vhIcfsV5RdVPO3VDW1g9tm4A5Eppuw6I1hmt+wH3ABKvkg5diWJnkTF734Pyugf13wbjxt8mGJF35iSCATCGSk4ap/AZRlDyI399nHzKxPeRP2gS8hwR3GiQQT5nUf8VUhSVCnLneaEuw1g2cCxPVddSXtXyftKgIbjYdGUX0z0q8vFtGahA+U9m6nSyIxH/eiRskrID8K04RVfuXa1KT8IVmombn/jZKG7oJw==;
 5:IGsZYAErq6whh+qJ+gimo0lOoCINzFFRta5PYx6ppw1jYZKnxfNneJL3cHnIhyNwDe3FoHnytxJZodIZvGZks97rBeBBI9AckKAUTvutqG8ZI81MrZmCkNjrabMesSBw3bZGyu2XjRVV6rAWL4XJoROF/cR1IOEd/9kpO81TD7w=;
 7:e4FJPWxPRMLR/hq9kIa8sF5RhRhu6qortNx+5IAd/s6TeMj/qNa/A4W+itofnG+oUJwKx3GDQKFLQ7uc7b0jyAJLHbHsNipCvpjqACTzaNwPt7UCKQBl8ylhN625dJa39wG1cfyQg8eHVB6kRER7WA==
x-ms-office365-filtering-correlation-id: 45671085-7879-4388-5295-08d6619d6ac4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3691; 
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-microsoft-antispam-prvs: <DB3PR0402MB36912FFFACCF1AB1C9B29F21F5A10@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3691; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3691; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(4326008)(316002)(110136005)(256004)(14444005)(66066001)(106356001)(97736004)(105586002)(71190400001)(478600001)(25786009)(71200400001)(14454004)(68736007)(2501003)(7736002)(305945005)(5660300001)(50226002)(36756003)(8936002)(8676002)(81156014)(81166006)(476003)(6506007)(386003)(486006)(2616005)(86362001)(575784001)(102836004)(2201001)(6512007)(6436002)(2906002)(6486002)(6116002)(3846002)(26005)(186003)(99286004)(52116002)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3691;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IXby0+1I9DPKyhDaNd0UKXq0yQe+7E6vYEvKU0Wn5/sBJ4pmYitf5ZBfts3vDCR7zsaUVzlzc1EV0tzdUoRp64rA4a8iIGvoQVtM71rq++1xTs951wD3g/mfKN4gt6rYFBRfTbYxNN733Aeka94oNFV1uNA/WqaaMeHqJoYur2h52TXgWBWvMPDzmV4Hs1JaV4pM5CMufF6Zoe482Pu2mrlFXLCK0p45UpdM5ibRcYsAFAEbPo8nJxLbnPvIMwFI15Cq4nHIdEkApA86FlUfP3Euk5pH4VSoSg22/sZrAyV5KqVXgwZwbhtvI0EbKJ3y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45671085-7879-4388-5295-08d6619d6ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:23:25.3368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_002339_918471_089B5E65 
X-CRM114-Status: GOOD (  21.24  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
states supported as below:

1. WFI, just ARM wfi;
2. WAIT mode, mapped to SoC's partial stop mode #3;
3. STOP mode, mapped to SoC's partial stop mode #1.

In WAIT mode, system clock and bus clock will be enabled;
In STOP mode, system clock and bus clock will be disabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/Makefile          |  1 +
 arch/arm/mach-imx/common.h          | 10 +++++++
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 60 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h         |  5 ++++
 arch/arm/mach-imx/mach-imx7ulp.c    |  7 +++++
 arch/arm/mach-imx/pm-imx7ulp.c      | 49 ++++++++++++++++++++++++++----
 6 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx7ulp.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8af2f7e..12aa44a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX7ULP) += cpuidle-imx7ulp.o
 endif
 
 ifdef CONFIG_SND_IMX_SOC
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index bc915e5..a87fab1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -72,6 +72,15 @@ enum mxc_cpu_pwr_mode {
 	STOP_POWER_OFF,		/* STOP + SRPG */
 };
 
+enum ulp_cpu_pwr_mode {
+	HSRUN,    /* High speed run mode */
+	RUN,      /* Run mode */
+	WAIT,     /* Wait mode */
+	STOP,     /* Stop mode */
+	VLPS,     /* Very low power stop mode */
+	VLLS,     /* very low leakage stop mode */
+};
+
 void imx_enable_cpu(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
 u32 imx_get_cpu_arg(int cpu);
@@ -98,6 +107,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
+int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
new file mode 100644
index 0000000..a59df93
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ *   Anson Huang <Anson.Huang@nxp.com>
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+
+#include "common.h"
+#include "cpuidle.h"
+
+static int imx7ulp_enter_wait(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	if (index == 1)
+		imx7ulp_set_lpm(WAIT);
+	else
+		imx7ulp_set_lpm(STOP);
+
+	cpu_do_idle();
+
+	imx7ulp_set_lpm(RUN);
+
+	return index;
+}
+
+static struct cpuidle_driver imx7ulp_cpuidle_driver = {
+	.name = "imx7ulp_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency = 50,
+			.target_residency = 75,
+			.enter = imx7ulp_enter_wait,
+			.name = "WAIT",
+			.desc = "PSTOP2",
+		},
+		/* STOP */
+		{
+			.exit_latency = 100,
+			.target_residency = 150,
+			.enter = imx7ulp_enter_wait,
+			.name = "STOP",
+			.desc = "PSTOP1",
+		},
+	},
+	.state_count = 3,
+	.safe_state_index = 0,
+};
+
+int __init imx7ulp_cpuidle_init(void)
+{
+	return cpuidle_register(&imx7ulp_cpuidle_driver, NULL);
+}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index f914012..7694c8f 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -15,6 +15,7 @@ extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 extern int imx6sl_cpuidle_init(void);
 extern int imx6sx_cpuidle_init(void);
+extern int imx7ulp_cpuidle_init(void);
 #else
 static inline int imx5_cpuidle_init(void)
 {
@@ -32,4 +33,8 @@ static inline int imx6sx_cpuidle_init(void)
 {
 	return 0;
 }
+static inline int imx7ulp_cpuidle_init(void)
+{
+	return 0;
+}
 #endif
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
index 16b295b..95efb2d 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -12,6 +12,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "cpuidle.h"
 #include "hardware.h"
 
 #define SIM_JTAG_ID_REG		0x8c
@@ -64,7 +65,13 @@ static const char *const imx7ulp_dt_compat[] __initconst = {
 	NULL,
 };
 
+static void __init imx7ulp_init_late(void)
+{
+	imx7ulp_cpuidle_init();
+}
+
 DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
 	.init_machine	= imx7ulp_init_machine,
 	.dt_compat	= imx7ulp_dt_compat,
+	.init_late      = imx7ulp_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index cf6a380..9551e1f 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -9,21 +9,60 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "common.h"
+
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
+#define PSTOPO_PSTOP2		0x2
+#define PSTOPO_PSTOP1		0x1
+#define BP_PMCTRL_RUNM          8
+#define RUNM_RUN                0
+#define BP_PMCTRL_STOPM         0
+#define STOPM_STOP              0
+
+#define BM_PMCTRL_PSTOPO	(3 << BP_PMCTRL_PSTOPO)
+#define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
+#define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
+
+static void __iomem *smc1_base;
+
+int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
+{
+	u32 val = readl_relaxed(smc1_base + SMC_PMCTRL);
+
+	/* clear all */
+	val &= ~(BM_PMCTRL_RUNM | BM_PMCTRL_STOPM | BM_PMCTRL_PSTOPO);
+
+	switch (mode) {
+	case RUN:
+		/* system/bus clock enabled */
+		val |= PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO;
+		break;
+	case WAIT:
+		/* system clock disabled, bus clock enabled */
+		val |= PSTOPO_PSTOP2 << BP_PMCTRL_PSTOPO;
+		break;
+	case STOP:
+		/* system/bus clock disabled */
+		val |= PSTOPO_PSTOP1 << BP_PMCTRL_PSTOPO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(val, smc1_base + SMC_PMCTRL);
+
+	return 0;
+}
 
 void __init imx7ulp_pm_init(void)
 {
 	struct device_node *np;
-	void __iomem *smc1_base;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
 	smc1_base = of_iomap(np, 0);
 	WARN_ON(!smc1_base);
 
-	/* Partial Stop mode 3 with system/bus clock enabled */
-	writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO,
-		       smc1_base + SMC_PMCTRL);
-	iounmap(smc1_base);
+	imx7ulp_set_lpm(RUN);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
