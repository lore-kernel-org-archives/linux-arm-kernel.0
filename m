From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Dec 2015 11:46:42 +0000
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20151202114642.1eda69352e8d753d09e09a71@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in arch/arm64/configs/defconfig between commit e324654294907a4 ("ARM: use "depends on" for SoC configs instead of "if" after prompt") from the arm-soc tree and commit 099a6644f5be4 ("soc/tegra: Provide per-SoC Kconfig symbols") from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

diff --cc arch/arm/mach-tegra/Kconfig
index a90f3556017f,6f7bec07cda6..000000000000
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@@ -1,6 -1,5 +1,6 @@@
- menuconfig ARCH_TEGRA
+ config ARCH_TEGRA
 -	bool "NVIDIA Tegra" if ARCH_MULTI_V7
 +	bool "NVIDIA Tegra"
 +	depends on ARCH_MULTI_V7
  	select ARCH_REQUIRE_GPIOLIB
  	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
  	select ARM_AMBA
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/b5c6a326/attachment.sig>
