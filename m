Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE6C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:09:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327E120651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mVeeIo+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327E120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=g8vC99sdp9LKzbx4T4uYO/R3ZfrDPzpr8+kUoiafk6Y=; b=mVeeIo+vpQ1nfD
	6lrFPepUsYv832Nlzc7beEIao9x4HOotzX7THuKou22uTvoIBZLWFvvIEd1Awp1fJf1QHTojwxuP8
	1LKIn70x49S3S93m3x458OpCx7P0lPiaGddC2dOrj72OsWGotI817SLpT0KfeGiEczfzcbbhzzGFA
	PRzJEOqf7WfEYyiLAVSO6MTMH2lrfvHT+/lIZlk1z2mCs/64v9NQUe1ApWYc3faTxka+JorHYZDlA
	kRv9ALDeLiZ2n7rZi9KxAYOHnV3a0i9stvjaqoSP4UdJFfs9bIWYNkvB46PpWpoifUq4pJAK/Vt/C
	yhBGBMW2evqohm1jgDsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKsW-0006V0-2v; Sat, 23 Feb 2019 00:09:16 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKsS-0006UJ-Bz
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 00:09:14 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7A4091C000F;
 Sat, 23 Feb 2019 00:09:00 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: at91: programmable: remove unneeded register read
Date: Sat, 23 Feb 2019 01:08:58 +0100
Message-Id: <20190223000858.28094-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_160912_558758_F68C2D0B 
X-CRM114-Status: UNSURE (   8.42  )
X-CRM114-Notice: Please train this message.
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

This register read is a leftover of a previous read/modify/write. We now use
regmap_update_bits(), so we don't need it anymore.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-programmable.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 5bc68b9c5498..89d6f3736dbf 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -132,11 +132,8 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_programmable *prog = to_clk_programmable(hw);
 	const struct clk_programmable_layout *layout = prog->layout;
 	unsigned long div = parent_rate / rate;
-	unsigned int pckr;
 	int shift = 0;
 
-	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
-
 	if (!div)
 		return -EINVAL;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
