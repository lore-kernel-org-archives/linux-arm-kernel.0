From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:48:13 +0900
Subject: [PATCH v5 0/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-ID: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patchset enables the EthernetAVB on the Salvator-X board.
With it and its dependencies in place I have have successfully
booted to an nfsroot user-space (arm64 Debian Jessie).

In order to achieve that I used the following command line set from u-boot.


As per "[PATCH v11 0/8] arm64: renesas: Add Renesas R8A7795 SoC support":

	This series has undergone a number of rounds of development and
	review on the linux-sh mailing list. This is the first posting to a
	wider audience from which we are now seeking review.

	It is anticipated that the CPG bindings used this patchset will be
	changed before they hit mainline and thus this patchset will need
	to be updated accordingly. Reviewers are advised to skip over that
	portion of this patchset unless they have a particular interest in
	that discussion.

root=/dev/nfs ip=dhcp nfsroot=10.3.3.135:/srv/nfs/salvator-x-arm64

Changes:

* See changelog of individual patches
* Only change since v4 is rebase

Base:

This is based on:

* "[PATCH v11 0/8] arm64: renesas: Add Renesas R8A7795 SoC support"
  - topic/arm64-rcar-gen3-v11 branch of my renesas tree

Runtime Dependencies:

* The base (above)

* "[PATCH/RFC v3 net-next 0/4] ravb: Add support for r8a7795 SoC"
  and its dependencies
  - David Miller's net-next tree

* v4.3-rc2 for "[PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM"
  - Included in net-next

* "[PATCH 0/3] Basic GPIO support for r8a7795"
  - topic/r8a7795-gpio-v1.rebase3 branch of my renesas tree

* "[PATCH/RFC v2] sh-pfc: r8a7795: add EtherAVB support"
  and its dependencies
  - me/r8a7795-ravb-pfc-v2 branch of my renesas tree

* "[PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8"
  - topic/gen3-cpg-v8+fix branch of Geert Uytterhoeven's renesas-drivers tree

Availability:

To aid review of this and other EtherAVB patches the following branches are
available in my renesas tree on kernel.org.

* me/r8a7795-ravb-pfc-v2: PFC update for EthernetAVB on r8a7795
* me/r8a7795-ravb-integration-v5: this patchset
* me/r8a7795-ravb-driver-and-integration-v5.runtime:
      the above three branches with their runtime dependencies

Kazuya Mizuguchi (3):
  arm64: dts: r8a7795: add clock for EthernetAVB
  arm64: dts: r8a7795: add EthernetAVB device node
  arm64: dts: r8a7795: enable EthernetAVB on Salvator-X

Simon Horman (2):
  arm64: dts: r8a7795: enable nfs root on Salvator-X board
  arm64: defconfig: enable EthernetAVB

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 33 ++++++++++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 54 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 +
 include/dt-bindings/clock/r8a7795-clock.h          |  1 +
 4 files changed, 89 insertions(+), 1 deletion(-)

-- 
2.1.4
