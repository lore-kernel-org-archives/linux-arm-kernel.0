From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Mar 2017 08:05:37 -0700
Subject: [PATCH v5 0/3] GPCv2 power gating driver
Message-ID: <20170314150540.27831-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

This series is a split of the orginal GPCv2 driver patch.

Let me know if there's more to be improved.

Thanks,
Andrey Smirnov

Changes since v4 (see [v4]):

	- Single patch is split into multiple as per Shawn's reques

	- Incorporated various feedback from Shawn

Changes since v3 (see [v3]):

	- Minor device tree bindings documentation fixes as per
          feedback from Rob Herring
	- Collect Acked-by from Rob

Changes since v2 (see [v2]):

	- Fix a critical bug where incorrect state of a bit was
          expected in a busy wait loop (bit set instead of bit
          cleared) imx7_gpc_pu_pgc_sw_pxx_req()

	- Add missing step (setting of PCR in GPC_PGC_nCTRL) in power
          down procedure

Changes since v1 (see [v1]):

	- Various small DT bindings description fixes as per feedback
          from Rob Herring


[v1] https://lkml.org/lkml/2017/2/6/554
[v2] https://lkml.org/lkml/2017/2/13/489
[v3] https://lkml.org/lkml/2017/2/20/338
[v4] https://lkml.org/lkml/2017/2/28/738

Andrey Smirnov (3):
  ARM: imx: Add GPCv2 power gating driver bindings
  soc/imx: Add GPCv2 power gating driver
  ARM: imx: select IMX7_PM_DOMAINS for SOC_IMX7D

 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  71 ++++
 arch/arm/mach-imx/Kconfig                          |   1 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/imx/Kconfig                            |   9 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/gpcv2.c                            | 387 +++++++++++++++++++++
 include/dt-bindings/power/imx7-power.h             |  18 +
 7 files changed, 488 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 drivers/soc/imx/Kconfig
 create mode 100644 drivers/soc/imx/gpcv2.c
 create mode 100644 include/dt-bindings/power/imx7-power.h

-- 
2.9.3
