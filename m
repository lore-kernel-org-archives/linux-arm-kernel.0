Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49289C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:53:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1818F2081D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="McSt8CHJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jG0mzUC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1818F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zj6Quutq6U/CTjE2RIYnPwHnwx0OrCWHVauvnt6wpBE=; b=McSt8CHJLkanb7
	80GZn+GSn8OnDeNssvZmp8SmuC7Wubf7OQ69bzTj5G4TbB56EWMYcVaN0wjzpb++XDP4iZjNL49/+
	PgxbJI1kqwDF76+w1ZOqNhHs+Ju8cMffL2ucj3TObbIEF10hbKi7whpkWjtHbafm4C3qkE1vlM6SM
	j51EkWBt2X8IBF0hTUPXHIfRbgt5ZjiufJJwyljMGaKJ3zkWbbkbAAdmjdvr+mQ3RI76fyNhp+s14
	bTruE9Bbw2ouOs0bRxLJhz8xSY9uwVvOmORnJyDufAoxd+unUVW0cE7Jnvc7xsMakS0PQScc/USnm
	ZM8zuyUlkVnB0agsvDAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT2tP-0002tg-Pe; Sat, 01 Dec 2018 10:52:59 +0000
Received: from mail-am5eur03on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::62e]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT2t4-0002Jt-9q
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 10:52:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9oLdGrbrumszVQP77qQN7tHMWaLYSe8v/cMPZ7dqFY=;
 b=jG0mzUC17mEJ6ECbFbmUD6hUQIwqAMeZX6W/+W1x8UG24gdwRiT3uKF0WR053Zt9ZaYroGf5UjxbVj908/3g6EnAc2a7rRdrFMO8UP+4G768VMHovwIl3f9gOnfe3SBMh+hlzFIv6YbBdI8h2u0mPivEULGR0ChsZ146+TNVHEk=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3622.eurprd04.prod.outlook.com (52.133.20.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Sat, 1 Dec 2018 10:52:14 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.036; Sat, 1 Dec 2018
 10:52:14 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Sascha Hauer <kernel@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, Aisheng DONG <aisheng.dong@nxp.com>, Stephen Boyd
 <sboyd@kernel.org>
Subject: [PATCH v15 4/5] clk: imx: Add imx composite clock
Thread-Topic: [PATCH v15 4/5] clk: imx: Add imx composite clock
Thread-Index: AQHUiWPrFjWICst1hEOkPNFe63f7mw==
Date: Sat, 1 Dec 2018 10:52:14 +0000
Message-ID: <1543661502-18573-5-git-send-email-abel.vesa@nxp.com>
References: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:209::30) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3622;
 6:qAdhjhIb1KIcRe6gNxo/fUmn7PRZiyOHqmxLvPccpacmHz1hDxmp8I1a0DlBp9S/aOgCHcT6xHgKtRagH8n8cla/u46dNOaxaZc5E1OLjbUCLMdDGQZjL5+HFmuh1ZapWeVtgAPdCVMNe7KeavBmThfMyWhQwLE03SzoEVHHx0GPwn2o+CctWDm8VhuauL7SxwvC1CKLbn+m9pa+kstS4ktzAfXQPsB/MJiATC7/GpneJ0lEh8zjDfttTmpilrKnT7eS+ngAX6HjryTFOelAL3p6gr0tyOQUpD+TeWMv+XuwBg+grFES8O3cwPLhk8Yf5kHxldtmmiFiZh1Tnr6PddRyvZ+4KCSzMa2uC6rYyAGZjNlQDkfyjYnvdu1rDqunGYit99wclaVwZo+1DoBC4v2ugTkUr7rxdHMwFXGu1YNq4PgoIum56VePq1zEG8nDw5o58ltZziV2Q+3QSfWm6g==;
 5:QgdbUkHZ8l2La1SL2nDpc8LlWSeFIFCDGJnt/iAVQRiS00tI6QUndkqQ5KF71fbX97qlUcP0mnhderihdlnJrE+bnLA5tpz00W7AY00IH1L1rIHctuD/Mx9X85MmiDO8ltAqvr8ufe/7x5Rj/9tS/AkzYlgMimQprTHJO8KJMGE=;
 7:8jfjyrr9iWiPjGTO6Ag6qte9eS0HZXY551rwuDs2db9+TDv8itOy7aAvr+Bf10pbIv+09swRU3771tgU92EDs6kOo/e61FuFGnl0ICqJfe5XonHM8ACIUIKuZm2Fws8c0ZuCfW+hbFJQWUgzOoVXxw==
