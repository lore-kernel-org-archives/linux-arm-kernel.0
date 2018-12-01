Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F3FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:55:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3C72081D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gOTuOiBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IersEXYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3C72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g95F6PMZPVD7UXzIdHo3uojvrzdJUCNXnzQvfhXLHek=; b=gOTuOiBV4j1D8S
	ODAUw28WMGqEgmjCNmXwl/knCwOxKwcvT/mFwSpfVq5YALcm48RHhOowQLKmnVjKT13Ia9XhraNoS
	ee+9FU96ZZ9YxBvlAGCcqMEg3d0JROc8Fr8v8Fp/zCGKjgh6LrVnVLWMw0sMShKybF+igaoJZpXNw
	k/MPLWCH5frgNaSPlBjEV3HGHYEKl/vdjXOIwLQFzSo3b/8L3a1OPAa+UXksOQoQyC6q7U55/3ACC
	GmXMkBnJejA0kYaYpn8B8NgkyP7GfidCNT90sAHWiKHT/1/Ls1I1oTq95APUrR1ImUB1iLpd0O2mv
	U6EkAoH4jj9TXPZE3f7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT2vh-0004vP-2A; Sat, 01 Dec 2018 10:55:21 +0000
Received: from mail-am5eur03on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::62e]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT2sx-0002Jt-A8
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 10:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1HTIs0HIkQmyS5azJTEGlvOkh6BvPA/Kfw/MovTUmQ=;
 b=IersEXYVnAndn3yY+IOmEIakBbWIbYiMoohPa8NKhePAM0uj5rHYXcGcp5ziLxlh4pGNbEpl40sfrgFz5fJEhrY7UkNcZ6LSKDVav23XARKSQeJk8gSOGPdS5s69PaNlqXHiza4KlqoRI4XpKdP0uCoKKGv8FjiHQi9XGfX5hSM=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3622.eurprd04.prod.outlook.com (52.133.20.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Sat, 1 Dec 2018 10:52:13 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.036; Sat, 1 Dec 2018
 10:52:13 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Sascha Hauer <kernel@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, Aisheng DONG <aisheng.dong@nxp.com>, Stephen Boyd
 <sboyd@kernel.org>
Subject: [PATCH v15 3/5] clk: imx: Add SCCG PLL type
Thread-Topic: [PATCH v15 3/5] clk: imx: Add SCCG PLL type
Thread-Index: AQHUiWPq2sdHfwzEhUGihCa5ojzoiw==
Date: Sat, 1 Dec 2018 10:52:13 +0000
Message-ID: <1543661502-18573-4-git-send-email-abel.vesa@nxp.com>
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
 6:hH/KvPJI3Krv4KXZR6BzgztfMyqEAn8I8PMQgYkxNMgPJPiCGt8ySP/6FngjwVRG3oMitelXkmFzBO2KxFsOE1shTYEjosy2B93CUnkHVjDK8Yxa4sw+a73gR7aTEBX5K75rW7zuNc4R9GNzlshu8BBBM4QyCHsgrQE4NrAL2PWNpNRpsf9ASrusgNvgrnsescZZNUDDgV6PRcsk7Q+RSopAZmhvjZ6yuVSQIb2kNsbHuZZFCPU0wC6AEW9YM2QKU8TttdGO3GOy849hQhFcAaDuEDID6Y/xsMNDRf7SCqag4ZmzNjNnF3s6YmiFWo0B6IXx/JN3g6anrGjzAB9n/PiHST1eP/mvjzv2FAYJtX1fX6pnPHQ9AwhpVK8Ix52vKBwslgAWgRcSlte67yJnxQ7l9Zt4i1mXJlDPIIY72YMRK/LnULaMWuD9yoFthSOC5gD4T3s7YMCo6edXovu7Xw==;
 5:B3JXCvt/MKmGBg1LySTE0AZB1HXWtSnSw4VilNFbOK3UIr2jsGYsfQDZ3cUg95+RchkHxLjgo0uRr27s+lgSdx3NJLeV0hIk5HS3uNPsyrmtfy6taSp4iH+B8NdXXRs+7sVEegExN+tsC3DHQG+SwjpRlmRCOUVI6C6TH4YkA5k=;
 7:4m7rrO/vB1MQT9czUCIIFBWH79B3AUlTYXHfnimDeZj7SjLQQ66veU/HKATd64xgkybp677tclP33okOhDqAmHA3bDMFm0TNSS1jE4BxlyKw3d9Uu6zIcA+hfUfi9WX0/Dp44LW9AG8rpDALZPRfSw==
x-ms-office365-filtering-correlation-id: fb76fbe0-0c00-4755-2b73-08d6577b0cd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3622; 
x-ms-traffictypediagnostic: AM6PR0402MB3622:
x-microsoft-antispam-prvs: <AM6PR0402MB3622A6957B84D151ACBD4D0BF6AC0@AM6PR0402MB3622.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231454)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3622; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3622; 
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(305945005)(76176011)(53936002)(316002)(52116002)(99286004)(54906003)(3846002)(6116002)(86362001)(6512007)(106356001)(6306002)(110136005)(966005)(81156014)(81166006)(8676002)(2906002)(14454004)(476003)(11346002)(2616005)(446003)(105586002)(256004)(8936002)(478600001)(217873002)(66066001)(71200400001)(44832011)(486006)(97736004)(6486002)(6436002)(14444005)(26005)(186003)(102836004)(7416002)(5660300001)(71190400001)(4326008)(36756003)(68736007)(7736002)(386003)(6506007)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3622;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EVnNPDRwwLh92sn6DP3eZ25mO2RzKGwrgoMrUaaS4N2iJ+hYWQk1Bps4X+Co3PYk3jR/ui5PnYJwaA302YjeyDxB/eGQOQqZhS7dZqMXEp/mfXTU1VbR1vip53siJW1Q1HXpdt5KsQJfu09PI79QGwq+qzRPf5YTzpMIgc4l/AO+4yE2I+7caCXsGUPColLgNDlGYBv3glT0YuXR1kE5uvuP/JlHbcKeSnkrekOHMFHZ+b4+f2vViFrozUmAosZyL8ql+NZpoYff2hwZ5A2+Whb8TV4qE/QyWiYDICnaV5yCYyN82+bAKJwhtBRv5v1LeRB8KVtxdSj2Mbfme6Dkct72k4RcK5mxICbDtFQzzpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb76fbe0-0c00-4755-2b73-08d6577b0cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 10:52:13.1210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_025231_683250_E4F8328D 
X-CRM114-Status: GOOD (  19.46  )
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

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8.

