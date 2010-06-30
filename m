From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jun 2010 11:12:23 +0100
Subject: Pending patches for -rc
Message-ID: <20100630101223.GA24284@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given Linus' concerns about the code which is going in during the -rc
period, and the clamp-down we had for -rc3, I've re-reviewed the
changes which I have in my master branch.  The following changes do not
feel like critical rc material:

ARM: mx3: pcm037: remove unused variable
pcm037/pcm043/pca100: fix ULPI-related build warnings
eukrea_mbimx27-baseboard: add generic-bl and platform-lcd controls
eukrea_mbimx27-baseboard: add timings for DVI output
cpuimx27 and mbimx27: allow fine control of UART4 and SDHC2 usage
mach-cpuimx27: add USB Host2 and OTG support
mach-cpuimx27: register wdt and w1_master resources
mxcmmc: add card detect through DAT3 possibility
eukrea_mbimx27: use card detect through DAT3 for SDHC1
MX2X: Add Keypad device definition for MX2X arch
eukrea_mbimx27: add support for the keyboard
eukrea_mbimx27: add audio codec
mxc_nand: add support for platform defined partitions
mx25: add platform code for imx-keypad
mx25pdk: add keypad support
mx5: Add i2c to Freescale MX51 Babbage HW
mx5: Register i2c on Freescale MX51 Babbage HW
ARM: 6189/1: Add support for the MOVW/MOVT relocations in Thumb-2
ARM: 6190/1: Remove dummy loads from the original relocation address
ARM: 6191/1: Do not compile the Thumb-2 module relocations on an ARM kernel

The diffstat looks like this (worst offenders):

 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |  181 +++++++++++++++++++++++---
 arch/arm/mach-mx2/mach-cpuimx27.c            |   93 +++++++++++++-
 arch/arm/mach-mx5/devices.c                  |   58 ++++++++
 arch/arm/plat-mxc/clock.c                    |   37 ++++--
 arch/arm/mach-mx25/mach-mx25pdk.c            |   36 +++++
 arch/arm/kernel/module.c                     |   34 +++++
 arch/arm/mach-mx3/mach-mx31lilly.c           |   34 ++++--
 drivers/mtd/nand/mxc_nand.c                  |   33 +----
 44 files changed, 659 insertions(+), 139 deletions(-)

and I think that if I try to push these to Linus, we'll be on the receipt
of another complaint - quite rightfully too - the above does not look like
bug fixes.

Therefore, I won't be pushing my master branch to Linus, but instead merging
it into -devel and re-starting my master branch afresh.
