From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Apr 2015 16:29:50 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.1
Message-ID: <20150409142950.GA17959@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This is a (late) pull request for a single SoC-specific driver that
set up the SRAM mapping.

This mapping was previously done by the bootloader, but in several
occasions, we found out that it couldn't be relied on, and that the
kernel should make sure that these mappings were correct.

I'm aware that this is a late pull request, but hopefully, since it's
a new driver, with no impact on other SoCs, it should be rather safe
to merge.

Thanks,
Maxime

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-4.1

for you to fetch changes up to b7c4366ac68e1b0964a1ec2e53f91e5227273791:

  drivers: soc: sunxi: Introduce SoC driver to map SRAMs (2015-04-05 15:08:09 +0200)

----------------------------------------------------------------
Allwinner drivers patches for 4.1

This pull request contain a single driver to handle the SRAM mapping between
the CPU and devices.

----------------------------------------------------------------
Maxime Ripard (1):
      drivers: soc: sunxi: Introduce SoC driver to map SRAMs

 .../devicetree/bindings/soc/sunxi/sram.txt         |  64 ++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/sunxi/Kconfig                          |  10 +
 drivers/soc/sunxi/Makefile                         |   1 +
 drivers/soc/sunxi/sunxi_sram.c                     | 235 +++++++++++++++++++++
 include/linux/soc/sunxi/sunxi_sram.h               |  24 +++
 7 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sunxi/sram.txt
 create mode 100644 drivers/soc/sunxi/Kconfig
 create mode 100644 drivers/soc/sunxi/Makefile
 create mode 100644 drivers/soc/sunxi/sunxi_sram.c
 create mode 100644 include/linux/soc/sunxi/sunxi_sram.h

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/43f3efb0/attachment.sig>
