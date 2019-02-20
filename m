Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F520206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Emuh1ac+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F520206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S0c8BWJTmCEtYGz1DRHtqWIhudwoll3N1yrI7gsGaAU=; b=Emuh1ac+ULm524
	TUtkCGYAsjrOQbMoRtX+fgifbI0LYVZTRE4jwjD1atxE0MdoC0Kh+o5nyzD1ARZzfy6Et3FquPB7/
	7xoOV69bjTNcK7FUDY1y+ENycy04QaEh91cA84gjOlNmSG6rDJO0iWTc2Z6oRSmENwFuDBgd38epJ
	jJfLDixdP4xw+zd9Ha4Uzih6I4ylX28mMFfLFDgs3UJ+H+ARZiD7VjEMB2JrHtOAjqYPBhRtrVGnC
	d0WU3ryrPaBMpxBUdMinT5CIwkgFYap27uqFD6hER1Jr8jgvfTW6b2Tlv6c8ecJBRdCrW69IzHBYz
	/jbziSKnnu3HUWCt0RVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ2g-00079k-Mn; Wed, 20 Feb 2019 11:27:58 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ1J-0005Pg-TG
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:26:44 +0000
X-Originating-IP: 109.212.12.126
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr
 [109.212.12.126])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4CF72FF80A;
 Wed, 20 Feb 2019 11:26:25 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5/7] clk: at91: add sam9x60 PLL driver