The description of this SCCG clock can be found here:

https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=834

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 256 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4893c1f..b87513c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-sccg-pll.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
new file mode 100644
index 0000000..ee7752b
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ *
+ * This driver supports the SCCG plls found in the imx8m SOCs
+ *
+ * Documentation for this SCCG pll can be found at:
+ *   https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=834
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+#define PLL_CFG2		0x8
+
+#define PLL_DIVF1_MASK		GENMASK(18, 13)
+#define PLL_DIVF2_MASK		GENMASK(12, 7)
+#define PLL_DIVR1_MASK		GENMASK(27, 25)
+#define PLL_DIVR2_MASK		GENMASK(24, 19)
+#define PLL_REF_MASK		GENMASK(2, 0)
+
+#define PLL_LOCK_MASK		BIT(31)
+#define PLL_PD_MASK		BIT(7)
+
+#define OSC_25M			25000000
+#define OSC_27M			27000000
+
+#define PLL_SCCG_LOCK_TIMEOUT	70
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK, 0,
+					PLL_SCCG_LOCK_TIMEOUT);
+}
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = FIELD_GET(PLL_DIVF1_MASK, val);
+
+	return parent_rate * 2 * (divf + 1);
+}
+
+static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 div;
+
+	if (!parent_rate)
+		return 0;
+
+	div = rate / (parent_rate * 2);
+
+	return parent_rate * div * 2;
+}
+
+static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+	u32 divf;
+
+	if (!parent_rate)
+		return -EINVAL;
+
+	divf = rate / (parent_rate * 2);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~PLL_DIVF1_MASK;
+	val |= FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+}
+
+static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, ref, divr1, divf1, divr2, divf2;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	switch (FIELD_GET(PLL_REF_MASK, val)) {
+	case 0:
+		ref = OSC_25M;
+		break;
+	case 1:
+		ref = OSC_27M;
+		break;
+	default:
+		ref = OSC_25M;
+		break;
+	}
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divr1 = FIELD_GET(PLL_DIVR1_MASK, val);
+	divr2 = FIELD_GET(PLL_DIVR2_MASK, val);
+	divf1 = FIELD_GET(PLL_DIVF1_MASK, val);
+	divf2 = FIELD_GET(PLL_DIVF2_MASK, val);
+
+	temp64 = ref * 2;
+	temp64 *= (divf1 + 1) * (divf2 + 1);
+
+	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+
+	return temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate = *prate;
+
+	if (!parent_rate)
+		return 0;
+
+	div = rate / parent_rate;
+
+	return parent_rate * div;
+}
+
+static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	u32 val;
+	u32 divf;
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+
+	if (!parent_rate)
+		return -EINVAL;
+
+	divf = rate / parent_rate;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~PLL_DIVF2_MASK;
+	val |= FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static const struct clk_ops clk_sccg_pll1_ops = {
+	.is_prepared	= clk_pll1_is_prepared,
+	.recalc_rate	= clk_pll1_recalc_rate,
+	.round_rate	= clk_pll1_round_rate,
+	.set_rate	= clk_pll1_set_rate,
+};
+
+static const struct clk_ops clk_sccg_pll2_ops = {
+	.prepare	= clk_pll1_prepare,
+	.unprepare	= clk_pll1_unprepare,
+	.recalc_rate	= clk_pll2_recalc_rate,
+	.round_rate	= clk_pll2_round_rate,
+	.set_rate	= clk_pll2_set_rate,
+};
+
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char *parent_name,
+				void __iomem *base,
+				enum imx_sccg_pll_type pll_type)
+{
+	struct clk_sccg_pll *pll;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops = &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops = &clk_sccg_pll2_ops;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	pll->base = base;
+	pll->hw.init = &init;
+
+	hw = &pll->hw;
+
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw->clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 44a1f14..864cd8a 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -21,6 +21,11 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
 
+enum imx_sccg_pll_type {
+	SCCG_PLL1,
+	SCCG_PLL2,
+};
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
 
@@ -30,6 +35,10 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
+struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
+			     void __iomem *base,
+			     enum imx_sccg_pll_type pll_type);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
