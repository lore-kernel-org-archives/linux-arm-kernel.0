From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 23 Sep 2018 13:38:05 +0200
Subject: [PATCH v4 0/2] Reworked rk3288-tinker-s devicetree
Message-ID: <20180923113807.11558-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

I've adpated your patches 1+2 like so and would like to add them this way
later on. Biggest change is of course making patch 1 solely about moving
the shared parts to the dtsi and adding the tinker-s.dts including the
emmc in the second patch.

Apart from that you can also see some previously missing style-related
fixes. For example patch subject lines are somewhat specific, to allow
people browsing the git history to realize the core patch contents just
from the "headline" and also use the "correct" prefixes which vary
depending on the subsystem your changing.

For future patches you can just do a "git log --oneline arch/arm/boot/dts"
(change directory depending on location of the change of course), to
see that arm32 dts use "ARM: dts: $soc-vendor: foo".


Also providing a commit message describing the individual change
in a bit more detail is important.

The wifi patch is a different issue, so I'll reply there.


Heiko

David Summers (2):
  ARM: dts: rockchip: move shared tinker-board nodes to a common dtsi
  ARM: dts: rockchip: add rk3288-based Tinker board S

 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3288-tinker-s.dts         |  26 +
 arch/arm/boot/dts/rk3288-tinker.dts           | 498 +----------------
 arch/arm/boot/dts/rk3288-tinker.dtsi          | 504 ++++++++++++++++++
 5 files changed, 537 insertions(+), 496 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts
 create mode 100644 arch/arm/boot/dts/rk3288-tinker.dtsi

-- 
2.18.0
