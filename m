Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7D7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC282073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DetKpFJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC282073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CZc77kv9JdG8Pj+sgO5XdrhmohaMWfGY9lk0iUS/adw=; b=DetKpFJuFv9C1L
	+5Kyql+KUt25zuUiUveZQLjmKKAoCKW/Vrp00zTSB/pkp1//+mZdvnIFAyyY3/G5SYImJ7zbBc4BO
	A47IzyAQPGDq9NXUxTQDZwtvQWYz0aV9XndCClJhCILNQUMTZpKiH5Ja3ZzpwC3M5irmLh21pDznJ
	TKfAcXCtkI+b0VXqbhyGOp2vXYF+XOwZD3ulILJksonUZh9zt4D6c9rCI39gBZAtoKP6y6QS1c6By
	Q0vBJCftL1uG2QwGzIHVFVVMNPaeVnL2vV6y/qH5sX047oWcrh84uYL1/ZSV83BbDxGrmILPVWegn
	s0qoWEIHpdNOaXYzbi4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsDXu-0004hK-HN; Fri, 08 Feb 2019 21:18:50 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsDXr-0004gd-6u
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 21:18:49 +0000
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2FD73FF805;
 Fri,  8 Feb 2019 21:18:38 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 <arm@kernel.org>
Subject: [GIT PULL] ARM: mvebu: dt64 for v5.1 (#1)
Date: Fri, 08 Feb 2019 22:18:38 +0100
Message-ID: <87mun6568h.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_131847_403926_8B78A1FB 
X-CRM114-Status: GOOD (  12.08  )
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
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v5.1.

Gregory

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-5.1-1

for you to fetch changes up to bd3d25b0734284dcf603173d54232c538eb6e385:

  arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs (2019-02-08 21:58:59 +0100)

----------------------------------------------------------------
mvebu dt64 for 5.1 (part 1)

 - Interrupt support to Armada 7K/8K thermal nodes
 - Armada 37xx related patches allowing to enable suspend to RAM
   (USB2, USB3, PCIe, SATA, DSA)
 - uDPU board support (Armada-3720 based):single-port FTTdp
    distribution point unit
 - Fixes for EspressoBin Ethernet support when using U-Boot mainline
 - cleanup for partitions under flashes nodes

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: dts: marvell: Remove unnecessary #address-cells/#size-cells under flashes

Miquel Raynal (12):
      arm64: dts: marvell: add interrupt support to ap806 thermal node
      arm64: dts: marvell: add interrupt support to cp110 thermal node
      arm64: dts: marvell: armada-37xx: fix SATA node scope
      arm64: dts: marvell: armada-37xx: declare SATA clock
      arm64: dts: marvell: armada-37xx: fix USB2 memory region
      arm64: dts: marvell: armada-37xx: declare USB2 UTMI PHYs
      arm64: dts: marvell: armada-37xx: declare PCIe reset pin
      arm64: dts: marvell: armada-3720-espressobin: declare PCIe warm reset pin
      arm64: dts: marvell: armada-37xx: declare the COMPHY node
      arm64: dts: marvell: armada-3720-espressobin: declare PCIe PHY
      arm64: dts: marvell: armada-3720-espressobin: declare SATA PHY property
      arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs

Remi Pommarel (2):
      arm64: dts: armada-3720-espressobin: Configure RGMII and SMI pins
      arm64: dts: armada-3720-espressobin: Set mv88e6341 cpu port as RGMII-ID

Vladimir Vid (1):
      arm64: dts: marvell: Add device tree for uDPU board

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 .../boot/dts/marvell/armada-3720-espressobin.dts   |  12 ++
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts   | 162 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  80 +++++++++-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   4 -
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |   4 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  18 ++-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  15 +-
 8 files changed, 280 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
