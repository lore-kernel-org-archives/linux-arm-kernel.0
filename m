From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 21 Mar 2017 07:50:02 -0700
Subject: [PATCH v7 0/2] GPCv2 power gating driver
Message-ID: <20170321145004.21265-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

Here's v7 of GPCv2 patches with feedback from Dong incorporated.

Let me know if you want to do any of renaming that Dong suggested and
if there's more to be improved in general.

Thanks,
Andrey Smirnov

Changes since v6 (see [v6]):

	- Drop .readable_reg related code

	- Switch regmap to REGCACHE_NONE and drop .volatile_reg

	- Remove unnecessary #include directives

Changes since v5 (see [v5]):

	- Apply reverse tree variable declartaion fromatting to
          imx_gpcv2_probe() and imx7_gpc_pu_pgc_sw_pxx_req()

	- Drop patch #3 in favour of defaulting to y in Kconfig
	
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
[v5] https://lkml.org/lkml/2017/3/14/547
[v6] https://lkml.org/lkml/2017/3/16/357

Andrey Smirnov (2):
  dt-bindings: Add GPCv2 power gating driver
  soc/imx: Add GPCv2 power gating driver

 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  71 ++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/imx/Kconfig                            |  10 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/gpcv2.c                            | 365 +++++++++++++++++++++
 include/dt-bindings/power/imx7-power.h             |  18 +
 6 files changed, 466 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 drivers/soc/imx/Kconfig
 create mode 100644 drivers/soc/imx/gpcv2.c
 create mode 100644 include/dt-bindings/power/imx7-power.h

-- 
2.9.3
