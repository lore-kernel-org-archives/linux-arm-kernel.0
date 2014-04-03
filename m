From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu,  3 Apr 2014 10:08:13 +0200
Subject: [PATCH 0/3] ARM: berlin: convert smp to CPU_METHOD_OF_DECLARE
Message-ID: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced CPU_METHOD_OF_DECLARE (6c3ff8b11a16) [1] allows to
get rid of the board file reference to smp ops. This serie converts the
Berlin SoC smp to use this and allows to set the enable-method in the
device tree.

This serie applies on top of Sebastian's topic/smp-bg3-bg2q branch [2]
rebased on top of linux-next.

Tested on the Berlin BG2Q.

[1] https://patchwork.kernel.org/patch/3399311/
[2] https://github.com/shesselba/linux-berlin/tree/topic/smp-bg2-bg2q

Antoine T?nart (3):
  ARM: berlin: use CPU_METHOD_OF_DECLARE for smp
  ARM: dts: document the berlin enable-method property
  ARM: dts: berlin: add enable-method property in cpus node for smp

 Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
 arch/arm/boot/dts/berlin2.dtsi                 | 1 +
 arch/arm/boot/dts/berlin2q.dtsi                | 1 +
 arch/arm/mach-berlin/berlin.c                  | 1 -
 arch/arm/mach-berlin/common.h                  | 2 --
 arch/arm/mach-berlin/platsmp.c                 | 3 ++-
 6 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.8.3.2
