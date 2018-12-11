Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D150FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:15:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E212081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dCdrCdV7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K2V0SoHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E212081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rV0VhVASAXbIfUHEmEwZ0hJjAoGA5rdT4csV+cdICL4=; b=dCdrCdV7WZXUCs
	HTDYTrQsOQT71yzcNkcQehwXY5o2Kfg8QYTa7Rtxt3n5fVA663617pmJIgScf+Jsy7rAX6sD2q8cM
	feurDWoOnuYs5EuZ8ZhDr7hxVMMq9K6A23BYGnbiO7mejndJhp6/i8UwQvKa6D3WaZmdyyNCoP54E
	ohfrfxhedW3vLhsyfjEVrjXkOV7if2NEBjFYETD12FngDdX0twZ6Nkj5yD+vOedAB8peWTrkv4C9H
	vntsHjjshr87TTA4hc3xx0DYih29NEvcce+lVhIfFRwvIrVU7g9tizrhplCmb7zy00Lka3rLnXRl+
	hkjQSFDwP79PrAkAIrHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjkk-0001ID-JW; Tue, 11 Dec 2018 15:15:18 +0000
Received: from mail-db5eur03on062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::62b]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjjQ-0007jw-0O
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:14:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrPsZHj2S2ztrG4tcDJ9HC0msI1+R3t33wenWN21dtw=;
 b=K2V0SoHr0tfVTE1vEHQUPlMn/PpLXNcqhSqQnxMO4loVoriasJkanvQSFsDasM9ell1OD03fTTKNsiCM//aymdPwdpZu4uS86dvbxk1zx7SBjY5VmEWYUzsXP1kCmvtMGwX+UXrQliYFNUsaBjFzWA+kuSFjubI8MO9N6K2fxas=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5859.eurprd04.prod.outlook.com (20.178.202.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 15:13:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:13:42 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V10 6/7] clk: imx: add lpcg clock support
Thread-Topic: [PATCH V10 6/7] clk: imx: add lpcg clock support
Thread-Index: AQHUkWQaCljG4q/wzk2GDlYjUPJfAg==
Date: Tue, 11 Dec 2018 15:13:41 +0000
Message-ID: <1544540867-6342-7-git-send-email-aisheng.dong@nxp.com>
References: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0081.apcprd03.prod.outlook.com
 (2603:1096:203:72::21) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5859;
 6:ln3MUvn7IHq6K9jjovYsj3F7O/pgzE8d3pzRUCWp0rZNZBASXLM1uWs55/f+HdtjxufmllO3t0hq5hDBo53l1s9eCuM8ptkwwxd3KMkKiGGlBsjddRlx4avvyZiBj2W96fNbNjvMtsN6Vw+rV/6utB7QgP92c7krailTCtQC5GiYnh28sxSn70opbZnNFUNce0W1Cxfw3hEZ2ajuXiAVqoN/j28RUema/9YqW9ykRS9xqwvBoCJ0HXAeWGL5U5LhpDJnxevMDhe75WQWma08yD6JJS43YvAVaDbaLXKOZGSbzGVpgHYAffF+8orJaC99EoSKgwihrZsPa/lr78Dr2fEKMcr1DKhGaNUnoceVxobxIXW/RHy1VIB9cSM7wJ16/Rmu3ZONcFeKOu7Q6rFuW8qi6+j62FcQ6wk4XYW1cLNF83ci1KK7yXs2RIQ2KBghvDgp5lafx8Xe0suzP5Xqpg==;
 5:TUHX0yG8hLTVNJWqOB8ym2Y5kYSnceB3Dx3rIPRC3NTRbjDiYGvoO4UWE3X3UM0hj3VZkULyi+43qDhuHlRw/5j5L8fibdtI3i1F+ETE1ehJU9nu1k7PecQPrlnB2v1R+bp/YTZuQl3kymfGepVr8GR5Jbh9Cdja9F4DxVM/0kI=;
 7:jHumiOQ7Etah0uU6nWoDpmPsgjLu+uPSaVTB0rkIdOlpn/VMM8+OkRSI4YaRvQyL0FcJ52R+XajAxO2MIVaG861hQeaLkY+uY3WpAOg8/EJvANfvPzMzGs8mlFfEcMqRnfT30eXOi+1cFUIhHAlN2A==
