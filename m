Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C17DC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6D1206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iUnnxkfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6D1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hQJ9EBL7MmNztA0QtCASvQ81VugVEfZKX4La4yrk7nk=; b=iUnnxkfUUcaA1i
	v8+7YPa6fy39ahEClmDNwfdgxfI911jN4JTNeVjfRWNQjLe1KP2fdfQUcRp5jh1QiNphOhltiUTY9
	ixbZ0987+KIXfq3WTGRV2djRwhi7YiZlKZd8deCvGmB/spIjjqeXhg05vp2oWkC7Ht807l24hUW3T
	rBngL7ndfDKh8y90fmfqGCpibW2aPJEyzuel8nL0+N8Tq11vsQ533KuhDMCTRb50T7Ii85zEIII0n
	RsBZw9AbTHAJT1nriDlwyYBEfIM8Dm0aSG3KQUTA9RkquztEWOGaTnL9IxCaRQQPVZ8dcrZgplFJo
	qGekmPIYpraUnt1ZWanw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUAV-0008GJ-9U; Wed, 05 Dec 2018 10:12:35 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUA4-0007n4-Vj
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:12:10 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 621865FD54; Wed,  5 Dec 2018 18:11:53 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 2/3] clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio
 module clocks
Date: Wed,  5 Dec 2018 18:11:51 +0800
Message-Id: <20181205101152.22983-3-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181205101152.22983-1-wens@csie.org>
References: <20181205101152.22983-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_021209_166187_DA04BB04 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All the audio interfaces on Allwinner SoCs need to change their module
clocks during operation, to switch between support for 44.1 kHz and 48
kHz family sample rates. The clock rate for the module clocks is
governed by their upstream audio PLL. The module clocks themselves only
have a gate, and sometimes a divider or mux. Thus any rate changes need
to be propagated upstream.

Set the CLK_SET_RATE_PARENT flag for all audio module clocks to achieve
this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index f763648a5f20..c7bf814dfd2b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -377,10 +377,10 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents, 0x0a4,
 static const char * const i2s_parents[] = { "pll-audio-8x", "pll-audio-4x",
 					    "pll-audio-2x", "pll-audio" };
 static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s_parents,
-			       0x0b0, 16, 2, BIT(31), 0);
+			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_MUX_WITH_GATE(i2s1_clk, "i2s1", i2s_parents,
-			       0x0b4, 16, 2, BIT(31), 0);
+			       0x0b4, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 /* TODO: the parent for most of the USB clocks is not known */
 static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
@@ -457,7 +457,7 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(ac_dig_4x_clk,	"ac-dig-4x",	"pll-audio-4x",
-		      0x140, BIT(30), 0);
+		      0x140, BIT(30), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
