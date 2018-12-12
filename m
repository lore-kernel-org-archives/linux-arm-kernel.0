Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63014C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:13:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329702084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pADQHe3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329702084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DHEyBgj9ODbb+/Soy9qhO0u+dyex6p2tGvDquDmiCS4=; b=pADQHe3lgBvi8x
	P3Gj0rSIqWoRdBo5QEoPc23grnuio6C5Oiw1qSMYXtHVk/y/cXGWK+7WoYCNB2Wh8co3/znI2Yt8t
	XI5T+taLCCFdNfBPWybHLZcOq0TVMTQEwxtrVYCCJUfS37CDl1VbgH5zPW5h6nKOQ7/ExAZQBfmXn
	nEyp3XvKcUGdfJ7j0sint3khMp/PtPnLmLGWQ8gZu8neofiEfdf3fmzIcT/yTulznIGwh9hUK9s/C
	99jqElY9TLVE2VR4YgZkEJKZZOonmzeXq0v8RUbewHT/sk49tcRarGTs9tMVxZBQIDfwjJOEnHXxV
	QtskaCwfZgzR2mWX0jXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX90n-0001eQ-GF; Wed, 12 Dec 2018 18:13:33 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX90k-0001ds-54
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:13:31 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id E34E3809F;
 Wed, 12 Dec 2018 18:13:21 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] omap1 changes for v4.21
Date: Wed, 12 Dec 2018 10:13:14 -0800
Message-Id: <pull-1544638322-89579@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_101330_239022_16869AAC 
X-CRM114-Status: UNSURE (   9.05  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/omap1-signed

for you to fetch changes up to 5a87809b89b64c0ccd82261de53c41f2fffb56da:

  Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1 (2018-12-11 08:14:58 -0800)

----------------------------------------------------------------
Changes for omap1 variants for v4.21 merge window

In this set of changes Aaro Koskinen revives Palm Tungsten E for the
MMC and USB making it usable again. And Janusz Krzysztofik follows up
on the clean-up of  ams-delta GPIO handling. The other changes are
clean-up for DEFINE_SHOW_ATTRIBUTE by Yangtao Li.

----------------------------------------------------------------
Aaro Koskinen (4):
      ARM: OMAP1/2: fix SoC name printing
      ARM: OMAP1: devices: configure omap1_spi100k only on OMAP7xx
      ARM: OMAP1: add MMC configuration for Palm Tungsten E
      ARM: OMAP1: fix USB configuration for device-only setups

Janusz Krzysztofik (5):
      ARM: OMAP1: ams-delta: make board header file local to mach-omap1
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
      ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
      ARM: OMAP1: ams-delta: Drop unused symbols from the board header
      ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file

Tony Lindgren (1):
      Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1

Yangtao Li (2):
      ARM: OMAP1: clock: Change to use DEFINE_SHOW_ATTRIBUTE macro
      ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro

 arch/arm/mach-omap1/Makefile                       |   2 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |   2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c              | 106 ++++++---------------
 .../{include/mach => }/board-ams-delta.h           |  24 +----
 arch/arm/mach-omap1/board-palmte.c                 |  29 ++++++
 arch/arm/mach-omap1/clock.c                        |  14 +--
 arch/arm/mach-omap1/devices.c                      |   3 +
 arch/arm/mach-omap1/id.c                           |   6 +-
 arch/arm/mach-omap1/include/mach/usb.h             |   2 +-
 arch/arm/mach-omap1/pm.c                           |  13 +--
 arch/arm/mach-omap2/id.c                           |   4 +-
 12 files changed, 76 insertions(+), 132 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (66%)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