x-ms-office365-filtering-correlation-id: 9377e9cd-e345-4a87-03e7-08d65f7b3c55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5859; 
x-ms-traffictypediagnostic: AM0PR04MB5859:
x-microsoft-antispam-prvs: <AM0PR04MB585924F375AE3754129FCEC180A60@AM0PR04MB5859.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5859; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5859; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(54534003)(106356001)(44832011)(256004)(446003)(14444005)(2616005)(476003)(54906003)(11346002)(68736007)(7736002)(102836004)(486006)(2351001)(316002)(26005)(8936002)(50226002)(25786009)(2501003)(4326008)(3846002)(6116002)(97736004)(478600001)(53936002)(186003)(81166006)(81156014)(6512007)(105586002)(2906002)(76176011)(8676002)(575784001)(6486002)(86362001)(386003)(71190400001)(66066001)(99286004)(14454004)(6916009)(5660300001)(6506007)(5640700003)(52116002)(36756003)(6436002)(305945005)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5859;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O0iA8vMRY1cc4oYdcsbfNFfQPTxOqdGnXW1g29K41xIJh2hpAXo9Dd6edSyaP+79LrJovvZyxGtLQuiVncUTi3xEAOKKXtufMUGy0/8oXCJj8pPTf1XqlYB3Y4ackAsyIK7sXtKOQDi5D+QDP2PKfXE6wMiS7ww7uzBFiT22N+EjZUW8cX5MO+OpBFDPtWxfOIPrLxkDNFcApM2C0YP7kLdSuZllV4fhz6YndE5qQDZq/p8wOWbq4i732wssr0JmyidNkJYz5jaWAgm2V+Ppg7AKA+Ahxt/4FChwM7Q88ilParZQkP4Y0Ga8DRscNhP0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9377e9cd-e345-4a87-03e7-08d65f7b3c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:13:42.0456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5859
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_071356_699863_ECC0ED40 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Low-Power Clock Gate (LPCG) modules contain a local programming
model to control the clock gates for the peripherals. An LPCG module
is used to locally gate the clocks for the associated peripheral.
And they're bedind the SCU clock.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v9->v10:
 * no changes
v8->v9:
 * use readl_relaxed() as it does not need insert barrier
 * a small code logic improvement suggested by Stephen
v7->v8:
 * add doc for struct clk_lpcg_scu
 * remove unneccessary reg checking
 v6: separate from [PATCH V5 5/9] clk: imx: scu: add scu clock gate
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-lpcg-scu.c | 114 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h      |   3 ++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-lpcg-scu.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 75312fb..4f72163 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -21,7 +21,8 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-sccg-pll.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o
+	clk-scu.o \
+	clk-lpcg-scu.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
new file mode 100644
index 0000000..fbf3416
--- /dev/null
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+static DEFINE_SPINLOCK(imx_lpcg_scu_lock);
+
+#define CLK_GATE_SCU_LPCG_MASK		0x3
+#define CLK_GATE_SCU_LPCG_HW_SEL	BIT(0)
+#define CLK_GATE_SCU_LPCG_SW_SEL	BIT(1)
+
+/*
+ * struct clk_lpcg_scu - Description of LPCG clock
+ *
+ * @hw: clk_hw of this LPCG
+ * @reg: register of this LPCG clock
+ * @bit_idx: bit index of this LPCG clock
+ * @hw_gate: HW auto gate enable
+ *
+ * This structure describes one LPCG clock
+ */
+struct clk_lpcg_scu {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 bit_idx;
+	bool hw_gate;
+};
+
+#define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
+
+static int clk_lpcg_scu_enable(struct clk_hw *hw)
+{
+	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
+	unsigned long flags;
+	u32 reg, val;
+
+	spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
+
+	reg = readl_relaxed(clk->reg);
+	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
+
+	val = CLK_GATE_SCU_LPCG_SW_SEL;
+	if (clk->hw_gate)
+		val |= CLK_GATE_SCU_LPCG_HW_SEL;
+
+	reg |= val << clk->bit_idx;
+	writel(reg, clk->reg);
+
+	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
+
+	return 0;
+}
+
+static void clk_lpcg_scu_disable(struct clk_hw *hw)
+{
+	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
+
+	reg = readl_relaxed(clk->reg);
+	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
+	writel(reg, clk->reg);
+
+	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
+}
+
+static const struct clk_ops clk_lpcg_scu_ops = {
+	.enable = clk_lpcg_scu_enable,
+	.disable = clk_lpcg_scu_disable,
+};
+
+struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
+				unsigned long flags, void __iomem *reg,
+				u8 bit_idx, bool hw_gate)
+{
+	struct clk_lpcg_scu *clk;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	clk->reg = reg;
+	clk->bit_idx = bit_idx;
+	clk->hw_gate = hw_gate;
+
+	init.name = name;
+	init.ops = &clk_lpcg_scu_ops;
+	init.flags = CLK_SET_RATE_PARENT | flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	clk->hw.init = &init;
+
+	hw = &clk->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(clk);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index 309b4de..52c1746 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -12,4 +12,7 @@
 int imx_clk_scu_init(void);
 struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type);
 
+struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
+				unsigned long flags, void __iomem *reg,
+				u8 bit_idx, bool hw_gate);
 #endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
