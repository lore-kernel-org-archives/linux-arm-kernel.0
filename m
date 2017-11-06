From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Nov 2017 10:26:23 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.15, step 2
Message-ID: <20171106092623.tqvmvqhpopyu2mri@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are a few commits that would be great to get in 4.15, given how
long they've been hanging around.

The first and most important one is the reintroduction of the EMAC DT
changes after they've been reverted at the last minute in 4.13.

They've been in linux-next since wednesday, so they had a decent
amount of coverage already.

There's a arm64 patch that crept in because the H5 and H3 share a
common DTSI that is located in arch/arm, and merging that patch
through the arm64 PR, especially given the pull requests that have
already been sent, would just have generated too many conflicts.

This will be our last arm pull request for 4.15.

Thanks!
Maxime

The following changes since commit 1357bdb21f2af1e62b8858488a7bccd0fea63e69:

  ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra (2017-10-20 09:51:35 +0200)

are available in the Git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.15-2

for you to fetch changes up to f2f221c7810b824e15b57fe3d6c30b354299120f:

  ARM: dts: sun8i: a711: Enable USB OTG (2017-11-02 09:09:32 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.15, take 2

Two long awaited changes:
  - Reintroduction of the new EMAC DT bindings that got reverted at the
    last minute in 4.13
  - Introduction of the AXP803/813 PMIC support

----------------------------------------------------------------
Chen-Yu Tsai (7):
      ARM: dts: sunxi: Add dtsi for AXP81x PMIC
      ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818 regulator nodes
      ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes
      ARM: dts: sun8i: a83t: allwinner-h8homlet-v2: Add AXP818 regulator nodes
      ARM: dts: sun8i: a83t: Move mmc1 pinctrl setting to dtsi file
      ARM: dts: sun8i: a83t: cubietruck-plus: Enable AP6330 WiFi on mmc1
      ARM: dts: sun8i: a83t: bananapi-m3: Enable AP6212 WiFi on mmc1

Corentin Labbe (6):
      dt-bindings: net: Restore sun8i dwmac binding
      dt-bindings: net: dwmac-sun8i: update documentation about integrated PHY
      arm: dts: sunxi: h3/h5: Restore EMAC changes
      ARM: dts: sunxi: h3/h5: represent the mdio switch used by sun8i-h3-emac
      ARM: dts: sunxi: Restore EMAC changes (boards)
      arm64: dts: allwinner: H5: Restore EMAC changes

Maxime Ripard (2):
      ARM: dts: sun8i: a711: Add regulator support
      ARM: dts: sun8i: a711: Enable USB OTG

 .../devicetree/bindings/net/dwmac-sun8i.txt        | 207 +++++++++++++++++++++
 arch/arm/boot/dts/axp81x.dtsi                      | 139 ++++++++++++++
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 147 +++++++++++++--
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       | 169 ++++++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 187 +++++++++++++++++--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          | 174 +++++++++++++++--
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   2 +
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |   9 +
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  19 ++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |  29 +++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |   7 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |   5 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  22 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts     |  16 ++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  49 +++++
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |  17 ++
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  17 ++
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |  17 ++
 21 files changed, 1210 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt
 create mode 100644 arch/arm/boot/dts/axp81x.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171106/ae1efa44/attachment.sig>
