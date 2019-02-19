Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85343C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583EC2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZU5yoax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583EC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2zgpjGnWt1TOOqj7iojQpm6g7gGQs0ht4NRwPt2oGyU=; b=TZU5yoaxG22QvF
	Byg/D7Ig6cWTwuqESnkdDYUj31VXFUQg6yiHp4PfjC0htfCesR3G/2aP5zceRZrDiRnsAjRq1GszC
	gC6Qs9hTaNqa2PnKfGODmGAplZU0yFBHY5feZ2UC2hh6pSNf7VqbNzBC4mx7ULzb7jV1ZFwwwHb2t
	Ev6fAC9/DcAu7mYgQdEwaAr9oSPrF02gNltB37fn5IN1D4MmytoKcWTt4IazjB89pLbIyt0lQTfq0
	C6na7Gg1UgIpw6oU59nvtfEKlNbLIj89ArMUgaoBlCkH0y2f9q047UjsycB5QeIeN2Hu5k5oM2X0k
	pNfIyM58q90Dd6g7/4Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8mf-0000f7-49; Tue, 19 Feb 2019 17:02:17 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8mb-0000d5-8N
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:02:14 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E9E1A20013;
 Tue, 19 Feb 2019 17:02:03 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/7] clk: at91: rework sckc bindings
Date: Tue, 19 Feb 2019 18:01:53 +0100
Message-Id: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090213_446396_37C4B897 
X-CRM114-Status: UNSURE (   7.82  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This is a rework of the sckc DT bindings to avoid warnings with dtc.
DT backward compatibility is kept.

This series also fix a possible issue with the sama5d3 slow RC
oscillator.

The sckc driver changes and documetation can go through the clk tree and
we will handle th DT changes.

Alexandre Belloni (7):
  dt-bindings: clock: at91: new sckc bindings
  clk: at91: modernize sckc binding
  clk: at91: sckc: handle different RC startup time
  ARM: dts: at91: at91sam9x5: switch to new sckc bindings
  ARM: dts: at91: at91sam9g45: switch to new sckc bindings
  ARM: dts: at91: at91sam9rl: switch to new sckc bindings
  ARM: dts: at91: sama5d3: switch to new sckc bindings

 .../devicetree/bindings/clock/at91-clock.txt  |  30 ++--
 arch/arm/boot/dts/at91-wb50n.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |  25 +---
 arch/arm/boot/dts/at91sam9rl.dtsi             |  25 +---
 arch/arm/boot/dts/at91sam9x5.dtsi             |  23 +--
 arch/arm/boot/dts/sama5d3.dtsi                |  27 +---
 drivers/clk/at91/sckc.c                       | 134 ++++++------------
 7 files changed, 73 insertions(+), 193 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
