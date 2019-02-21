Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08B32083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P+ODzpG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08B32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CXhNVuLkhdck4Ru3O84j81jP+fT4EaI/VpH/xbuJmf0=; b=P+ODzpG8hu2dIE
	BkUzcxnAhbW/2oZlpff/pqNaU8fonoynJQ2fs7zj+oMmTA66qhd3DC0Y7NxSdtUljy7pQOnoXoLlP
	se/M33dyeahltpi618OyRlE3RrtFhBnY6GY34SAbHeFuBZPsQ52hNK1VBUrDkJ+DEuiWJLEqjfy/4
	U21uU6Wy5HKUsTV2IqtsOW5K0A6XWzmIdDxO7QvdzEBfAouBt7UnJtkNdJJT8GWObZAnmRtcfrERk
	yD/XvXkX9FuEynDiCQJUN4QwLONTSrxj4ShtcT82lhuwNkiNxXKXZFvuAXMNeJnruOcTTOq/7N/yR
	n4CWWoS6Lz6MhSsdAuAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwrST-00022M-1R; Thu, 21 Feb 2019 16:44:25 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwrSP-000222-AQ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:44:22 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id C061580C8;
 Thu, 21 Feb 2019 16:44:31 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] two am335x ethernet phy mode fixes for v5.0-rc cycle
Date: Thu, 21 Feb 2019 08:44:18 -0800
Message-Id: <pull-1550767433-845690@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_084421_397558_A0D698D2 
X-CRM114-Status: UNSURE (   7.89  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b:

  ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug (2019-02-07 07:48:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc7-signed

for you to fetch changes up to 0661465ec86e8ae28f09a04e51425c486d64dfb1:

  Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2 (2019-02-19 08:47:17 -0800)

----------------------------------------------------------------
Two am335x ethernet phy mode fixes for v5.0-rc cycle

Recent changes with commit cd28d1d6e52e: ("net: phy: at803x: Disable phy
delay for RGMII mode") broke Ethernet on am335x-evmsk, and turns out some
device driver fixes are needed.

Even without the driver fixes, am335x needs to run in rgmii-id mode instead
rgmii-txid mode. Things have been working based on luck as the broken driver
has been configuring rgmii-id mode. Let's fix that as that way things work
as they're supposed to work from hardware wiring point of view.

----------------------------------------------------------------
Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
      ARM: dts: am335x-evm: Fix PHY mode for ethernet

Tony Lindgren (1):
      Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2

 arch/arm/boot/dts/am335x-evm.dts   | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
