Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646DC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656F32147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Heh8sULb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656F32147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sf8YDwJOJRFKHPBdHPWBr8MEvJKd2v4qc7DebOqOFDw=; b=Heh8sULbqe5/yA
	2V00MLGV9nEdUqk/DLowcmz8op+TjWwpOCKgdcyS+6Ga6NVOXulb2w9s5RPRsHt8/wVSO4vSMMGvG
	EBkT4Oa7x7I/RrbFG0tpKzot9u11TupjDhVILLRwHcX+dCtxbs3DMx++Ru7siZ2FCZAa4VoxbyCHx
	8MxC0vYeyOTKtmKthmRhH2N/KXFy9rDBzXr5oC7lnlgWLJITT360dxQ/iLfhjUWYcgpczHuPvXQfi
	oQup56n9orQ8sjJMV3GTAYGYS3c+E2En+/JY1BCSuxdKLgcrdQhI4qFKI3nkzVZZireEj9/S+00jW
	P/N0mSRh307wekGLZ5Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8nC-0001N9-EX; Tue, 19 Feb 2019 17:02:50 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8mb-0000d8-JA
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:02:16 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F0FC61BF217;
 Tue, 19 Feb 2019 17:02:07 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 2/7] clk: at91: modernize sckc binding
Date: Tue, 19 Feb 2019 18:01:55 +0100
Message-Id: <20190219170200.3608-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090213_933536_7756614B 
X-CRM114-Status: GOOD (  13.86  )
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

Remove the need for child nodes in the sckc binding and register the whole
sckc tree (3 clocks in total) from the sckc node.

DT backward compatibility is kept by looking for properties in child nodes
when they are not present in the sckc node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 125 ++++++++++++----------------------------
 1 file changed, 36 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab6ecefc49ad..470aef586f57 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -152,28 +152,6 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init
-of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	u32 startup;
-	bool bypass;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	of_property_read_string(np, "clock-output-names", &name);
-	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
-	bypass = of_property_read_bool(np, "atmel,osc-bypass");
-
-	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
-					 bypass);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
 static unsigned long clk_slow_rc_osc_recalc_rate(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
@@ -266,28 +244,6 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init
-of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
-{
-	struct clk_hw *hw;
-	u32 frequency = 0;
-	u32 accuracy = 0;
-	u32 startup = 0;
-	const char *name = np->name;
-
-	of_property_read_string(np, "clock-output-names", &name);
-	of_property_read_u32(np, "clock-frequency", &frequency);
-	of_property_read_u32(np, "clock-accuracy", &accuracy);
-	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
-
-	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
-					    startup);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
 static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_sam9x5_slow *slowck = to_clk_sam9x5_slow(hw);
@@ -365,64 +321,55 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init
-of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
+static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 {
+	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
+	void __iomem *regbase = of_iomap(np, 0);
+	struct device_node *child = NULL;
+	const char *xtal_name;
 	struct clk_hw *hw;
-	const char *parent_names[2];
-	unsigned int num_parents;
-	const char *name = np->name;
+	bool bypass;
 
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > 2)
+	if (!regbase)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
-					    num_parents);
+	hw = at91_clk_register_slow_rc_osc(regbase, parent_names[0], 32768,
+					   50000000, 75);
 	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
+	xtal_name = of_clk_get_parent_name(np, 0);
+	if (!xtal_name) {
+		/* DT backward compatibility */
+		child = of_get_compatible_child(np, "atmel,at91sam9x5-clk-slow-osc");
+		if (!child)
+			return;
+
+		xtal_name = of_clk_get_parent_name(child, 0);
+		bypass = of_property_read_bool(child, "atmel,osc-bypass");
+
+		child =  of_get_compatible_child(np, "atmel,at91sam9x5-clk-slow");
+	} else {
+		bypass = of_property_read_bool(np, "atmel,osc-bypass");
+	}
 
-static const struct of_device_id sckc_clk_ids[] __initconst = {
-	/* Slow clock */
-	{
-		.compatible = "atmel,at91sam9x5-clk-slow-osc",
-		.data = of_at91sam9x5_clk_slow_osc_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-slow-rc-osc",
-		.data = of_at91sam9x5_clk_slow_rc_osc_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-slow",
-		.data = of_at91sam9x5_clk_slow_setup,
-	},
-	{ /*sentinel*/ }
-};
+	if (!xtal_name)
+		return;
 
-static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
-{
-	struct device_node *childnp;
-	void (*clk_setup)(struct device_node *, void __iomem *);
-	const struct of_device_id *clk_id;
-	void __iomem *regbase = of_iomap(np, 0);
+	hw = at91_clk_register_slow_osc(regbase, parent_names[1], xtal_name,
+					1200000, bypass);
+	if (IS_ERR(hw))
+		return;
 
-	if (!regbase)
+	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
+	if (IS_ERR(hw))
 		return;
 
-	for_each_child_of_node(np, childnp) {
-		clk_id = of_match_node(sckc_clk_ids, childnp);
-		if (!clk_id)
-			continue;
-		clk_setup = clk_id->data;
-		clk_setup(childnp, regbase);
-	}
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+
+	/* DT backward compatibility */
+	if (child)
+		of_clk_add_hw_provider(child, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
