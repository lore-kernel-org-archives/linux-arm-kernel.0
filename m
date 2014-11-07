From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri,  7 Nov 2014 18:34:25 +0530
Subject: [[PATCHv2] 0/3] Add SNVS clock gating and clock support to rtc-snvs
 driver
Message-ID: <cover.1415364391.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first version of the patches were send quiet a 
while back. 
https://lkml.org/lkml/2014/9/26/492

The reason for sending this v2 of the patches late was to
prevent any changes midway to the VF dts patches being tried
with the below commit.
https://lkml.org/lkml/2014/10/22/605

Changes since v1:
The clock enable and disable functions for the SNVS are
now optional and only enable/disable it, if it has been
defined in the device tree node. Instead of failing and 
returning error as in the earlier set of patches, this
makes sure that the driver does not break for the other
i.MX devices for which the clock has not been defined and
enabled elsewhere.

Sanchayan Maity (3):
  ARM: imx: clk-vf610: Add clock for SNVS
  ARM: dts: vfxxx: Add SNVS node
  drivers/rtc/rtc-snvs: Add clock support

 arch/arm/boot/dts/vfxxx.dtsi            |   15 ++++++++++++++
 arch/arm/mach-imx/clk-vf610.c           |    1 +
 drivers/rtc/rtc-snvs.c                  |   34 +++++++++++++++++++++++++++++--
 include/dt-bindings/clock/vf610-clock.h |    3 ++-
 4 files changed, 50 insertions(+), 3 deletions(-)

-- 
1.7.9.5
