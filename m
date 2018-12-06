Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B3D20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l/TsTVn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B3D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UpZjtW889hJImQBgEYHdBOOmrpWymu9Sd3QX40rZXwU=; b=l/TsTVn0IRVgrV
	2F79Xnfm36M0qtUJTRQlZdp6D07aWq+eJA/Q0dzq1JppxwS7k8DjcbqqcAA6GvwJAel6x6nzTWsWj
	xGP3vpugD8EPfZynXtOARULxahmS/VsrOUNDFN7hGLk2JwWNjBou9c1kzQcH3k8xxTjiAP5ZzV/LI
	sSgu6CLiNG4UXtm3dsUw9Mgir3Oga4enFx/4x/ouF6EmrZfNXMJjyFn8CF+2/gQmKtqotkMB2G9gN
	7hYHTjmLXQDmX2utY+W6+T+/qCibt5yWey4aNvUYvaW08aI7tMcrxI+4rUc9XGC5EvvHb+GapGFPD
	D2eRvo2WwN56rPYy1ZmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxGI-0001Sq-RN; Thu, 06 Dec 2018 17:16:30 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxG4-0001HR-FS
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:16:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 89B7320752; Thu,  6 Dec 2018 18:16:02 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5FC71206FF;
 Thu,  6 Dec 2018 18:16:02 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
 Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add CPU clock support for Armada 7K/8K
Date: Thu,  6 Dec 2018 18:15:11 +0100
Message-Id: <20181206171516.15891-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_091616_655440_308A9642 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This is the second version of a series allowing to manage the cpu
clock for Armada 7K/8K. For these SoCs, the CPUs share the same clock
by cluster, so actually the clock management is done at cluster level.

As for the other Armada 7K/8K clocks it is possible to have multiple
AP so here again we need to have unique name: the purpose of the second
patch is to share a common code which will be used in 3 drivers.

The last 2 patch enable the driver at dt and platform level and will
be applied through the mvebu subsystem.

Changelog v1->v2:
 - Header cleanup
 - Use unsigned int instead of it for cluster member of the ap_cpu_clk struct
 - Use clk_hw instead of clk
 - Use regmap_read_poll_timeout
 - Use for_each_of_cpu_node
 - Remove unnecessary WARN_ON()
 - Remove headers from armada_ap_cp_helper.h
 - Few other minor cleanup

Gregory CLEMENT (5):
  clk: mvebu: add helper file for Armada AP and CP clocks
  clk: mvebu: add CPU clock driver for Armada 7K/8K
  clk: mvebu: ap806: Fix clock name for the cluster
  arm64: marvell: enable the  Armada 7K/8K CPU clk driver
  arm64: dts: marvell: Add cpu clock node on Armada 7K/8K

 arch/arm64/Kconfig.platforms                  |   1 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |   4 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   6 +
 drivers/clk/mvebu/Kconfig                     |   8 +
 drivers/clk/mvebu/Makefile                    |   2 +
 drivers/clk/mvebu/ap-cpu-clk.c                | 259 ++++++++++++++++++
 drivers/clk/mvebu/ap806-system-controller.c   |  24 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c       |  30 ++
 drivers/clk/mvebu/armada_ap_cp_helper.h       |  11 +
 drivers/clk/mvebu/cp110-system-controller.c   |  32 +--
 10 files changed, 335 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
