From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 27 Jul 2015 17:46:37 +0530
Subject: [PATCH 0/4] omap: Fix broken pbias device creation
Message-ID: <1437999401-3519-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pbias device creation got broken once SCM cleanup got merged.
This patch series re-enables device creation by adding
"simple-bus" in the compatible property of the syscon
dt node.

validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
boards.

Kishon Vijay Abraham I (4):
  ARM: dts: omap24xx: Fix broken pbias device creation
  ARM: dts: OMAP4: Fix broken pbias device creation
  ARM: dts: OMAP5: Fix broken pbias device creation
  ARM: dts: dra7: Fix broken pbias device creation

 arch/arm/boot/dts/dra7.dtsi     |    2 +-
 arch/arm/boot/dts/omap2430.dtsi |    3 ++-
 arch/arm/boot/dts/omap4.dtsi    |    3 ++-
 arch/arm/boot/dts/omap5.dtsi    |    3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.7.9.5
