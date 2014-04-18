From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 21:01:48 +0200
Subject: [PATCH 0/5] ARM: sun6i: Switch to enable-method for SMP
Message-ID: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent introduction of CPU_METHOD_OF_DECLARE allowed to deprecate
one more fiel of the struct machine_desc.

Switch to it for the Allwinner A31 SoC.

Maxime Ripard (5):
  Documentation: dt: bindings: Document ARM PSCI enable method
  ARM: sun6i: Use CPU_METHOD_OF_DECLARE
  Documentation: dt: bindings: Document Allwinner A31 enable method
  ARM: sun6i: Define the A31 CPUs enable-method
  ARM: sun6i: Retire the smp field in A31 machine

 Documentation/devicetree/bindings/arm/cpus.txt |  2 ++
 arch/arm/boot/dts/sun6i-a31.dtsi               |  1 +
 arch/arm/mach-sunxi/common.h                   | 19 -------------------
 arch/arm/mach-sunxi/platsmp.c                  |  3 +--
 arch/arm/mach-sunxi/sunxi.c                    |  3 ---
 5 files changed, 4 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/common.h

-- 
1.9.1
