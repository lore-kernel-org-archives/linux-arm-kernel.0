From: rogerq@ti.com (Roger Quadros)
Date: Wed, 8 Jan 2014 11:45:37 +0530
Subject: [PATCH v4 0/5] USB Host support for OMAP5 uEVM (for 3.14)
Message-ID: <1389161742-10533-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit & Tony,

This patchset brings up USB Host ports and Ethernet port on
the OMAP5 uEVM board.

It depends on the TI Clock DT conversion patches [1] and is based
on 3.13-rc7

[1] - http://article.gmane.org/gmane.linux.ports.arm.kernel/289895

Changelog:

v4:
- Updated DT binding document for clock binding

v3:
- Rebased on top of 3.13-rc7

cheers,
-roger

Roger Quadros (5):
  mfd: omap-usb-host: Update DT clock binding information
  ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
  ARM: dts: omap4-panda: Provide USB PHY clock
  ARM: dts: omap5-uevm: Provide USB PHY clock
  ARM: OMAP2+: Remove legacy_init_ehci_clk()

 Documentation/devicetree/bindings/mfd/omap-usb-host.txt |  4 ++++
 arch/arm/boot/dts/omap4-panda-common.dtsi               |  8 ++------
 arch/arm/boot/dts/omap5-uevm.dts                        |  8 ++------
 arch/arm/boot/dts/omap5.dtsi                            |  2 ++
 arch/arm/mach-omap2/pdata-quirks.c                      | 16 ----------------
 5 files changed, 10 insertions(+), 28 deletions(-)

-- 
1.8.3.2
