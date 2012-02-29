From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 28 Feb 2012 17:03:24 -0700
Subject: [PATCH 2/2] ARM: tegra: Add zreladdr etc to Makefile.boot for Tegra30
In-Reply-To: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
Message-ID: <1330473804-23348-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These previously weren't present, because they're different for Tegra20
and Tegra30, which forced one to specify LOADADDR= when building uImages
for kernels with both Tegra20 and Tegra30 support enabled.

My expectation now is that everyone will turn on CONFIG_UIMAGE_NOLOAD and
hence not be inconvenienced by having this information present.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This somewhat depends on the previous patch or it'll be annoying to build
multi-SoC Tegra kernels, so I guess it should get merged through the same
tree.

 arch/arm/mach-tegra/Makefile.boot |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index 9a82094..b6101f8 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -2,6 +2,10 @@ zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= 0x00008000
 params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
 
+zreladdr-$(CONFIG_ARCH_TEGRA_3x_SOC)	+= 0x80008000
+params_phys-$(CONFIG_ARCH_TEGRA_3x_SOC)	:= 0x80000100
+initrd_phys-$(CONFIG_ARCH_TEGRA_3x_SOC)	:= 0x80800000
+
 dtb-$(CONFIG_MACH_HARMONY) += tegra-harmony.dtb
 dtb-$(CONFIG_MACH_PAZ00) += tegra-paz00.dtb
 dtb-$(CONFIG_MACH_SEABOARD) += tegra-seaboard.dtb
-- 
1.7.0.4
