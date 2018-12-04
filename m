Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C3CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:41:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0694120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HTHAL8Cq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRVReKA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Sl5hbMqesmiPXPxdAl+KHnFdTpJ08DMkAm1tDLnESQ=; b=HTHAL8Cqc7FYpH
	BTMmv3dsB31971b/8dSiPX8MeJQ8ScilPjCvx4sWjcReJHSxZimPy+/Odq8MJLhFC2N/OMrFjult2
	hbxaW03qJ05XjcA7RyQjkVvgCVzyLtiRiicsI4+oCORJfYL9OuG5FLK/mYLx44Z4lU/STTibKZu6y
	EXcAJ5zUJxh6rjPi6wK31SdHpp6DoQRigToV8eUPoYMnZ8iQhecm1lDOklLuN0RumNoeUwTfitRWj
	IMD1TciKgMyu9Po+S66C7yiLm3GfcttAh2G25VESK+w5/2lgeJNJmYtOc0LM9HxEcMhPXN0t7yblO
	FopRnPvfTqy6vn5+FIDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBtU-0005y7-0i; Tue, 04 Dec 2018 14:41:48 +0000
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBrn-000364-1W
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:40:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrldm/jEpoFgEt9rOvV/w6ayla6vcuRTdcoY/4ShKHY=;
 b=SRVReKA9megTya2FVHM9/0Nz+IOPnnA9RVN2sJzE8SgqzhzXsv3zSlbHihoKIzVXznIMxOxSKB8V+dlJ9ujeHzM1ZgomiuNHyHJl8hmtNmXwJppYy9gDaeMpODiOQpWyAADnRbN5NHqNGAR2NjXVJo9FoiKfUsD4So/cdGkQWOk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5763.eurprd04.prod.outlook.com (20.178.202.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 14:39:41 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 14:39:41 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V9 6/7] clk: imx: add lpcg clock support
Thread-Topic: [PATCH V9 6/7] clk: imx: add lpcg clock support
Thread-Index: AQHUi98wyZnVxAEhwku5+6ApTXa0gg==
Date: Tue, 4 Dec 2018 14:39:41 +0000
Message-ID: <1543934041-12572-7-git-send-email-aisheng.dong@nxp.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5763;
 6:BoXdPzQLBcLG5TIBfhdlxkCj44nN32QFTDbflXYqrV0jcJI9X8ZXdpC/FAEVBCZL+dDiAX+R2vJ4GVd+HFxr/PyYSYio2kbQ5v75+hTEW06d9qi/sOyvpBnZKTtxKMkSniKp9vUuBzjINnsG92vyW0Il7iwnVbs/xhnpMIbrro9b0BJYYpvyTi2kCX9dV5docsWb9l20vHP+7L8I8I2XP5gO87bsa/w+ZFmkAyEfz/Sxml2Qloix7MfjI7E6g6tTm+K0SeCa+S4hY7eGfAX8RIhKItUrjgMRGMRuonJF4PfLQ3q4GpkGMaNpr5EHJZONJOPs8/ErrwguK5SZnFd68vWpDpGI70y4a6CC/EDOlLmsuTbL16CtwlMDrkuSDzK9I5FFaWrXpCBXhVPap5jfsEqA1XNcS2YFLrei+0LUxxtR5kO6A74eYAmMNEAux26Wk8FOs0byETy4g1uo7UgZrw==;
 5:szAWeMVjoMgGiR9PnBrmasNT4vywlekn/xZOH8N5l8SmnE23TTFu3yHSMTZU1tOEUose9RBbf9BJN81Dns0jYM71keg7HgLnN271qRj8PrHi8mOVo6JiRKrrvOMzN8+l2eYa/xSDOlv4iGt8KdPW4nIWFAA2gzfij/fWzaXs2C4=;
 7:nRfohx8CIn3xTJIDzg/2iOOrENvRaGd+VpU5H3Jmcz4jjwXp2QKXvmFwGbxvM+OPMc6NKZjuFLno7U888rPVgcKwJW+HpHd6LSqgoQLECe2rxguPpxl84VE+FkdxjCt9ECMJJtxmBcM0v2UBb7u34Q==
x-ms-office365-filtering-correlation-id: e8d862f1-aad1-4ae3-e6dd-08d659f652f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5763; 
x-ms-traffictypediagnostic: AM0PR04MB5763:
x-microsoft-antispam-prvs: <AM0PR04MB57633DC4DBD9E398B121339980AF0@AM0PR04MB5763.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501493)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5763; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5763; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(305945005)(386003)(14444005)(102836004)(25786009)(97736004)(52116002)(186003)(36756003)(76176011)(478600001)(256004)(6116002)(2501003)(8936002)(86362001)(26005)(81166006)(3846002)(6506007)(8676002)(81156014)(4326008)(50226002)(316002)(486006)(53936002)(2616005)(476003)(106356001)(99286004)(2906002)(5660300001)(6512007)(7736002)(11346002)(6486002)(446003)(6436002)(2351001)(6916009)(68736007)(105586002)(575784001)(14454004)(54906003)(5640700003)(66066001)(71200400001)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5763;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YesArP2W15t3FxNc7tGzBUoLFhf6+UPIEW69aK/aEJazzYbZ1Mq1w8wYMs2U1inGqCq0l4FpNzki5Jx7g/fqn6Cl7izGV9R6Juj2eBf7jw7gNuph4ufTGQqcz9SlIMLikVilMytaumtnDorjYaIHkxC0siKA1S6kh3LuxBjvjhuTP9kE8ER8u2j2YA22T3j33tYqhVodcHw2qdVIJ/YYaINY8pDCBLhXIjTQ+7xHjysChpFwAJGZpqZoP9eOI8t9xqGzfa3iXk7SOJKxtMRBQ3VwQYkk0+TdCEzMcKNMrMmxKA0OvrJ+eCWMUzu0Uh+iDFmcvGqNsfpFGoCi/JYAQLMF+HdD4kwUiuMwCVGkRag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d862f1-aad1-4ae3-e6dd-08d659f652f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:39:41.0950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5763
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_064004_189110_3289A8EB 
X-CRM114-Status: GOOD (  19.52  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
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
index 09f381b..b8e91b1 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -18,4 +18,7 @@ static inline int imx_clk_scu_init(void)
 
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
