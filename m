From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 16:44:33 -0500
Subject: [PATCHv2 00/10] OMAP Mailbox DT node/hwmod cleanup
Message-ID: <1405115083-52977-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

This is a refresh of the OMAP Mailbox DT node/hwmod cleanup series [1],
addressing the review comments [2] from Pavel Machek about the Mailbox IP
design parameters. The changes are limited to only the DTS patches, and
mainly bring back the DT properties that were dropped in the previous
series. The hwmod patches in the series are identical to v1 (I added the
Acked-by responses from Paul Walmsley on 2 patches). I will refresh the
OMAP Mailbox framework adoption and DT conversion series [3] as well,
which builds on top of this cleanup series.

Changes in v2:
- Add a new patch that adds the new DT properties: ti,mbox-num-users and
  ti,mbox-num-fifos to existing DT nodes as of 3.16-rc2
- Updated the other DTS patches from v1 to include the new DT properties
- Updated the compatible properties on AM33xx and DRA7 to use the same
  compatible string as OMAP4.

The following shows the boot logs on various OMAP platforms with just
these patches on top of 3.16-rc2:
  OMAP3 (BeagleXM)          : http://slexy.org/view/s21MEzZ4bU
  OMAP4 (PandaBoard)        : http://slexy.org/view/s2S5sxIjYw
  OMAP5 (OMAP5 uEVM)        : http://slexy.org/view/s21siI3Vi2
  DRA7  (DRA7 EVM)          : http://slexy.org/view/s21RVgqBeT
  AM33xx (BeagleBone Black) : http://slexy.org/view/s20fcQqcOd
  AM43xx (AM437x GP EVM)    : http://slexy.org/view/s2k3GzeZK1

[1] http://marc.info/?l=linux-omap&m=140365833121612&w=2
[2] https://patchwork.kernel.org/patch/4415881/
[3] http://marc.info/?l=linux-omap&m=140366093024233&w=2

Suman Anna (10):
  ARM: dts: OMAP2+: Add mailbox fifo and user information
  ARM: dts: OMAP4: Add mailbox node
  ARM: dts: AM33xx: Add mailbox node
  ARM: dts: AM4372: Correct mailbox node data
  ARM: dts: DRA7: Add mailbox nodes
  ARM: DRA7: hwmod_data: Add mailbox hwmod data
  ARM: OMAP2+: Avoid mailbox legacy device creation for DT-boot
  ARM: OMAP2: hwmod_data: Remove legacy mailbox data and addrs
  ARM: OMAP4: hwmod_data: Remove legacy mailbox addrs
  ARM: AM33xx: hwmod_data: Remove legacy mailbox addrs

 arch/arm/boot/dts/am33xx.dtsi                      |   9 +
 arch/arm/boot/dts/am4372.dtsi                      |   3 -
 arch/arm/boot/dts/dra7.dtsi                        | 117 ++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |   2 +
 arch/arm/boot/dts/omap2430.dtsi                    |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   2 +
 arch/arm/boot/dts/omap4.dtsi                       |   9 +
 arch/arm/boot/dts/omap5.dtsi                       |   2 +
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |   9 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  10 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  10 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 305 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   1 -
 16 files changed, 449 insertions(+), 61 deletions(-)

-- 
2.0.0
