Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6864C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:23:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7C3205F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zva1at9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7C3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gnvw5m23fA6LceTRIz1SD6gEdUATxzbbgXXZPm9k6Po=; b=Zva1at9Sb2X8Fa
	NRaYGJF7Dg+5CLrxtjDhBWZNhJJE4fL0rVH8M2V4I1EywP4nBcj1uHpPUh30+L51fmrl47J/eHpcu
	i4KHrw+MF4B+ZkDGVlwz1LoFX2JtdHQ0FQNX+S7nap+nfIG9xPlPUO8inZ9nDaABQ94boR9fkNJCh
	NjjyGJaa0AOgMi5B9aWHAte1DELR2mG8V0wVxRuR50TByZA6SQ9t6tZO8qK78mIToj5Jw0yT5fOIV
	qKpDogoaGmtaV7DxO/aGB3iUoFGS4Tqf2MAhZEXLCZ95HOVUz5MS89c8K3M4rLpXOAb/npw5i6XWE
	Ci3C5ggXG3IshpxvSggw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJEY-00051a-1K; Fri, 22 Feb 2019 22:23:54 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJEV-00051F-BJ
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:23:52 +0000
Received: by mail-qt1-f194.google.com with SMTP id z39so4396645qtz.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ZGifS54bNf5zXXkOg4B/RrcUFeN3oxMfoG5A2oZa5kA=;
 b=pROlyn291h7yfANA8MVWJb0O1oKSs8VrbMx7SPy8tWuZOrmuiyeDOW+Pdy4aZ+xs4M
 CbQ10uR86MfzAbc5smI7amE8aTUpmCU0XqA1pyH6e4Qtg6Cbpv3bHnjc9sj1zK/S5cVS
 1KAHaGlsxuilpaW3hB6s+OHIvW0daXd5f3Tc+MDv3DPXfWhKUUNisRxQUciRdGx2Nh9o
 4lKE5DpMam1TrwO/ac1uEFASeVbREsZU+KGlmNikLid+7c+vjXCwvTRtOlHWc0f6jhdX
 UnXxyqulfVQv5Qier8Op4YbEVtOxtrTu3sLJ0hOCuXm6pmdBq7q/QN90k3Yqlc5KTWzP
 qpOg==
X-Gm-Message-State: AHQUAuZ3a9oq+1RI3ydbjy8SZmvI1P1ExFcLuzd8MYoHynjpEUg2uQ39
 16KomOZyIkAE/SvsgiroCbUDRQCssVSeHFusGgs=
X-Google-Smtp-Source: AHgI3Ibwppi4MVqZhb6qRVVg+LL6tEM+cl0hJIclw6j8T/1qTDncK5AY9WA5lNXQb3SSJdeyS4pg0Y+1ZeLK0KeU8TQ=
X-Received: by 2002:a0c:b05a:: with SMTP id l26mr4929954qvc.40.1550874230273; 
 Fri, 22 Feb 2019 14:23:50 -0800 (PST)
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 23:23:33 +0100
Message-ID: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 5.0
To: Linus Torvalds <torvalds@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_142351_389518_B01ED70C 
X-CRM114-Status: GOOD (  11.06  )
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
Cc: soc@kernel.org, arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 2f8b1ce19ebdaffa0f3f11d178b387b60e29c0fc:

  Merge tag 'mvebu-fixes-5.0-2' of git://git.infradead.org/linux-mvebu
into arm/fixes (2019-02-22 14:58:41 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 5.0

Only a handful of device tree fixes, all simple enough:

NVIDIA Tegra:
 - Fix a regression for booting on chromebooks

TI OMAP:
 - Two fixes PHY mode on am335x reference boards

Marvell mvebu:
 - A regression fix for Armada XP NAND flash controllers
 - An incorrect reset signal on the clearfog board

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'omap-for-v5.0/fixes-rc7-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'mvebu-fixes-5.0-2' of
git://git.infradead.org/linux-mvebu into arm/fixes

Baruch Siach (1):
      arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
      ARM: dts: am335x-evm: Fix PHY mode for ethernet

Thierry Reding (1):
      ARM: tegra: Restore DT ABI on Tegra124 Chromebooks

Thomas Petazzoni (1):
      ARM: dts: armada-xp: fix Armada XP boards NAND description

Tony Lindgren (1):
      Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2

 arch/arm/boot/dts/am335x-evm.dts                           |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                         |  4 ++--
 arch/arm/boot/dts/armada-xp-db.dts                         | 46
+++++++++++++++++++-----------------
 arch/arm/boot/dts/armada-xp-gp.dts                         | 13 ++++++----
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts            | 85
++++++++++++++++++++++++++++++++++--------------------------------
 arch/arm/boot/dts/tegra124-nyan.dtsi                       | 17 +++++++++++++-
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts |  2 +-
 7 files changed, 96 insertions(+), 73 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
