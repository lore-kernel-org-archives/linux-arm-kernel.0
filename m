From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 5 Sep 2013 12:27:55 +0900
Subject: [PATCH v5 0/5] ARM: support for Trusted Foundations secure monitor
Message-ID: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After several rounds of reviews, this patchset should be close to maturity. This
fifth version gathers the Reviewed-by tags, addresses the (hopefully) last
issues, and seeks the Acked-bys of ARM maintainers to be merged, probably
through the Tegra tree.

Changes since v4:
- Added ifdefs to isolate open firmware-dependant code
- Changed BUGS() into more appropriate calls to panic()
- Fix hard-fail when TF support is not compiled in
- Make Tegra documentation reference the TF binding
- Tested extensively

As there is no consensus on the matter, I have left the TF version in device
tree as two separate nodes. Comments for or against this and references to prior
practices regarding version handling in the device tree are welcome.

Alexandre Courbot (5):
  ARM: add basic Trusted Foundations support
  ARM: tegra: add support for Trusted Foundations
  ARM: tegra: split setting of CPU reset handler
  ARM: tegra: set CPU reset handler with firmware op
  ARM: tegra: support Trusted Foundations by default

 .../arm/firmware/tl,trusted-foundations.txt        | 17 +++++
 Documentation/devicetree/bindings/arm/tegra.txt    |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/Kconfig                                   |  2 +
 arch/arm/Makefile                                  |  1 +
 arch/arm/configs/tegra_defconfig                   |  1 +
 arch/arm/firmware/Kconfig                          | 25 +++++++
 arch/arm/firmware/Makefile                         |  1 +
 arch/arm/firmware/trusted_foundations.c            | 82 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h         | 53 ++++++++++++++
 arch/arm/mach-tegra/Kconfig                        |  1 +
 arch/arm/mach-tegra/common.c                       |  2 +
 arch/arm/mach-tegra/reset.c                        | 40 ++++++++---
 13 files changed, 220 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
 create mode 100644 arch/arm/firmware/Kconfig
 create mode 100644 arch/arm/firmware/Makefile
 create mode 100644 arch/arm/firmware/trusted_foundations.c
 create mode 100644 arch/arm/include/asm/trusted_foundations.h

-- 
1.8.4
