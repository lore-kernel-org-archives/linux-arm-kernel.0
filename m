From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Nov 2012 23:51:14 +0100
Subject: [GIT PULL] Integrator SoC bus patches
Message-ID: <CACRpkdYKWLMMOa7+CV8yMNe5-EV1p5fYeVJ+bn55KLLFBZdD=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

could you please pull this Integrator patch set as previously circulated
on the list, targetting the v3.8 merge window? The details are in the
tag.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-socbus

for you to fetch changes up to 328ba305e3871d4256398a80f45517ec9c814999:

  ARM: integrator: delete static UART1 mapping (2012-11-16 22:26:26 +0100)

----------------------------------------------------------------
This series will do the following:
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

----------------------------------------------------------------
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
