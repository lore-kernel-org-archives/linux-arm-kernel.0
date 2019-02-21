Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:45:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4722C2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZYRODB5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4722C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SciC3Csj+i0ld6tXnkPN3vdeT87e1+ZiFVfocJdPDy4=; b=ZYRODB5Vr5CR8y
	wWZkAbHg3Bld9hSSOp5csfxUP4eYDm49wlMb7TAGJFzNCzDzRm73OqK3VZelga/DBZgMoTH3r+m86
	dYN6ULLHjqfTtCiRzXm/IDNrqDl9CSXO1+AvrZfgJcSQV+cE3SkmbZwKU3rsHewZ1hNGMeklo6dL5
	mYm6qfAzMMQdOkfqR2YknogoyGQ7gkbqf86eTokCYPxrPkBAo/94AE/svgswXZQh+aXvbWW/xGxZ7
	IHSHofk01Pfb7HUujB2XnG/fTr07aNc0B5N+ubqfeOqd7ahILaCJOxfgoIchhSsJ9ek7+dwg5SRzC
	mLuBKa47HgkljPrZ9vXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwrTf-0003dV-JT; Thu, 21 Feb 2019 16:45:39 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwrTc-0003d8-9e
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:45:37 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id AE34B80C8;
 Thu, 21 Feb 2019 16:45:46 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] dts changes for cpsw phy driver for v5.1
Date: Thu, 21 Feb 2019 08:45:31 -0800
Message-Id: <pull-1550767488-25979@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_084536_374709_DC0867B7 
X-CRM114-Status: UNSURE (   7.68  )
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

The following changes since commit 947b7802597106dcbef2ddca23d386f9339ba334:

  ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-cpsw-phy

for you to fetch changes up to bae2bf97939aebd74dfd8f0b76b4902a19e63eef:

  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)

----------------------------------------------------------------
Device tree changes to make CPSW Ethernet use proper phy driver

We now have a proper PHY driver with drivers/phy/ti/phy-gmii-sel.c to
configure the CPSW PHY. These changes update all CPSW users to use the
new driver that already got merged during v5.0 merge window.

----------------------------------------------------------------
Grygorii Strashko (5):
      ARM: dts: dra7: switch to use phy-gmii-sel
      ARM: dts: dm814x: switch to use phy-gmii-sel
      ARM: dts: am4372: switch to use phy-gmii-sel
      ARM: dts: am335x: switch to use phy-gmii-sel
      dt-bindings: net: ti: deprecate cpsw-phy-sel bindings

 Documentation/devicetree/bindings/net/cpsw-phy-sel.txt |  2 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts             |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts             |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts             |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts                |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts                     |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi                 |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                       |  4 ----
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi      |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts         |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi              |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                       | 15 ++++++++-------
 arch/arm/boot/dts/am437x-l4.dtsi                       | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts                   |  5 +----
 arch/arm/boot/dts/dm814x.dtsi                          | 15 +++++++++------
 arch/arm/boot/dts/dra7-l4.dtsi                         | 15 ++++++++-------
 16 files changed, 36 insertions(+), 75 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
