From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  8 Mar 2018 23:00:08 +0800
Subject: [PATCH 0/4] ARM: sunxi: Clean and improvements for multi-cluster SMP
Message-ID: <20180308150012.19045-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is a bit of cleanup and improvement for the new
multi-cluster SMP code for Allwinner A80 and A83T (soon) SoCs.

The first patch is just a typo fix.

The second and third patch add the use of the "enable-method" cpu
property to enable SMP, instead of matching against the machine
compatible. However, due to how init calls are sequenced, we still
need to use a platform early_init call.

The last patch splits out parts of the SoC-specific init code, i.e.
the device node matching parts. This should help with Mylene's work
on adding support for the A83T.

Please have a look.

Regards
ChenYu

Chen-Yu Tsai (4):
  ARM: sunxi: mc-smp: Fix "lookback" typo
  ARM: sunxi: mc-smp: Use DT enable-method for sun9i A80 SMP
  ARM: dts: sun9i: Add enable-method for SMP support for the A80 SoC
  ARM: sunxi: mc-smp: Split out SoC-specific device node lookup sequence

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm/boot/dts/sun9i-a80.dtsi               |   8 ++
 arch/arm/mach-sunxi/mc_smp.c                   | 147 ++++++++++++++++++-------
 3 files changed, 115 insertions(+), 41 deletions(-)

-- 
2.16.2
