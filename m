Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C7C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC0C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHSEiGG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC0C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rv0E8oHw/TQIrgEavxnKj+/jahmMAEth+Tk4pn/Zak8=; b=nHSEiGG/AV6tqz
	gxO6oIUGbQyX82cK4ly7imb+8w7ELB18+m8qKdsfDcD3b4qtGIKmX8FPKCXfkwjx2GQiZMF36CS1p
	zPJg6EX6xThRyjif0CMfI61VwRzUH4+3hvGMBbZanIkW1DHCKpPoPX2o0LYx178tSdDktr9K/mhmM
	TIKNz0kvowcplH02jbIuKQWuA6caAxC8KOzOAluQrLBsTjn8cJh8sTp2A3TtiAqEEH0SIizGTINjb
	SAn1nzJIHyA8uXglZ1ys4Cac5DYeeBtFRYy9Yf+ZDqe/0we612W6sxOEfhpqqo4X+15sCVgFmFSKR
	xJbq5X7m219gKLV7zIxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ1S-0005br-AX; Wed, 20 Feb 2019 11:26:42 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ1B-0005Fz-G4
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:26:30 +0000
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr
 [109.212.12.126])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id C143F200007;
 Wed, 20 Feb 2019 11:26:22 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4/7] clk: at91: master: Add sam9x60 support
Date: Wed, 20 Feb 2019 12:26:02 +0100
Message-Id: <20190220112605.23095-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032625_934413_45D8064E 
X-CRM114-Status: GOOD (  12.10  )
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

The sam9x60 cpu clock is located at a different offset but is otherwise
similar to the master clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-master.c | 8 +++++---
 drivers/clk/at91/pmc.h        | 1 +
 include/linux/clk/at91_pmc.h  | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index eb53b4a8fab6..12b5bf4cc7bb 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -29,6 +29,7 @@ struct clk_master {
 	struct regmap *regmap;
 	const struct clk_master_layout *layout;
 	const struct clk_master_characteristics *characteristics;
+	u32 mckr;
 };
 
 static inline bool clk_master_ready(struct regmap *regmap)
@@ -69,7 +70,7 @@ static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
 						master->characteristics;
 	unsigned int mckr;
 
-	regmap_read(master->regmap, AT91_PMC_MCKR, &mckr);
+	regmap_read(master->regmap, master->layout->offset, &mckr);
 	mckr &= layout->mask;
 
 	pres = (mckr >> layout->pres_shift) & MASTER_PRES_MASK;
@@ -95,7 +96,7 @@ static u8 clk_master_get_parent(struct clk_hw *hw)
 	struct clk_master *master = to_clk_master(hw);
 	unsigned int mckr;
 
-	regmap_read(master->regmap, AT91_PMC_MCKR, &mckr);
+	regmap_read(master->regmap, master->layout->offset, &mckr);
 
 	return mckr & AT91_PMC_CSS;
 }
@@ -147,13 +148,14 @@ at91_clk_register_master(struct regmap *regmap,
 	return hw;
 }
 
-
 const struct clk_master_layout at91rm9200_master_layout = {
 	.mask = 0x31F,
 	.pres_shift = 2,
+	.offset = AT91_PMC_MCKR,
 };
 
 const struct clk_master_layout at91sam9x5_master_layout = {
 	.mask = 0x373,
 	.pres_shift = 4,
+	.offset = AT91_PMC_MCKR,
 };
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 44345e4ab1c9..4a30c20f17f1 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -38,6 +38,7 @@ struct clk_range {
 #define CLK_RANGE(MIN, MAX) {.min = MIN, .max = MAX,}
 
 struct clk_master_layout {
+	u32 offset;
 	u32 mask;
 	u8 pres_shift;
 };
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 31f00ebf1315..0c53f26ae3d3 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -74,6 +74,8 @@
 #define			AT91_PMC_USBDIV_4		(2 << 28)
 #define		AT91_PMC_USB96M		(1     << 28)		/* Divider by 2 Enable (PLLB only) */
 
+#define AT91_PMC_CPU_CKR	0x28			/* CPU Clock Register */
+
 #define	AT91_PMC_MCKR		0x30			/* Master Clock Register */
 #define		AT91_PMC_CSS		(3 <<  0)		/* Master Clock Selection */
 #define			AT91_PMC_CSS_SLOW		(0 << 0)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
