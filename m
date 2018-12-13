Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F50C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:26:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C5420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0csiCVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C5420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+L5dqhUj1wIM6nUNPzVa0Z5kKH5epfH7SdGHzzIUcms=; b=B0csiCVVkhzIw6
	jGThI9ht7GzRe9eczzyPkjpNjUo3jpBmMzaWERRiaBFM2FUi5nI0ABXVQ0XLEev13LraJxQccOOTj
	MMxvrFSs3LSfagLufxeDHQc7MmbxX45VBsRVjceQLphU+D25Jwa6YNaIwIvObh1uk7YgAR35XvODP
	JckseIS6XAB2JbIwyiu/jh9ffWhc1R0NLEG1Ep+2KrlrCAUc86o4zyAUv14Uv8+6CVOA1p8afXCAu
	5GEaZfS5xotchCtT7qC9BS9UNCCsEqtlyKHQ4wVSylvCFAVj+gV2EUW+jM6csk9saMJBv/1i4twjQ
	iV5zyPsKa93hIcEiGwNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXXYW-0004E4-LC; Thu, 13 Dec 2018 20:26:00 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXXYT-0004Ce-7s
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 20:25:59 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id BD9398081;
 Thu, 13 Dec 2018 20:25:48 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] ti-sysc dts changes for omaps for v4.21
Date: Thu, 13 Dec 2018 12:25:37 -0800
Message-Id: <pull-1544723769-214686@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_122557_322798_C6CF7A07 
X-CRM114-Status: GOOD (  15.58  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/dt-ti-sysc-signed

for you to fetch changes up to c7a851b7050e2b7b8ed6e96c1437e19ca5720851:

  ARM: dts: Cosmetic fix for omap5 USB node names (2018-12-13 09:08:43 -0800)

----------------------------------------------------------------
Add interconnect target module dts data for omaps for v4.21

This big set of changes adds SoC specific l4 interconnect target module
device tree data for am335x, am437x, omap5 and dra7 SoCs. We also move
existing devices to the right location in the l4 interconnect hierarcy.
This is similar to what we've already done for omap4 l4 interconnects
earlier, and follows what is documented in the ti-sysc driver dts binding
in Documentation/devicetree/bindings/bus/ti-sysc.txt.

These changes will essentially replace the struct ti_sysc and clock
entries in the arch/arm/mach-omap2/omap_hwmod_*_data.c files. Then a few
merge windows later, we can start dropping the built-in platform data
from the omap_hwmod_*_data.c files in favor of the device tree data only.
For now, we verify the device tree data module data against the built-in
data and warn about changes to prevent regressions.

With the device tree data, we are also probing devices with the ti-sysc
interconnect target module instead of omap_device. This fixes up the
handling for multiple device instances in a single interconnect target
module that has caused trouble earlier. A custom wrapper driver has been
needed earlier for such cases.

And as the device tree data is organized by the l4 interconnect instances,
we will be able to use genpd later on. This is because each interconnect
instance is also often also a single power domain.

This series of changes has been brewing for several months now. I did not
want to send a pull request earlier as people were still seeing device
specific issues until recently though. However, it turned out that all the
issues were quite trivial to fix. I had missed adding device tree ranges
for the l3 data port used on some devices, and I had missed converting the
device addresses for a few devices. And some devices like needed fixes for
deferred probe handling such as the EHCI PHY for built-in case on omap5.

Anyways, in case of trouble, we can easily just revert changes for a
single device if needed.

----------------------------------------------------------------
Tero Kristo (4):
      ARM: dts: am33xx: convert to use new clkctrl layout
      ARM: dts: am43xx: convert to use new clkctrl layout
      ARM: dts: dra7: convert to use new clkctrl layout
      ARM: dts: dra7: Move the ti,no-idle quirk on proper gmac node

Tony Lindgren (21):
      Merge commit 'd6e7bbc148f9fbec8a0117b0d0f420c9710e6d81' into omap-for-v4.21/dt-ti-sysc
      Merge commit 'ce32d59ee2cd036f6e8a6ed17a06a0b0bec5c67c' into omap-for-v4.21/dt-ti-sysc
      Merge remote-tracking branch 'gpio/ib-omap' into omap-for-v4.21/dt-ti-sysc
      Merge tag 'omap-for-v4.20/ti-sysc-take2-signed' into omap-for-v4.21/dt-ti-sysc
      ARM: dts: am437x: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: am437x: Move l4 child devices to probe them with ti-sysc
      ARM: dts: am335x: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc
      ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: dra7: Move l4 child devices to probe them with ti-sysc
      Merge tag 'v4.20-rc1' into omap-for-v4.21/dt-ti-sysc
      ARM: dts: Use dra7 mcasp compatible for mcasp instances
      ARM: dts: omap5: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: Revert am335x mcasp ti-sysc changes
      ARM: dts: Add missing ranges for am437x mcasp l3 ports
      ARM: dts: Add am335x mcasp with l3 data port ranges
      ARM: dts: Fix hsi gdd range for omap4
      ARM: dts: Fix ranges for am335x epwmss
      ARM: dts: Add missing ranges for dra7 mcasp l3 ports
      ARM: dts: Fix wrong address for omap5 sata phy
      ARM: dts: Cosmetic fix for omap5 USB node names

 arch/arm/boot/dts/am335x-bone-common.dtsi       |    2 +-
 arch/arm/boot/dts/am335x-boneblue.dts           |    2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts            |    2 +-
 arch/arm/boot/dts/am335x-evm.dts                |    4 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |    4 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts     |    2 +-
 arch/arm/boot/dts/am335x-shc.dts                |    4 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi            |  110 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                | 2132 +++++++++++
 arch/arm/boot/dts/am33xx.dtsi                   |  623 +--
 arch/arm/boot/dts/am4372.dtsi                   |  876 +----
 arch/arm/boot/dts/am437x-l4.dtsi                | 2505 ++++++++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi            |   74 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |    2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi          |    4 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  | 4600 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                     | 1434 +------
 arch/arm/boot/dts/dra72-evm-common.dtsi         |    4 +-
 arch/arm/boot/dts/dra72x.dtsi                   |    4 +-
 arch/arm/boot/dts/dra74x.dtsi                   |    6 +-
 arch/arm/boot/dts/dra76x.dtsi                   |    2 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi            |  159 +-
 arch/arm/boot/dts/omap4-l4.dtsi                 |    4 +-
 arch/arm/boot/dts/omap5-l4.dtsi                 | 2462 ++++++++++++
 arch/arm/boot/dts/omap5.dtsi                    |  688 +---
 25 files changed, 12029 insertions(+), 3680 deletions(-)
 create mode 100644 arch/arm/boot/dts/am33xx-l4.dtsi
 create mode 100644 arch/arm/boot/dts/am437x-l4.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-l4.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-l4.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
