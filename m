From: s-anna@ti.com (Suman Anna)
Date: Mon, 18 Sep 2017 19:28:30 -0500
Subject: [PATCH 0/3] Add and enable DSP device on OMAPL138 LCDK board
Message-ID: <20170919002833.5677-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

The following series adds the DT node for the DSP device present on
on DA850/OMAPL138 SoCs. The node is disabled in the base dts file, and
enabled in the corresponding LCDK board file alongside the reserved
CMA pool required by the DSP device. The DT bindings and driver
adaptation were added to mainline in 4.14-rc1, and this series adds
the remaining dt portions. Nodes are added as per bindings in
Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt

Patches are based on 4.14-rc1. The first 2 patches adds the base DTS
node and enables the device on OMAPL138 LCDK board. The last patch
allows the non-DT clock to be bound to the DT DSP device by using
of_auxdata which renames the device to the same as the non-DT device
name. This is required by the davinci remoteproc driver to properly
acquire and enable the clock for this device.

Validation done on OMAPL138 LCDK board. Supported features include
basic load/boot (tested with rpmsg_client_sample) using external
memory from the CMA pool.

regards
Suman

Suman Anna (3):
  ARM: dts: da850: Add DSP node
  ARM: dts: da850-lcdk: Add and enable CMA reserved pool for DSP
  ARM: davinci: da8xx-dt: Add OF_DEV_AUXDATA entry for DSP clock
    matching

 arch/arm/boot/dts/da850-lcdk.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 12 ++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |  1 +
 3 files changed, 31 insertions(+)

-- 
2.13.1
