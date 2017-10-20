From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:30 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.15
Message-ID: <cover.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.15.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.15,
which I you have already pulled.


The following changes since commit 2affee619d48d101831e83e74cadeb7c5200d9cb:

  arm64: dts: renesas: r8a7796: add USB3.0 peripheral device node (2017-09-25 09:09:51 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.15

for you to fetch changes up to e9ce35386b215d3f5d0fbab3cc24b69b8d57d7e6:

  arm64: dts: renesas: salvator-common: add dr_mode property for USB2.0 channel 0 (2017-10-20 12:05:36 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.15

* r8a7795 (H3) and r8a7796 (M3-W) SoCs
  - Use R-Car Gen 3 fallback compat string for GPIO

    Simon Horman says "Use newly added R-Car GPIO Gen 1, 2 and 3 fallback
    compat strings in peace of now deprecated non-generation specific R-Car
    GPIO fallback compat string in the DT of Renesas ARM and arm64 based
    SoCs.

* r8a7795 (H3) and r8a7796 (M3-W) Salvator boards
  - Add dr_mode property for USB2.0 channel 0

    Shimoda-san says "Since Salvator-X[S] have a USB2.0 dual-role channel
    (CN9), this patch
    adds dr_mode property for USB2.0 channel 0 (EHCI/OHCI and HS-USB)
    as "otg".

    Using dual-role channel (or not) is related to the type of USB receptor
    on board specification. So, I added the property into the
    salvator-common.dtsi."

  - Add pfc node for USB3.0 channel 0

    Shimoda-san says "Since a R-Car Gen3 bootloader enables the PFC of
    USB3.0 channel 0, the USB3.0 host controller works without this setting
    on the kernel.  But, this setting should have salvator-common.dtsi. So,
    this patch adds the pfc node for USB3.0 channel 0."

* r8a7795 (H3) and r8a7796 (M3-W) Salvator and ULCB boards
  - Correct audio_clkout

    Morimoto-san says ""audio_clkout" is dummy clock of <&rcar_sound 0> to
    avoid clock loop which invites probe conflct. Thus <&rcar_sound 0> and
    "audio_clkout" should be same value."

* r8a7795 (H3) and r8a7796 (M3-W) Salvator and ULCB, and
  r8a77995 (D3) Draak boards
  - Drop "avb_phy_int" from avb_pins

    Shimoda-san says "Since the Ethernet AVB driver doesn't support
    AVB_PHY_INT handling and it will be handled by a phy driver as a gpio
    pin, this patch removes the "avb_phy_int" from the avb_pins node."

* r8a77995 (D3) Draak board
  - Enable PWM channels

    Shimoda-san says "Each channel connects to LTC2644 for brightness
    control."

* r8a77970 (V3M) Eagle and ULCB Kingfisher boards
  - Add initial device tree support

----------------------------------------------------------------
Geert Uytterhoeven (3):
      arm64: dts: r8a7796: Add INTC-EX device node
      arm64: dts: r8a77970: Add INTC-EX device node
      arm64: dts: r8a77995: Add INTC-EX device node

Kuninori Morimoto (2):
      arm64: renesas: salvator-common: fixup audio_clkout
      arm64: renesas: ulcb: fixup audio_clkout

Sergei Shtylyov (2):
      arm64: dts: renesas: initial Eagle board device tree
      arm64: dts: renesas: eagle: add EtherAVB support

Simon Horman (2):
      arm64: dts: r8a7795: Use R-Car GPIO Gen3 fallback compat string
      arm64: dts: r8a7796: Use R-Car GPIO Gen3 fallback compat string

Vladimir Barinov (15):
      arm64: dts: ulcb-kf: initial device tree
      arm64: dts: m3ulcb-kf: initial device tree
      arm64: dts: h3ulcb-kf: ES1.x SoC initial device tree
      arm64: dts: h3ulcb-kf: ES2.0+ SoC initial device tree
      arm64: dts: ulcb-kf: enable SCIF1
      arm64: dts: ulcb-kf: enable CAN0/1
      arm64: dts: ulcb-kf: enable HSUSB
      arm64: dts: ulcb-kf: enable USB2.0 Host channel 0
      arm64: dts: ulcb-kf: enable PCIE0/1
      arm64: dts: ulcb-kf: enable USB3.0 Host
      arm64: dts: ulcb-kf: enable TCA9539 on I2C2
      arm64: dts: ulcb-kf: enable TCA9539 on I2C4
      arm64: dts: ulcb-kf: enable PCA9548 on I2C2
      arm64: dts: ulcb-kf: enable PCA9548 on I2C4
      arm64: dts: ulcb-kf: hog USB3 hub control gpios

Yoshihiro Shimoda (7):
      arm64: dts: renesas: salvator-common: drop "avb_phy_int" from avb_pins
      arm64: dts: renesas: ulcb: drop "avb_phy_int" from avb_pins
      arm64: dts: renesas: r8a77995: draak: drop "avb_phy_int" from avb_pins
      arm64: dts: renesas: salvator-common: add pfc node for USB3.0 channel 0
      arm64: dts: renesas: r8a77995: add PWM device nodes
      arm64: dts: renesas: r8a77995: draak: enable PWM channel 0 and 1
      arm64: dts: renesas: salvator-common: add dr_mode property for USB2.0 channel 0

 arch/arm64/boot/dts/renesas/Makefile               |   4 +
 .../boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts     |  19 +++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dts  |  19 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  16 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dts  |  19 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  32 +++-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  57 +++++++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |  16 ++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |  27 +++-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  56 +++++++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  16 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           | 169 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   5 +-
 13 files changed, 431 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
 create mode 100644 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
