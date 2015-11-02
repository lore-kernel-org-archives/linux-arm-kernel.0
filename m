From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Nov 2015 13:31:43 +0900
Subject: [PATCH v6 0/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-ID: <1446438708-22433-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patchset enables the EthernetAVB on the Salvator-X board.
With it and its dependencies in place I have have successfully
booted to an nfsroot user-space (arm64 Debian Jessie).

In order to achieve that I used the following command line set from u-boot.

root=/dev/nfs ip=dhcp nfsroot=10.3.3.135:/srv/nfs/salvator-x-arm64


Changes:

* Update for new CPG/MSSR bindings via Geert Uytterhoeven
* New patch to add ethernet0 alias
* See changelog of individual patches for more details


Base:

This is based on:

* "[PATCH v12 0/7] arm64: renesas: Add Renesas R8A7795 SoC support"
  - topic/r8a7795-gpio-v3 branch of my renesas tree


Runtime Dependencies:

* The base (above)

* "[PATCH/RFC v3 net-next 0/4] ravb: Add support for r8a7795 SoC"
  and its dependencies
  - David Miller's net-next tree

* v4.3-rc2 for "[PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM"
  - Included in net-next

* "[PATCH/RFC v2] sh-pfc: r8a7795: add EtherAVB support"
  and its dependencies
  - for-next branch of Linus Walleij's pinctl tree

* "[PATCH v5 0/5] clk: shmobile: Add new CPG/MSSR driver"
  - topic/cpg-mssr-v5 branch of Geert Uytterhoeven's renesas-drivers tree


Availability:

To aid review of this and other EtherAVB patches the following branches are
available in my renesas tree on kernel.org.

* topic/r8a7795-ravb-v6: this patchset
* topic/r8a7795-ravb-v6.runtime:
      the above branch and its runtime dependencies


Geert Uytterhoeven (1):
  arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot

Kazuya Mizuguchi (2):
  arm64: dts: r8a7795: add EthernetAVB device node
  arm64: dts: r8a7795: enable EthernetAVB on Salvator-X

Simon Horman (2):
  arm64: dts: r8a7795: enable nfs root on Salvator-X board
  arm64: defconfig: enable EthernetAVB

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 34 +++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 42 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 ++
 3 files changed, 77 insertions(+), 1 deletion(-)

-- 
2.1.4
