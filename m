From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  2 Nov 2014 12:24:33 +0100
Subject: [GIT PULL 3/3] ARM: berlin: DT changes for v3.19 (round 1)
In-Reply-To: <1414927473-25249-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1414927473-25249-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1414927473-25249-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Berlin DT changes for v3.19 and contains those patches that missed
the v3.18 merge window plus corresponding patches to catch-up with Antoine's
BG2Q improvements for BG2 and BG2CD. We now have working SDHCI and Ethernet
on all SoCs (well, BG2CD has HDMI HEC only), SATA PHY support for BG2 is still
pending.

Please pull.

Thanks,
  Sebastian

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-3.19-1

for you to fetch changes up to e4fdc8e5821d852a933963ba56b9b2fa8f68c68f:

  ARM: dts: berlin: Enable eMMC on Sony NSZ-GS7 (2014-10-29 19:44:47 +0100)

----------------------------------------------------------------
Berlin DT changes for v3.19 (round 1)
- AHCI and SATA PHY nodes for BG2Q
- Reset controller binding docs
- Ethernet nodes for BG2, BG2CD
- SDHCI nodes for BG2, BG2CD
- Corresponding board changes to enable AHCI, Ethernet, SDHCI

----------------------------------------------------------------
Antoine T?nart (6):
      ARM: dts: berlin: add the AHCI node for the BG2Q
      ARM: dts: berlin: enable the eSATA interface on the BG2Q DMP
      Documentation: bindings: add reset bindings docs for Marvell Berlin SoCs
      ARM: dts: berlin: add a required reset property in the chip controller node
      ARM: dts: berlin: enable timer 1 for sched_clock
      ARM: dts: berlin: Add phy-connection-type to BG2Q Ethernet

Sebastian Hesselbarth (7):
      ARM: dts: berlin: Add GPIO leds to Google Chromecast
      ARM: dts: berlin: Add BG2 ethernet DT nodes
      ARM: dts: berlin: Add BG2CD ethernet DT nodes
      ARM: dts: berlin: Enable ethernet on Sony NSZ-GS7
      ARM: dts: berlin: Add SDHCI controller nodes to BG2/BG2CD
      ARM: dts: berlin: Enable WiFi on Google Chromecast
      ARM: dts: berlin: Enable eMMC on Sony NSZ-GS7

 .../devicetree/bindings/arm/marvell,berlin.txt     | 10 +++
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |  9 +++
 arch/arm/boot/dts/berlin2.dtsi                     | 71 ++++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts  | 26 ++++++++
 arch/arm/boot/dts/berlin2cd.dtsi                   | 46 ++++++++++++++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  8 +++
 arch/arm/boot/dts/berlin2q.dtsi                    | 42 ++++++++++++-
 7 files changed, 211 insertions(+), 1 deletion(-)
