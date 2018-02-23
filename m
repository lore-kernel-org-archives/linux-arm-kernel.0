From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Fri, 23 Feb 2018 14:40:52 +0100
Subject: [PATCH v2 0/7] R-Car M3-N DTS fixes
Message-ID: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   in this second iteration I have fixed two remarks from Geert received on
v1:
- Extend "du" address length to include third channel
- Move usb2_phy1 device node next to usb2_phy0

Two minor nits were not addressed:
- "placeholder" comment position not changed to maintain consistency with
  placeholders in M3-W. When they'll get changed, let's change all of them at
  the same time.
- The addresses block sizes (and multiple address range blocks) are still there
  (next time we can consider dropping the unit address from place-holder nodes
  and do not add any "reg" property at all, until DTC won't start complaining
  about this as well)

All patches but the newly introduced 7/7 now have Geert's Reviewed-by tag.

Simon: as per v1, this series is based on my M3-N enablement series, last
patch on Ether-AVB excluded.

Thanks
   j

v1 -> v2:
- Extend "du" address length to include third channel
- Move usb2_phy1 node next to usb2_phy0

Jacopo Mondi (7):
  arm64: dts: renesas: r8a77965: Add "reg" properties
  arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
  arm64: dts: renesas: r8a77965: Remove stale reg property
  arm64: dts: renesas: r8a77965: Add #phy-cells property
  arm64: dts: renesas: r8a77965: Add #pwm-cells property
  arm64: dts: renesas: r8a77965: Add #interrupt-cells property
  arm64: dts: renesas: r8a77965: Move usb2_phy1 up

 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 89 +++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 5 deletions(-)

--
2.7.4
