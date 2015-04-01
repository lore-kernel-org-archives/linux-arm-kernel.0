From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:30 +0530
Subject: [RESEND PATCH 0/8] ARM64: Update support for FSL's LS2085A SoC
Message-ID: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the support for FSL's LS2085A SoC which is based on
ARMv8 architecture:

  - Updates the support of various peripherals (PMU, Watchdog, SMMU,
    SPI, etc.) present on FSL LS2085a SoC in the SoC DTSI.

  - Updates the DTS LS2085a simulator platform to reflect the new
    peripherals added in the DTSI.

  - Adds new DTS files for LS2085a based QDS and RDB boards.

Rebased against arm-soc git tree, branch: next/dt

Further details of the LS2085a based platforms can be seen here:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=LS2085A

Note:
-----
I get a checkpatch warning for the amba-bus compatible string
being missing from Documentation/devicetree/bindings/ . I am not aware
if some patch is already being worked on, to solve the same:
	compatible = "arm,amba-bus";

If not, I can try to send a patch, with the re-spin of this patchset.

Bhupesh Sharma (7):
  Documentation: DT: Add entry for FSL LS2085A QDS and RDB boards
  doc/bindings: Update PCIe devicetree binding documentation for
    LS2085A
  doc/bindings: Update clk-qoriq bindings for FSL's chassis-3.0 SoCs
  dts/ls2085a: Update DTSI to add support of various peripherals
  dts/ls2085a: Update Simulator DTS to add support of various
    peripherals
  dts/ls2085a: Add DTS support for LS2085a QDS & RDB boards
  dts/Makefile: Add build support for LS2085a QDS & RDB board DTS

Wang Dongsheng (1):
  layerscape/ftm: Add compatible string for FTM0 be used as alarm
    timer.

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |   14 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +-
 .../devicetree/bindings/timer/fsl,ftm-timer.txt    |   46 +-
 arch/arm64/boot/dts/freescale/Makefile             |    2 +-
 .../{fsl-ls2085a-simu.dts => fsl-ls2085a-qds.dts}  |  140 +++++-
 .../{fsl-ls2085a-simu.dts => fsl-ls2085a-rdb.dts}  |   76 ++-
 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts |   40 ++
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     |  523 +++++++++++++++++++-
 9 files changed, 812 insertions(+), 40 deletions(-)
 copy arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2085a-qds.dts} (51%)
 copy arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2085a-rdb.dts} (69%)

-- 
1.7.9.5
