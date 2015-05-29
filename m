From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 29 May 2015 14:55:01 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.2 (part 2)
Message-ID: <1432936501-20453-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ed5cd8163da8d3e02ef83b84e42d555d40bab96a:

  ARM: BCM63xx: Add SMP support for BCM63138 (2015-05-20 15:08:44 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.2/soc-part2

for you to fetch changes up to b35d2e561ea711626749fcb511637f0e4604ff18:

  ARM: brcmstb: Add default gpio number (2015-05-29 14:43:13 -0700)

----------------------------------------------------------------
This pull request contains the following changes for Broadcom SoCs:

- Dan fixes an error path in the BCM63xx SMP code

- Ray adds the relevant Kconfig selects to enable the Broadcom NAND driver on Cygnus

- Kevin provides a change to the Broadcom GISB arbiter driver to make it work with
  MIPS-based big-endian STB SoCs (this was a long-standing change that had dependencies on
  code in drivers/of/*)

- Gregory enables the use of GPIOLIB for brcmstb SoCs and bumps the number of GPIOs for
  these platforms

Thank you!

----------------------------------------------------------------
Dan Carpenter (1):
      ARM: BCM63xx: fix an error path in bcm63xx_pmb_power_on_cpu()

Gregory Fong (2):
      ARM: brcmstb: Select ARCH_WANT_OPTIONAL_GPIOLIB
      ARM: brcmstb: Add default gpio number

Kevin Cernekee (1):
      bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties

Ray Jui (1):
      ARM: BCM: Enable NAND support for iProc SoCs

 arch/arm/Kconfig                |  3 ++-
 arch/arm/mach-bcm/Kconfig       |  2 ++
 arch/arm/mach-bcm/bcm63xx_pmb.c |  2 +-
 drivers/bus/brcmstb_gisb.c      | 13 +++++++++++--
 4 files changed, 16 insertions(+), 4 deletions(-)
