From: s-anna@ti.com (Suman Anna)
Date: Mon, 21 Aug 2017 18:51:53 -0500
Subject: [PATCH 0/5] Enable DRA7 processor MMU DT nodes 
Message-ID: <20170821235158.4968-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following series enables the DSP and IPU MMUs on various
TI DRA7xx/AM57xx boards. This is part 2 of the patches for
enabling the MMUs on DRA7 SoCs (OMAP4 and OMAP5 are already
supported on mainline).

Patches are baselined on your for-next branch with HEAD of
a70cb93b6c2f ("Merge branch 'omap-for-v4.14/dt-v3' into for-next").

I have tested the patches on current TI DRA7xx/AM57xx boards (DRA7,
DRA72, DRA71, DRA76 EVMs, AM571x & AM572x IDKs and AM57xx BeagleBoard-X15)
as well as the OMAP4 Panda and OMAP5 uEVM. The boards can boot fine
with just these patches, but requires the hwmod patches to be able
to use them (otherwise get the failures from _od_fail_runtime_{resume/suspend}
functions). There are no consumer devices for these yet, and they
just probe but are not clocked/enabled by default, so the current
System suspend is not affected.

regards
Suman

Suman Anna (5):
  ARM: dts: dra7-evm-common: Enable relevant IPU and DSP MMU nodes
  ARM: dts: dra72-evm-common: Enable relevant IPU and DSP MMU nodes
  ARM: dts: beagle-x15-common: Enable relevant IPU and DSP MMU nodes
  ARM: dts: am572x-idk: Enable relevant IPU and DSP MMU nodes
  ARM: dts: am571x-idk: Enable relevant IPU and DSP MMU nodes

 arch/arm/boot/dts/am571x-idk.dts                | 16 ++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts                | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm-common.dtsi          | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi         | 16 ++++++++++++++++
 5 files changed, 104 insertions(+)

-- 
2.13.1