Date: Wed, 20 Feb 2019 12:26:03 +0100
Message-Id: <20190220112605.23095-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032634_844307_1161F861 
X-CRM114-Status: GOOD (  19.91  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The PLLs on the sam9x60 (PLLA and USB PLL) use a different register set and
programming model than the previous SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile          |   1 +
 drivers/clk/at91/clk-sam9x60-pll.c | 329 +++++++++++++++++++++++++++++
 drivers/clk/at91/pmc.h             |   6 +
 3 files changed, 336 insertions(+)
 create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index c75df1cad60e..0a30fc8dfcb0 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
+obj-$(CONFIG_HAVE_AT91_SAM9X60_PLL)	+= clk-sam9x60-pll.o
 obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
 obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
 obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
new file mode 100644
index 000000000000..a3d5c729e8b6
--- /dev/null
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright (C) 2019 Microchip Technology Inc.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "pmc.h"
+
+#define PMC_PLL_CTRL0	0xc
+#define		PMC_PLL_CTRL0_DIV_MSK		GENMASK(7, 0)
+#define		PMC_PLL_CTRL0_ENPLL		BIT(28)
+#define		PMC_PLL_CTRL0_ENPLLCK		BIT(29)
+#define		PMC_PLL_CTRL0_ENLOCK		BIT(31)
+
+#define PMC_PLL_CTRL1	0x10
+#define		PMC_PLL_CTRL1_FRACR_MSK		GENMASK(21, 0)
+#define		PMC_PLL_CTRL1_MUL_MSK		GENMASK(30, 24)
+
+#define PMC_PLL_ACR	0x18
+#define		PMC_PLL_ACR_UTMIVR		BIT(12)
+#define		PMC_PLL_ACR_UTMIBG		BIT(13)
+#define		PMC_PLL_ACR_LOOP_FILTER_MSK	GENMASK(31, 24)
+
+#define PMC_PLL_UPDT	0x1c
+#define		PMC_PLL_UPDT_UPDATE		BIT(8)
+
+#define PMC_PLL_ISR0	0xec
+
+#define PLL_DIV_MAX		(FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, UINT_MAX) + 1)
+#define UPLL_DIV		2
+#define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
+
+#define PLL_MAX_ID		1
+
+struct sam9x60_pll {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	spinlock_t *lock;
+	const struct clk_pll_characteristics *characteristics;
+	u32 frac;
+	u8 id;
+	u8 div;
+	u16 mul;
+};
+
+#define to_sam9x60_pll(hw) container_of(hw, struct sam9x60_pll, hw)
+
+static inline bool sam9x60_pll_ready(struct regmap *regmap, int id)
+{
+	unsigned int status;
+
+	regmap_read(regmap, PMC_PLL_ISR0, &status);
+
+	return !!(status & BIT(id));
+}
+
+static int sam9x60_pll_prepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+	struct regmap *regmap = pll->regmap;
+	unsigned long flags;
+	u8 div;
+	u16 mul;
+	u32 val;
+
+	spin_lock_irqsave(pll->lock, flags);
+	regmap_write(regmap, PMC_PLL_UPDT, pll->id);
+
+	regmap_read(regmap, PMC_PLL_CTRL0, &val);
+	div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, val);
+
+	regmap_read(regmap, PMC_PLL_CTRL1, &val);
+	mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, val);
+
+	if (sam9x60_pll_ready(regmap, pll->id) &&
+	    (div == pll->div && mul == pll->mul)) {
+		spin_unlock_irqrestore(pll->lock, flags);
+		return 0;
+	}
+
+	/* Recommended value for PMC_PLL_ACR.LOOP_FILTER is 0x9 */
+	regmap_update_bits(regmap, PMC_PLL_ACR,
+			   PMC_PLL_ACR_LOOP_FILTER_MSK, 0x9);
+
+	regmap_write(regmap, PMC_PLL_CTRL1,
+		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul));
+
+	if (pll->characteristics->upll) {
+		/* Enable the UTMI internal bandgap */
+		regmap_update_bits(regmap, PMC_PLL_ACR,
+				   PMC_PLL_ACR_UTMIBG, PMC_PLL_ACR_UTMIBG);
+
+		udelay(10);
+
+		/* Enable the UTMI internal regulator */
+		regmap_update_bits(regmap, PMC_PLL_ACR,
+				   PMC_PLL_ACR_UTMIVR, PMC_PLL_ACR_UTMIVR);
+
+		udelay(10);
+	}
+
+	regmap_update_bits(regmap, PMC_PLL_UPDT,
+			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+
+	regmap_write(regmap, PMC_PLL_CTRL0,
+		     PMC_PLL_CTRL0_ENLOCK | PMC_PLL_CTRL0_ENPLL |
+		     PMC_PLL_CTRL0_ENPLLCK | pll->div);
+
+	regmap_update_bits(regmap, PMC_PLL_UPDT,
+			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+
+	while (!sam9x60_pll_ready(regmap, pll->id))
+		cpu_relax();
+
+	spin_unlock_irqrestore(pll->lock, flags);
+
+	return 0;
+}
+
+static int sam9x60_pll_is_prepared(struct clk_hw *hw)
+{
+	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+
+	return sam9x60_pll_ready(pll->regmap, pll->id);
+}
+
+static void sam9x60_pll_unprepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(pll->lock, flags);
+
+	regmap_write(pll->regmap, PMC_PLL_UPDT, pll->id);
+
+	regmap_update_bits(pll->regmap, PMC_PLL_CTRL0,
+			   PMC_PLL_CTRL0_ENPLLCK, 0);
+
+	regmap_update_bits(pll->regmap, PMC_PLL_UPDT,
+			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+
+	regmap_update_bits(pll->regmap, PMC_PLL_CTRL0, PMC_PLL_CTRL0_ENPLL, 0);
+
+	if (pll->characteristics->upll)
+		regmap_update_bits(pll->regmap, PMC_PLL_ACR,
+				   PMC_PLL_ACR_UTMIBG | PMC_PLL_ACR_UTMIVR, 0);
+
+	regmap_update_bits(pll->regmap, PMC_PLL_UPDT,
+			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+
+	spin_unlock_irqrestore(pll->lock, flags);
+}
+
+static unsigned long sam9x60_pll_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+
+	return (parent_rate * (pll->mul + 1)) / (pll->div + 1);
+}
+
+static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
+					 unsigned long rate,
+					 unsigned long parent_rate,
+					 bool update)
+{
+	const struct clk_pll_characteristics *characteristics =
+							pll->characteristics;
+	unsigned long bestremainder = ULONG_MAX;
+	unsigned long maxdiv, mindiv, tmpdiv;
+	long bestrate = -ERANGE;
+	unsigned long bestdiv = 0;
+	unsigned long bestmul = 0;
+	unsigned long bestfrac = 0;
+
+	if (rate < characteristics->output[0].min ||
+	    rate > characteristics->output[0].max)
+		return -ERANGE;
+
+	if (!pll->characteristics->upll) {
+		mindiv = parent_rate / rate;
+		if (mindiv < 2)
+			mindiv = 2;
+
+		maxdiv = DIV_ROUND_UP(parent_rate * PLL_MUL_MAX, rate);
+		if (maxdiv > PLL_DIV_MAX)
+			maxdiv = PLL_DIV_MAX;
+	} else {
+		mindiv = maxdiv = UPLL_DIV;
+	}
+
+	for (tmpdiv = mindiv; tmpdiv <= maxdiv; tmpdiv++) {
+		unsigned long remainder;
+		unsigned long tmprate;
+		unsigned long tmpmul;
+		unsigned long tmpfrac = 0;
+
+		/*
+		 * Calculate the multiplier associated with the current
+		 * divider that provide the closest rate to the requested one.
+		 */
+		tmpmul = mult_frac(rate, tmpdiv, parent_rate);
+		tmprate = mult_frac(parent_rate, tmpmul, tmpdiv);
+		remainder = rate - tmprate;
+
+		if (remainder) {
+			tmpfrac = DIV_ROUND_CLOSEST_ULL((u64)remainder * tmpdiv * (1 << 22),
+							parent_rate);
+
+			tmprate += DIV_ROUND_CLOSEST_ULL((u64)tmpfrac * parent_rate,
+							 tmpdiv * (1 << 22));
+
+			if (tmprate > rate)
+				remainder = tmprate - rate;
+			else
+				remainder = rate - tmprate;
+		}
+
+		/*
+		 * Compare the remainder with the best remainder found until
+		 * now and elect a new best multiplier/divider pair if the
+		 * current remainder is smaller than the best one.
+		 */
+		if (remainder < bestremainder) {
+			bestremainder = remainder;
+			bestdiv = tmpdiv;
+			bestmul = tmpmul;
+			bestrate = tmprate;
+			bestfrac = tmpfrac;
+		}
+
+		/* We've found a perfect match!  */
+		if (!remainder)
+			break;
+	}
+
+	/* Check if bestrate is a valid output rate  */
+	if (bestrate < characteristics->output[0].min &&
+	    bestrate > characteristics->output[0].max)
+		return -ERANGE;
+
+	if (update) {
+		pll->div = bestdiv - 1;
+		pll->mul = bestmul - 1;
+		pll->frac = bestfrac;
+	}
+
+	return bestrate;
+}
+
+static long sam9x60_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+
+	return sam9x60_pll_get_best_div_mul(pll, rate, *parent_rate, false);
+}
+
+static int sam9x60_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+
+	return sam9x60_pll_get_best_div_mul(pll, rate, parent_rate, true);
+}
+
+static const struct clk_ops pll_ops = {
+	.prepare = sam9x60_pll_prepare,
+	.unprepare = sam9x60_pll_unprepare,
+	.is_prepared = sam9x60_pll_is_prepared,
+	.recalc_rate = sam9x60_pll_recalc_rate,
+	.round_rate = sam9x60_pll_round_rate,
+	.set_rate = sam9x60_pll_set_rate,
+};
+
+struct clk_hw * __init
+sam9x60_clk_register_pll(struct regmap *regmap, spinlock_t *lock,
+			 const char *name, const char *parent_name, u8 id,
+			 const struct clk_pll_characteristics *characteristics)
+{
+	struct sam9x60_pll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	unsigned int pllr;
+	int ret;
+
+	if (id > PLL_MAX_ID)
+		return ERR_PTR(-EINVAL);
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &pll_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	pll->id = id;
+	pll->hw.init = &init;
+	pll->characteristics = characteristics;
+	pll->regmap = regmap;
+	pll->lock = lock;
+
+	regmap_write(regmap, PMC_PLL_UPDT, id);
+	regmap_read(regmap, PMC_PLL_CTRL0, &pllr);
+	pll->div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, pllr);
+	regmap_read(regmap, PMC_PLL_CTRL1, &pllr);
+	pll->mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, pllr);
+
+	hw = &pll->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4a30c20f17f1..fb9e9c4cdc8d 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -69,6 +69,7 @@ struct clk_pll_characteristics {
 	struct clk_range *output;
 	u16 *icpll;
 	u8 *out;
+	u8 upll : 1;
 };
 
 struct clk_programmable_layout {
@@ -169,6 +170,11 @@ struct clk_hw * __init
 at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 			 const char *parent_name);
 
+struct clk_hw * __init
+sam9x60_clk_register_pll(struct regmap *regmap, spinlock_t *lock,
+			 const char *name, const char *parent_name, u8 id,
+			 const struct clk_pll_characteristics *characteristics);
+
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap, const char *name,
 			       const char **parent_names, u8 num_parents, u8 id,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
