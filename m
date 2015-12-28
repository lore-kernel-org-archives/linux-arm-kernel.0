From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Mon, 28 Dec 2015 15:31:22 +0530
Subject: [PATCH v4 0/2] ARM64: Enable SP805 WDT support for FSL LS2080A
Message-ID: <1451296884-7932-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

This is the v4 of patchset which adds the support for SP805 WDT on FSL LS2080A
and also adds the missing documentation of SP805 WDT device-tree bindings.

Rebased against arm-soc/next/dt

Changes since v3:
(v3 can be viewed here: https://www.mail-archive.com/devicetree at vger.kernel.org/msg97249.html)
- Added Rob's Acked-by for patch 1/2.
- Sending to 'arm at kernel.org' list and also cc'ed Shawn Guo

Changes since v2:
(v2 can be viewed here: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/463141)
- Addressed Rob's comments regarding the second mandatory CLK source's
  (WDOGCLK) name in the bindings.

Changes since v1:
(v1 can be viewed here: http://www.spinics.net/lists/devicetree/msg102487.html)

- Addressed Rob and Mark's comments regarding the mandatory CLK sources
- Removed interrupt property from the bindings for now (as discussed
  with Mark on IRC) till Will's patch proceeds further and enables
  handling the WDOG interrupts for each core connected to the same PPI
  line (http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391616.html)

Bhupesh Sharma (2):
  Documentation: DT: Add entry for ARM SP805-WDT
  dts/ls2080a: Update DTSI to add support of SP805 WDT

 .../devicetree/bindings/watchdog/sp805-wdt.txt     |   31 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   56 ++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

-- 
1.7.9.5
