Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84026206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UcbaFpIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84026206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NQJN5jnX3dQZ5E6iO7kK8837u4lRimh0hQCHKQHlldc=; b=UcbaFpIc9YG8qL
	pfyAylMM+TGB9/UwTsavmkdbrF2NkMOuWG0mTeorAh/190lN6tyR6TXHrlCQIIa9ppUQO5l2fi9+p
	ZFCdLT7FHlvHQJ317xT9oyldvgqVwG7Y0x0Do0ijb0HNsyp92Qn2n8GaitI1bEAhgXc1v9ohBkk1z
	DXPUNEeixNRWemJiTyThin0o2SLS8ia9DcCm33aie1lRoqmngXhHTrNNdzO6EbtzvRWNfpxFAOHA8
	pL3UioLkYSeKvNZNYhx7E/br2qkgmz5x83Kh6KEePmk1d67Oy0Zvx8jGCM0q7J2bYVBUMbuijK7my
	mnaK6zGKJgnpcl9xQo6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ15-00058d-9N; Wed, 20 Feb 2019 11:26:19 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ11-000588-RF
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:26:17 +0000
X-Originating-IP: 109.212.12.126
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr
 [109.212.12.126])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5D5374000A;
 Wed, 20 Feb 2019 11:26:12 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/7] clk: at91: add sam9x60 pmc clock support
Date: Wed, 20 Feb 2019 12:25:58 +0100
Message-Id: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032616_027657_A6FAA032 
X-CRM114-Status: GOOD (  11.81  )
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

This series add support for the sam9x60 clocks handled by the PMC.

The first four patches are preparatory patches to handle register layout
and offset differences. Then, a driver for the new interface for PLLs is
added and the final patch is the driver for the sam9x60 PMC.

Alexandre Belloni (7):
  clk: at91: allow configuring peripheral PCR layout
  clk: at91: allow configuring generated PCR layout
  clk: at91: usb: Add sam9x60 support
  clk: at91: master: Add sam9x60 support
  clk: at91: add sam9x60 PLL driver
  dt-bindings: clk: at91: add bindings for SAM9X60 pmc
  clk: at91: add sam9x60 pmc driver

 .../devicetree/bindings/clock/at91-clock.txt  |   3 +-
 drivers/clk/at91/Makefile                     |   2 +
 drivers/clk/at91/at91sam9x5.c                 |   9 +
 drivers/clk/at91/clk-generated.c              |  48 +--
 drivers/clk/at91/clk-master.c                 |   8 +-
 drivers/clk/at91/clk-peripheral.c             |  46 +--
 drivers/clk/at91/clk-sam9x60-pll.c            | 329 ++++++++++++++++++
 drivers/clk/at91/clk-usb.c                    |  33 +-
 drivers/clk/at91/dt-compat.c                  |  12 +-
 drivers/clk/at91/pmc.h                        |  23 ++
 drivers/clk/at91/sam9x60.c                    | 307 ++++++++++++++++
 drivers/clk/at91/sama5d2.c                    |  10 +
 drivers/clk/at91/sama5d4.c                    |   8 +
 include/linux/clk/at91_pmc.h                  |  12 +-
 14 files changed, 785 insertions(+), 65 deletions(-)
 create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c
 create mode 100644 drivers/clk/at91/sam9x60.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