x-ms-office365-filtering-correlation-id: 082f8fdc-4a61-4a55-5e73-08d6577b0d8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3622; 
x-ms-traffictypediagnostic: AM6PR0402MB3622:
x-microsoft-antispam-prvs: <AM6PR0402MB3622169F5704E50FAAE53158F6AC0@AM6PR0402MB3622.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231454)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3622; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3622; 
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(305945005)(76176011)(53936002)(316002)(52116002)(99286004)(54906003)(3846002)(6116002)(575784001)(86362001)(6512007)(106356001)(110136005)(81156014)(81166006)(8676002)(2906002)(14454004)(476003)(11346002)(2616005)(446003)(105586002)(256004)(8936002)(478600001)(66066001)(71200400001)(44832011)(486006)(97736004)(6486002)(6436002)(14444005)(26005)(186003)(102836004)(7416002)(5660300001)(71190400001)(4326008)(36756003)(68736007)(7736002)(386003)(6506007)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3622;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DHDZ2oP2tQSOIXgne8oXqau95q0hV97Axqs5PKe/5THmob+mgLyITiJnx7RJMV0483gHsFfKbNDj4nSddUGGFeFVHEUYPsUG2Mno/LuUIbBUVjVDL0DaHcGvCPjR79VMk6a30NXu0kYIIu1hRhwuOJatdFshed7nxAkhfKhmVL4ICehPFoYOpvC6UrSDbo2L1BEo4RCzgoNix1ejWlfrWFJ+NfSM+hzpQbrkSdoFTU907pxgDi0DKSDV7LvoxNHapYfiqD0mszIVCmQsnMMjDWFOnQLkwEvEpu9m9XK0syF0agZfnOdo8ZBc6QcDrJfMggdCHkIaemi8kGAt03Aeb300SMUhqVh+36EHCmzzDXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082f8fdc-4a61-4a55-5e73-08d6577b0d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 10:52:14.2147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_025238_802424_37D5F0D9 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since a lot of clocks on imx8m are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx8m_clk_composite_divider_ops and register
the composite clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile           |   1 +
 drivers/clk/imx/clk-composite-8m.c | 178 +++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h              |  16 ++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-8m.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..237444b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y += \
 	clk.o \
 	clk-busy.o \
+	clk-composite-8m.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
new file mode 100644
index 0000000..6d9d371
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+
+#include "clk.h"
+
+#define PCG_PREDIV_SHIFT	16
+#define PCG_PREDIV_WIDTH	3
+#define PCG_PREDIV_MAX		8
+
+#define PCG_DIV_SHIFT		0
+#define PCG_DIV_WIDTH		6
+#define PCG_DIV_MAX		64
+
+#define PCG_PCS_SHIFT		24
+#define PCG_PCS_MASK		0x7
+
+#define PCG_CGC_SHIFT		28
+
+static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value = readl(divider->reg) >> divider->shift;
+	prediv_value &= clk_div_mask(divider->width);
+
+	prediv_rate = divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value = readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &= clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
+				   divider->flags, PCG_DIV_WIDTH);
+}
+
+static int imx8m_clk_composite_compute_dividers(unsigned long rate,
+						unsigned long parent_rate,
+						int *prediv, int *postdiv)
+{
+	int div1, div2;
+	int error = INT_MAX;
+	int ret = -EINVAL;
+
+	*prediv = 1;
+	*postdiv = 1;
+
+	for (div1 = 1; div1 <= PCG_PREDIV_MAX; div1++) {
+		for (div2 = 1; div2 <= PCG_DIV_MAX; div2++) {
+			int new_error = ((parent_rate / div1) / div2) - rate;
+
+			if (abs(new_error) < abs(error)) {
+				*prediv = div1;
+				*postdiv = div2;
+				error = new_error;
+				ret = 0;
+			}
+		}
+	}
+	return ret;
+}
+
+static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	int prediv_value;
+	int div_value;
+
+	imx8m_clk_composite_compute_dividers(rate, *prate,
+						&prediv_value, &div_value);
+	rate = DIV_ROUND_UP(*prate, prediv_value);
+
+	return DIV_ROUND_UP(rate, div_value);
+
+}
+
+static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	int prediv_value;
+	int div_value;
+	int ret = 0;
+	u32 val;
+
+	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
+						&prediv_value, &div_value);
+	if (ret)
+		return -EINVAL;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val = readl(divider->reg);
+	val &= ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |= (u32)(prediv_value  - 1) << divider->shift;
+	val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
+	writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops imx8m_clk_composite_divider_ops = {
+	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
+	.round_rate = imx8m_clk_composite_divider_round_rate,
+	.set_rate = imx8m_clk_composite_divider_set_rate,
+};
+
+struct clk *imx8m_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *hw = ERR_PTR(-ENOMEM), *mux_hw;
+	struct clk_hw *div_hw, *gate_hw;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = PCG_PCS_SHIFT;
+	mux->mask = PCG_PCS_MASK;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = PCG_PREDIV_SHIFT;
+	div->width = PCG_PREDIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto fail;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+			mux_hw, &clk_mux_ops, div_hw,
+			&imx8m_clk_composite_divider_ops,
+			gate_hw, &clk_gate_ops, flags);
+	if (IS_ERR(hw))
+		goto fail;
+
+	return hw->clk;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return ERR_CAST(hw);
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 864cd8a..cb3e92c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -239,4 +239,20 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx8m_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags);
+
+#define __imx8m_clk_composite(name, parent_names, reg, flags) \
+	imx8m_clk_composite_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, \
+		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx8m_clk_composite(name, parent_names, reg) \
+	__imx8m_clk_composite(name, parent_names, reg, 0)
+
+#define imx8m_clk_composite_critical(name, parent_names, reg) \
+	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
