From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Nov 2012 01:52:22 +0100
Subject: [PATCH 0/6] ARM: integrator: SoC bus & cleanup
Message-ID: <1352681542-12835-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series will:

- Switch the Integrator/AP and /CP to use the SoC bus
  when booting from device tree.
- Group all devices on the SoC below this bus so as to
  set a good example of how to do this. The bus was
  invented by Lee Jones, let's show how it's to be used
  on a DT:ed SoC.
- Fetch the special system controller offsets from two
  special device tree nodes for each case and replace
  the static mappings with these at boot.
- Move some static remaps to the ATAG-only code path
  and delete some static maps that aren't used.

Linus Walleij (6):
  ARM: integrator: hook the AP into the SoC bus
  ARM: integrator: hook the CP into the SoC bus
  ARM: integrator: remove static AP syscon mapping
  ARM: integrator: remove static CP syscon mapping
  ARM: integrator: delete SC mapping on the CP
  ARM: integrator: delete static UART1 mapping

 Documentation/devicetree/bindings/arm/arm-boards |   4 +
 arch/arm/boot/dts/integratorap.dts               |   5 +
 arch/arm/boot/dts/integratorcp.dts               |   5 +
 arch/arm/mach-integrator/Kconfig                 |   2 +
 arch/arm/mach-integrator/common.h                |   1 +
 arch/arm/mach-integrator/core.c                  |  91 ++++++++++++++++++
 arch/arm/mach-integrator/integrator_ap.c         | 114 ++++++++++++++++++-----
 arch/arm/mach-integrator/integrator_cp.c         | 111 ++++++++++++++++------
 8 files changed, 283 insertions(+), 50 deletions(-)

-- 
1.7.11.7
