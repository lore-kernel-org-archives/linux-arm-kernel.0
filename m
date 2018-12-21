Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1324121917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nVk9H3zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1324121917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=00D+coc7qTiqya72GUDTiURk4IDRxCr+yW3W0cvv1T0=; b=nVk9H3zkPmggWL
	jclSIEMe/2ED6VyX9CX3EeCy5lrHIXWSyFpW9In5RhAJ77rMS5hO0tLQ+88J1jrFsKLyl1J4oLak2
	QKdCroXq4CDg1Uz9b4yHmYUi1DmStQGTQNmnIxCr+6o0Dan1MSBe8NHCwU7UEwRqf33rQExbCf3Sf
	cMO2YHEV6R7c5YkZCQ+BrKTsor+Gjt0KDm7YkhIla59F4KUWuVR0OWIsweX7XrAashZ/ADES2CtWK
	Gaq8jCLVFmq5vcl5NZ5lEmbmLiXWMufEQTfQhT3CEw1h1su14GmHMGyxUWKUpv5c9B7QG6MTiAhv1
	0OAnxkID34H3nOgR0uSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaOg1-0007MI-2R; Fri, 21 Dec 2018 17:33:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaOfx-0007Ip-Hi
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:33:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3AA9320734; Fri, 21 Dec 2018 18:33:16 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 082372079F;
 Fri, 21 Dec 2018 18:33:06 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pinctrl: armada-37xx: add missing pin: PCIe1 Wakeup
Date: Fri, 21 Dec 2018 18:32:58 +0100
Message-Id: <20181221173259.8372-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221173259.8372-1-gregory.clement@bootlin.com>
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_093329_720343_46233E7D 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Declare the PCIe1 Wakeup which was initially missing.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 267dfc530985..4b9f2cf94431 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -198,6 +198,7 @@ static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
 	PIN_GRP_GPIO("smi", 18, 2, BIT(4), "smi"),
 	PIN_GRP_GPIO("pcie1", 3, 1, BIT(5), "pcie"),
 	PIN_GRP_GPIO("pcie1_clkreq", 4, 1, BIT(9), "pcie"),
+	PIN_GRP_GPIO("pcie1_wakeup", 5, 1, BIT(10), "pcie"),
 	PIN_GRP_GPIO("ptp", 20, 3, BIT(11) | BIT(12) | BIT(13), "ptp"),
 	PIN_GRP("ptp_clk", 21, 1, BIT(6), "ptp", "mii"),
 	PIN_GRP("ptp_trig", 22, 1, BIT(7), "ptp", "mii"),
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
