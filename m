From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:49 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.17
Message-ID: <cover.1521206439.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.17.


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.17

for you to fetch changes up to a20d1390c1daac4b8ae1e544e1e49dfd386125a8:

  ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED (2018-03-05 07:45:31 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.17

Updates to shmobile defconfig:

* Redresh defconfig to ease future maintenence overhead

* Disable CONFIG_EMBEDDED

  Geert Uytterhoeven says "CONFIG_EXPERT exposes too many config options
  that do not matter for development.  E.g. it prohibits using the default
  values for the various SH_SCI options.  However, CONFIG_EMBEDDED selects
  CONFIG_EXPERT, so it cannot be disabled.

  Hence disable CONFIG_EMBEDDED, and compensate for the loss of
  CONFIG_DEBUG_KERNEL by enabling the latter.

  Actual impact, all harmless:
    - CONFIG_NAMESPACES=y (plus a few related CONFIG_*_NS options),
    - CONFIG_SYSCTL_SYSCALL=n,
    - CONFIG_SERIAL_SH_SCI_NR_UARTS changed from 20 to 18,
    - Some HID support became enabled,
    - CONFIG_DEBUG_MEMORY_INIT=y,"

* Enable RZA1 pin controller

  This allows the Genmai board with RZ/A1 (r7s72100) SoC to once
  again boot using the shmobile defconfig.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: defconfig: Refresh
      ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED

Jacopo Mondi (1):
      ARM: shmobile: Enable RZA1 pin controller

 arch/arm/configs/shmobile_defconfig | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)
