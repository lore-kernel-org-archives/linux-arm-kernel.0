Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF216C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB0A20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jXZNdW3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB0A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ibPAlacaPZXnDDDztJzx/BOCheKudgh60mwlwqn8PiQ=; b=jXZNdW3M6MiJ3x
	K60Xg8Fui87K6MtoBbl2Z+a9obW1o6CZcI9n+aO1yp/OWeb3iz4SPi7lImabOZT6y3HIJ/MMBDTs9
	J+mu/lfYs3qj7iv/k9ChnzzsIbu9Rd5hPIMjsRfON20mKzur4dsmgnSGBG8ePOvxvNoMSuIV2et5I
	HIGZ/xQWJU5f5Uoz7hDP0juKY0LHSjSO1vTp/m94ScXjYLhycHShuDQ+mdc9S4BfNyNa1t+d0dgOf
	rY996lbze74tK9VEATkFP1DdjAlyDZrDwlFyB6cFjn+tWCC3qQH0tBFBsV8ldkTvOnL1mEGD1IF0r
	YYSJuGqrGsJ4+UfO8lMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTuNI-00058u-Fi; Mon, 03 Dec 2018 19:59:24 +0000
Received: from mailoutvs22.siol.net ([185.57.226.213] helo=mail.siol.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTuNE-00057i-EL
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:59:22 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTP id 6227A520C87;
 Mon,  3 Dec 2018 20:59:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id VLSliXAtcz-y; Mon,  3 Dec 2018 20:59:02 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTPS id 1A51E520119;
 Mon,  3 Dec 2018 20:59:02 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Postfix) with ESMTPSA id 9AE17520C93;
 Mon,  3 Dec 2018 20:59:01 +0100 (CET)
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com,
	wens@csie.org
Subject: [PATCH] clk: sunxi-ng: h3: Allow parent change for ve clock
Date: Mon,  3 Dec 2018 20:58:56 +0100
Message-Id: <20181203195856.1886-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_115920_641762_49E557BA 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cedrus driver wants to set VE clock higher than it's possible without
changing parent rate.

In order to correct that, allow changing parent rate for VE clock.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index eb5c608428fa..e52155770f39 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -481,7 +481,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-mclk", csi_mclk_parents,
 				 0x134, 0, 5, 8, 3, BIT(15), 0);
 
 static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
-			     0x13c, 16, 3, BIT(31), 0);
+			     0x13c, 16, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), CLK_SET_RATE_PARENT);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
