Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF21C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAD8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AAWPtRjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAD8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VUnV1rWq+izq7t9PBMrbibP3yjstCOywJY0OiVol8xI=; b=AAWPtRjN/hPDeL
	3+Uak4P0XWfDphTL73un1nfSeHBKNoF33AcOTcDX1cOrDHxhDThj8BKEFkeJEVMH9Ngj7cUgKEagf
	gxLCue6I2gOpDA+Lt0LKX+S7g91bUedaYjfWsJJb4ATfMQKKir6jyOfWR7pMm73zK8GjW5DNC1Vzc
	YAZ4EEdHDkjXSXEk1HQ/7sfhqrLRD9X5+oyFHFa+xRKuNKr1AUVPHhPqHv8gKXpayp5E3vU/Q/Ind
	dY9QYtDYYZaH4VH3XBmuQZOsyynfRd/sPf3pi2kuk+yc2YMF82EYYuffSyp83R6LS26/dgegFxzeH
	1XLRoCSqxLUw5rSjROQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ1I-0005Ps-Of; Wed, 20 Feb 2019 11:26:32 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ19-0005D1-Ef
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:26:30 +0000
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr
 [109.212.12.126])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4FB70240009;
 Wed, 20 Feb 2019 11:26:20 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/7] clk: at91: usb: Add sam9x60 support
Date: Wed, 20 Feb 2019 12:26:01 +0100
Message-Id: <20190220112605.23095-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032624_399995_C0DB6ADE 
X-CRM114-Status: GOOD (  10.96  )
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

The sam9x60 USB clock supports four different parents, ensure they can be
selected.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-usb.c | 33 +++++++++++++++++++++++++++------
 drivers/clk/at91/pmc.h     |  3 +++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 79ee1c760f2a..ebc37ee33518 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -23,9 +23,13 @@
 #define RM9200_USB_DIV_SHIFT	28
 #define RM9200_USB_DIV_TAB_SIZE	4
 
+#define SAM9X5_USBS_MASK	GENMASK(0, 0)
+#define SAM9X60_USBS_MASK	GENMASK(1, 0)
+
 struct at91sam9x5_clk_usb {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	u32 usbs_mask;
 };
 
 #define to_at91sam9x5_clk_usb(hw) \
@@ -111,8 +115,7 @@ static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
 	if (index > 1)
 		return -EINVAL;
 
-	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_USBS,
-			   index ? AT91_PMC_USBS : 0);
+	regmap_update_bits(usb->regmap, AT91_PMC_USB, usb->usbs_mask, index);
 
 	return 0;
 }
@@ -124,7 +127,7 @@ static u8 at91sam9x5_clk_usb_get_parent(struct clk_hw *hw)
 
 	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
 
-	return usbr & AT91_PMC_USBS;
+	return usbr & usb->usbs_mask;
 }
 
 static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -190,9 +193,10 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 	.set_rate = at91sam9x5_clk_usb_set_rate,
 };
 
-struct clk_hw * __init
-at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents)
+static struct clk_hw * __init
+_at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
+			     const char **parent_names, u8 num_parents,
+			     u32 usbs_mask)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
@@ -212,6 +216,7 @@ at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 	usb->hw.init = &init;
 	usb->regmap = regmap;
+	usb->usbs_mask = SAM9X5_USBS_MASK;
 
 	hw = &usb->hw;
 	ret = clk_hw_register(NULL, &usb->hw);
@@ -223,6 +228,22 @@ at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 	return hw;
 }
 
+struct clk_hw * __init
+at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
+			    const char **parent_names, u8 num_parents)
+{
+	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					    num_parents, SAM9X5_USBS_MASK);
+}
+
+struct clk_hw * __init
+sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
+			 const char **parent_names, u8 num_parents)
+{
+	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					    num_parents, SAM9X60_USBS_MASK);
+}
+
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name)
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4027306b904c..44345e4ab1c9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -194,6 +194,9 @@ struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name);
 struct clk_hw * __init
+sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
+			 const char **parent_names, u8 num_parents);
+struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char *parent_name, const u32 *divisors);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
