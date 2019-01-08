Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98279C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A98E214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ISXf2onc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A98E214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2NDUvepmDHPuY6LhbaAU8vjz8nUobcKd1p5qBfZz/DE=; b=ISXf2oncI4wenG
	68928LEP+689D1t/ohqvRd0vp0XczgLTomd7ME8Z4/ih555ptisQiMxeedFw9J8MZKjwiUpXJDcQM
	bBi5o1SW7sfN4lFPA8PL9NDYu3HaM0UUN1nZUsYIUX7nDCVVNS8RUJSZyqBnVWvqTojhaJeJ2JyRF
	Tdgl+82xgyM0P1Ktj2w+xfVysoTdvttd49eU/U/ZvmROc377iuLNAeL0kxfeOzE/BIF4WyMht5Ipz
	rTCDQGhsQ1+TovursLynj+OQl3l+lp77zWvC/VhPTAaiMgQteifb7pOI307BYHuNXI81Tg6ACbl/D
	JWMqBn5ov2LUOZVLwF1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggu6V-0005R5-Ha; Tue, 08 Jan 2019 16:19:47 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggu6R-0005P0-GU
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:19:45 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E9D7C20A08; Tue,  8 Jan 2019 17:19:41 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id A40EF209C2;
 Tue,  8 Jan 2019 17:19:41 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 2/4] clk: mvebu: armada-37xx-tbg: fix error message
Date: Tue,  8 Jan 2019 17:19:38 +0100
Message-Id: <20190108161940.4814-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108161940.4814-1-miquel.raynal@bootlin.com>
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_081943_682008_CE1AB1FF 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The error message should state that the driver failed to get the
parent clock, not the opposite.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-tbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index ee272d4d8c24..77b978c55ef6 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -98,7 +98,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 
 	parent = clk_get(dev, NULL);
 	if (IS_ERR(parent)) {
-		dev_err(dev, "Could get the clock parent\n");
+		dev_err(dev, "Could not get the clock parent\n");
 		return -EINVAL;
 	}
 	parent_name = __clk_get_name(parent);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
