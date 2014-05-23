From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 19:23:34 +0200
Subject: [GIT PULL] Allwinner core additions for 3.16, take 2
Message-ID: <20140523172334.GA8620@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the last core pull request for the upcoming merge window.

It comes on top of the previous pull request.

Thanks!
Maxime

The following changes since commit 324da938cb7eb103a925817f9aacdcc1f0e22576:

  ARM: sunxi: select MFD_SUN6I_PRCM when sun6i arch support is enabled (2014-05-15 17:30:07 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.16-2

for you to fetch changes up to 5e669ec583e2687d3512d965cf2e209095f70c62:

  ARM: sunxi: Remove init_machine callback (2014-05-23 10:39:10 +0200)

----------------------------------------------------------------
Allwinner Core additions for 3.16, take 2

  - Convert the A31 SMP operations to the CPU_METHOD_OF_DECLARE mechanism
  - Remove the reset code from the machine definition, that removes pretty much
    all the code left in mach-sunxi

----------------------------------------------------------------
Maxime Ripard (6):
      Documentation: dt: bindings: Document ARM PSCI enable method
      ARM: sun6i: Use CPU_METHOD_OF_DECLARE
      Documentation: dt: bindings: Document Allwinner A31 enable method
      ARM: sun6i: Retire the smp field in A31 machine
      ARM: sunxi: Remove reset code from the platform
      ARM: sunxi: Remove init_machine callback

 Documentation/devicetree/bindings/arm/cpus.txt |   2 +
 arch/arm/mach-sunxi/common.h                   |  19 -----
 arch/arm/mach-sunxi/platsmp.c                  |   3 +-
 arch/arm/mach-sunxi/sunxi.c                    | 110 -------------------------
 4 files changed, 3 insertions(+), 131 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/common.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/d60198f1/attachment-0001.sig>
