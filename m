From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 15 Mar 2017 20:10:59 +0000
Subject: [PATCH v6 0/3] ARCH_VULCAN to ARCH_THUNDER2 transition
In-Reply-To: <1489495634-2920-1-git-send-email-jnair@caviumnetworks.com>
References: <1489495634-2920-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1489608662-4434-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more update on this patchset, hopefully the final one.

Here are the updated versions of two patches of the series that did
not get into 4.11.  The patches are move the device trees to their
new location and to document the new cpu and core names.

I have now added a third patch to update the maintainer info

v6->v7
Add a new patch to update the MAINTAINERS file (suggested by Florian)
Add Acked-by from Florian.

v5->v6
Updated version addressing comment from Matthias, and adding his
Reviewed-by tag. (https://www.spinics.net/lists/arm-kernel/msg568157.html)

JC.


Jayachandran C (3):
  dt-bindings: arm64 ARCH_THUNDER2 platform documentation
  arm64: dts: move from ARCH_VULCAN to ARCH_THUNDER2
  MAINTAINERS: Broadcom Vulcan is now Cavium ThunderX2

 .../devicetree/bindings/arm/cavium-thunder2.txt    |   8 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 MAINTAINERS                                        |   9 +-
 arch/arm64/boot/dts/broadcom/Makefile              |   1 -
 arch/arm64/boot/dts/broadcom/vulcan-eval.dts       |  33 -----
 arch/arm64/boot/dts/broadcom/vulcan.dtsi           | 147 --------------------
 arch/arm64/boot/dts/cavium/Makefile                |   1 +
 arch/arm64/boot/dts/cavium/thunder2-99xx.dts       |  34 +++++
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      | 148 +++++++++++++++++++++
 9 files changed, 193 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 delete mode 100644 arch/arm64/boot/dts/broadcom/vulcan-eval.dts
 delete mode 100644 arch/arm64/boot/dts/broadcom/vulcan.dtsi
 create mode 100644 arch/arm64/boot/dts/cavium/thunder2-99xx.dts
 create mode 100644 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi

-- 
2.7.4
