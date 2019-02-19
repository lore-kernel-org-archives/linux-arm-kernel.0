Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D15C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:36:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358CC21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cy3Lp90P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aPYEDZ9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358CC21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=om/YAd89uL3AG+ljBgzClOMQEIlP8pkHEIRJh0i6y7k=; b=cy3Lp90PMKODUe
	EzkW+YNG9BHCN41+JSIDHeck+RYvL57qq/yNZ3o3C2hfnMADWjYvyxDibi/njTvyXKiIVEpt8a4bh
	cQ7Z0hnjfpwsIXzR3oGWFm0bErKaxaSoth83e+dgMx10Le7OoUt841xKLZjl2R6IhKebzUSYE9OIu
	G9IbgHcxRyfZTj5GUETbRl3AC8k82kwZEVIFwl3mpCbnN/9wOMFpK2i6lgfymR79jp5GM1oBrq7Ua
	aNoH4s0iRuOmKCxNywnlfiuIKrh6umI14OgGYTTurM7BsjPKNce3aKDxy/EsfJQviVJDd6r4jH7Mi
	PPwZH9DacuR4S5ydvC0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw7RF-0000pe-Cz; Tue, 19 Feb 2019 15:36:05 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw7Qz-0000Z0-Gc
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:35:54 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JFZSCW043704;
 Tue, 19 Feb 2019 09:35:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550590528;
 bh=4PrH0TQwu7J5KUJpX8zk5kAk/zk0aTFzWqhhHD8gES8=;
 h=From:Subject:To:CC:Date;
 b=aPYEDZ9KP4XWZBxxAHn4xApWbS+gzQaTXr7n2yXH7LYeUgX9GePLsRPy8FwW+9LMl
 REq4IRpSNNtkSlz0C1thmiba+KXp5WBRPJjT0giOpmDXw5LoQDDEK9HfqM5a49psEY
 Rp3B/QClXplsglca/Ein7f6Fydesd2JEG1HHMBgU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JFZSAC030494
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Feb 2019 09:35:28 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 09:35:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 09:35:28 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JFZPhi020806;
 Tue, 19 Feb 2019 09:35:26 -0600
