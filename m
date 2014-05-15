From: elder@linaro.org (Alex Elder)
Date: Thu, 15 May 2014 12:58:06 -0500
Subject: [PATCH v3 RESEND 0/5] ARM: SMP: support Broadcom mobile SoCs
Message-ID: <1400176691-26058-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds SMP support for two Broadcom mobile SoC families.
It uses CPU_METHOD_OF_DECLARE() so that SMP operations are assigned
using device tree rather than adding it to a machine definition in a
board file.

The enable method starts a secondary core by writing to a register
monitored by CPUs spinning in a ROM-based holding pen loop.  The
address of this register is recorded as a property in the "cpus"
node of the device tree.

					-Alex

Note:
This series is based on v3.15-rc4, plus one more recently-posted patch:
    http://permalink.gmane.org/gmane.linux.kernel/1683693

History
v3: - Dropped definition and use of CPU_METHOD_OF_DECLARE_SETUP()
    - Added documentation for "enable-method"
    - Rebased onto v3.15-rc4
v2: - Fixed a Makefile error (:= should have been +=)
    - No longer set CONFIG_NR_CPUS in bcm_defconfig
    - Rebased onto v3.15-rc1

This series is available here:
    http://git.linaro.org/landing-teams/working/broadcom/kernel.git
    Branch review/bcm-smp-v3

Alex Elder (5):
  devicetree: bindings: document Broadcom CPU enable method
  ARM: add SMP support for Broadcom mobile SoCs
  ARM: configs: enable SMP in bcm_defconfig
  ARM: dts: enable SMP support for bcm28155
  ARM: dts: enable SMP support for bcm21664

 Documentation/devicetree/bindings/arm/cpus.txt |  12 ++
 arch/arm/boot/dts/bcm11351.dtsi                |  19 +++
 arch/arm/boot/dts/bcm21664.dtsi                |  19 +++
 arch/arm/configs/bcm_defconfig                 |   1 +
 arch/arm/mach-bcm/Kconfig                      |  18 ++-
 arch/arm/mach-bcm/Makefile                     |   3 +
 arch/arm/mach-bcm/platsmp.c                    | 201 +++++++++++++++++++++++++
 7 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-bcm/platsmp.c

-- 
1.9.1
