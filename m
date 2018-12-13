Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F37C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2522620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t2wMMKe3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJ4Bv7np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2522620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rV0VhVASAXbIfUHEmEwZ0hJjAoGA5rdT4csV+cdICL4=; b=t2wMMKe3UckAdN
	BXwxpp/+RrwJwiuHLZmQkdBJrLdkkJNmwBdbsc/EC2HFUJh4L4OQKiGUIcout5sIyXtLmSxylnMJW
	w8FGQuO6X5cz1Y/vUYVSzXrEBmKH6IWMNY/H8h4nXLjIarxp+KUyflO2pI8/9KNodNh9jb9e0k1m8
	jUV2rwFXeyi2l8A0H+ezjgAybfecTJIc5ApHGhOpEkmcT5OXjHGTTrBpyvtfagfE33LHNu+IUTQo1
	6w9MTfl/KDx0MJxNHgNNuDpMNZ877CZHvhqDvSsRyJ3boyqCh+/9CU2UzaDTNmwPmYPLmbaFV/4Rc
	O9UuyiQ1JA881LlIkjKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFVi-0005i1-Qf; Thu, 13 Dec 2018 01:09:54 +0000
Received: from mail-he1eur02on062f.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::62f]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFUY-0004Em-Am
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrPsZHj2S2ztrG4tcDJ9HC0msI1+R3t33wenWN21dtw=;
 b=RJ4Bv7npxNWHwKHMltv+mIlt4ZhZpwSW6Z0hIYH8b/oJzb9UVtJ2izeNS/+xAI7eJvShr6D1kCCqN/vaM5i1Kgo/62jEHM/dtUWU9oFa8vw4A4xOUeo/5aM4514S77zFBNTKuuV7kJelMt1uOLurXCyuKwDdrO+VILT4DJnLQOc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4852.eurprd04.prod.outlook.com (20.176.215.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 01:08:10 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:08:10 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 6/7] clk: imx: add lpcg clock support
Thread-Topic: [PATCH V11 6/7] clk: imx: add lpcg clock support
Thread-Index: AQHUkoBQL46loDs+9U29C5dtcszbbQ==
Date: Thu, 13 Dec 2018 01:08:10 +0000
Message-ID: <1544662938-5020-7-git-send-email-aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4852;
 6:YqZCB/g3CsgwbWv/D8480vBVUWiMd9il+T4XYI8wO7xXzyd43Z6+BowGEZKyljGXc8QBhclaN5+A3EFdBCgVsh2+1z09r/efz/VUsRn6dtrpgeoUkRYvwYnnexHVfy8lnnLET0+G0C86BmxTDxxX6zi46qcwPicHEsxeyjn7dLkss+UnoeV7qjVSHp5MQO1y9kFNUf9Q5RjsiyCqzXixgzQd7cl7Xt0xl89Jrr3O13uGA3X+6TfW/fOYlq2tzltoDFuB7jVPIiqNt/GlMda89VyMoH/qEwvXfxLWWEl6mvQIRwCWi24W2HXPQQ8CP5trzL+uLynpDW+OCpCQKHUoDXSOqlE7138ckUNaBVyzpgcG7bCcamLMWv12OL6x5cq9x7yP+BG03UfEf4kiejdeXNvr+nptEkgW3bHga8x0jZfpFAE62WJku1qnNXf0nlEXr5yanD4J5riHw+F20SjqHQ==;
 5:kGNZr0YEBnB+5dQ9xe/7gkCcK6HU0gchJaxFh9XAxSHmbdk7/lrGbwMBgxFqRWkHCkhXXzqJeUe8rj6jVP4nQNqcg25CMfeFXDF9D+IrnhxLpEa/ROwE/9txzNh/P29JtDvFVTKm+sqS1YZULR4RoXWZ5ZNDdMgZxfVnIzDk1RU=;
 7:7UMymxS5PPtcL2Nwbt4XRkJMiLQ5MlUOrlr5MA2FSccRPN1lcTU1WKuq57WvBvCUq5y/5wh0N6UHAf4CwjKHNNVC11nSNVYkx7jked/fzf4pHRSQUyokZuRi7kVyCC5uijN0VhfV+S1jIV9nNP0nkA==
x-ms-office365-filtering-correlation-id: 64eafa27-4443-4d0e-d6ad-08d660977291
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4852; 
x-ms-traffictypediagnostic: AM0PR04MB4852:
x-microsoft-antispam-prvs: <AM0PR04MB4852C75E27EAFFAD3A2545BA80A00@AM0PR04MB4852.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4852; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4852; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(54534003)(199004)(189003)(53936002)(186003)(2616005)(2501003)(11346002)(71200400001)(44832011)(476003)(5640700003)(6506007)(3846002)(52116002)(71190400001)(66066001)(486006)(7736002)(305945005)(6116002)(575784001)(50226002)(14444005)(6486002)(8936002)(81166006)(14454004)(68736007)(81156014)(6436002)(8676002)(256004)(316002)(36756003)(86362001)(25786009)(54906003)(6512007)(26005)(106356001)(6916009)(76176011)(446003)(478600001)(386003)(2351001)(97736004)(2906002)(102836004)(105586002)(5660300001)(4326008)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4852;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U5krQhNObziNyiolMZbJzmAcAFV9XZe4I0Vx/nnx8N4gQo9VtZaSWSRfcuE4m1nG00o/nGwxDZgg8ilTznD9sXeiBB7htoFul27Qo8gzHSPHD6Nz1OXEA+zHaV3Qultbb9+BKWqi72cxqlo8PiZWZ4qObdUONXozqZYIndNjxlXn6tE5pCONQHbvCgsFMT3eyzvKezNDXyvzB6e1nDqBG8oAwLWmzb+j1IO/iXErUyfjXsydhcCAjO0K2VcOrZrYsYvAlEXvH06Q1YJDYRexHEZS21f2xcnQv7vp19ljqQCyhyNy9ooGrT+vZgynv2xZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eafa27-4443-4d0e-d6ad-08d660977291
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:08:10.0674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170842_705460_AF43E783 
X-CRM114-Status: GOOD (  19.24  )
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