From: Sekhar Nori <nsekhar@ti.com>
Subject: [GIT PULL] DaVinci SoC updates for v5.1 (part 3)
To: ARM-SoC Maintainers <arm@kernel.org>
Message-ID: <26892a0a-c6c4-6409-44cf-1f407ac21482@ti.com>
Date: Tue, 19 Feb 2019 21:05:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_073550_073565_1E3DF0C5 
X-CRM114-Status: GOOD (  19.46  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof,

This is a late request to pull some further SoC updates for DaVinci.
The patches have been in the works for a while, but we received the
final maintainer acks only yesterday.

I hope we can merge this for v5.1. We have further clean-ups for
mach-davinci planned, and it will be good to get this out of the
way.

I have run randconfig builds with a previous version of this series.
I am running afresh with this branch too. The branch merges without
conflicts into latest linux-next/master.

Thanks,
Sekhar

The following changes since commit 23fa70e40a42e8dfeac654b8cc0e5b463e54af25:

  usb: ohci-da8xx: remove unused callbacks from platform data (2019-02-12 13:48:59 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v5.1/soc-part3

for you to fetch changes up to 49b654fd43b29e8decaa38035eed9ca8f221e48a:

  ARM: davinci: remove intc related fields from davinci_soc_info (2019-02-19 20:04:07 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v5.1 (part 3)
-------------------------------------
This pull request gets rid of mach-davinci private interrupt controller
implmentations (aintc and cp_initc) and moves them to drivers/irqchip.

mach/irqs.h usage outside of mach-davinci has been rid of.

The driver changes (input and irqchip) have been acked by respective
maintainers.

----------------------------------------------------------------
Bartosz Golaszewski (37):
      input: davinci_keyscan: remove unnecessary includes
      ARM: davinci: remove intc_host_map from davinci_soc_info struct
      ARM: davinci: aintc: use irq domain
      ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
      ARM: davinci: remove davinci_intc_type
      ARM: davinci: pull davinci_intc_base into the respective intc drivers
      ARM: davinci: wrap HW interrupt numbers with a macro
      ARM: davinci: select SPARSE_IRQ
      ARM: davinci: make irqs.h a local header
      ARM: davinci: aintc: drop GPL license boilerplate
      ARM: davinci: aintc: wrap davinci_irq_init() with a helper
      ARM: davinci: aintc: use a common prefix for symbols in the driver
      ARM: davinci: aintc: drop the 00 prefix from register offsets
      ARM: davinci: aintc: use writel_relaxed()
      irqchip: davinci-aintc: add a new config structure
      ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
      ARM: davinci: aintc: use the new config structure
      ARM: davinci: aintc: unify error handling
      ARM: davinci: aintc: request memory region before remapping it
      ARM: davinci: aintc: remove the timer-specific irq_set_handler()
      ARM: davinci: aintc: remove unnecessary includes
      irqchip: davinci-aintc: move the driver to drivers/irqchip
      ARM: davinci: cp-intc: remove cp_intc.h
      ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
      irqchip: davinci-cp-intc: add a new config structure
      ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
      ARM: davinci: cp-intc: use a common prefix for all symbols
      ARM: davinci: cp-intc: convert all hex numbers to lowercase
      ARM: davinci: cp-intc: use the new-style config structure
      ARM: davinci: cp-intc: request the memory region before remapping it
      ARM: davinci: cp-intc: improve coding style
      ARM: davinci: cp-intc: unify error handling
      ARM: davinci: cp-intc: use readl/writel_relaxed()
      ARM: davinci: cp-intc: drop GPL license boilerplate
      ARM: davinci: cp-intc: remove redundant comments
      irqchip: davinci-cp-intc: move the driver to drivers/irqchip
      ARM: davinci: remove intc related fields from davinci_soc_info

 arch/arm/Kconfig                                 |   2 +
 arch/arm/mach-davinci/Kconfig                    |  19 +-
 arch/arm/mach-davinci/Makefile                   |   3 -
 arch/arm/mach-davinci/asp.h                      |   8 +-
 arch/arm/mach-davinci/board-da830-evm.c          |   5 +-
 arch/arm/mach-davinci/board-da850-evm.c          |   5 +-
 arch/arm/mach-davinci/board-dm355-evm.c          |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c      |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c          |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c         |   8 +-
 arch/arm/mach-davinci/board-dm646x-evm.c         |   6 +-
 arch/arm/mach-davinci/board-mityomapl138.c       |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c        |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c      |   3 +-
 arch/arm/mach-davinci/board-sffsdr.c             |   2 +-
 arch/arm/mach-davinci/common.c                   |   3 -
 arch/arm/mach-davinci/cp_intc.c                  | 215 -------------------
 arch/arm/mach-davinci/cp_intc.h                  |  57 -----
 arch/arm/mach-davinci/da830.c                    | 128 ++---------
 arch/arm/mach-davinci/da850.c                    | 154 +++-----------
 arch/arm/mach-davinci/davinci.h                  |   4 +
 arch/arm/mach-davinci/devices-da8xx.c            | 147 ++++++-------
 arch/arm/mach-davinci/devices.c                  |  40 ++--
 arch/arm/mach-davinci/dm355.c                    |  78 ++++---
 arch/arm/mach-davinci/dm365.c                    | 102 +++++----
 arch/arm/mach-davinci/dm644x.c                   |  68 +++---
 arch/arm/mach-davinci/dm646x.c                   |  82 ++++---
 arch/arm/mach-davinci/include/mach/common.h      |  14 +-
 arch/arm/mach-davinci/include/mach/da8xx.h       |   2 +
 arch/arm/mach-davinci/include/mach/entry-macro.S |  39 ----
 arch/arm/mach-davinci/irq.c                      | 117 ----------
 arch/arm/mach-davinci/{include/mach => }/irqs.h  |   4 -
 arch/arm/mach-davinci/usb-da8xx.c                |   9 +-
 arch/arm/mach-davinci/usb.c                      |  15 +-
 drivers/input/keyboard/davinci_keyscan.c         |   4 -
 drivers/irqchip/Kconfig                          |  10 +
 drivers/irqchip/Makefile                         |   2 +
 drivers/irqchip/irq-davinci-aintc.c              | 163 ++++++++++++++
 drivers/irqchip/irq-davinci-cp-intc.c            | 260 +++++++++++++++++++++++
 include/linux/irqchip/irq-davinci-aintc.h        |  27 +++
 include/linux/irqchip/irq-davinci-cp-intc.h      |  25 +++
 41 files changed, 880 insertions(+), 961 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cp_intc.c
 delete mode 100644 arch/arm/mach-davinci/cp_intc.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-davinci/irq.c
 rename arch/arm/mach-davinci/{include/mach => }/irqs.h (98%)
 create mode 100644 drivers/irqchip/irq-davinci-aintc.c
 create mode 100644 drivers/irqchip/irq-davinci-cp-intc.c
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
