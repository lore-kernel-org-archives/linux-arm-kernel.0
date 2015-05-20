From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 20 May 2015 10:08:51 +1000
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
Message-ID: <20150520100851.2e485c02@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Today's linux-next merge of the at91 tree got a conflict in
arch/arm/configs/multi_v7_defconfig between commit 7b57472fb6cb ("ARM:
multi_v7_defconfig: enable asm and NEON accelerated crypto modules")
from the arm-soc tree and commit 822cfdfb9511 ("ARM:
multi_v7_defconfig: Add Atmel SAMA5 family") from the at91 tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/configs/multi_v7_defconfig
index 492f6289a29e,cf56d4072a90..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -272,9 -278,9 +283,10 @@@ CONFIG_I2C_DAVINCI=
  CONFIG_I2C_MUX=y
  CONFIG_I2C_MUX_PCA954x=y
  CONFIG_I2C_MUX_PINCTRL=y
+ CONFIG_I2C_AT91=m
  CONFIG_I2C_CADENCE=y
  CONFIG_I2C_DESIGNWARE_PLATFORM=y
 +CONFIG_I2C_DIGICOLOR=m
  CONFIG_I2C_GPIO=m
  CONFIG_I2C_EXYNOS5=y
  CONFIG_I2C_MV64XXX=y
@@@ -514,8 -523,9 +530,10 @@@ CONFIG_RTC_DRV_TPS6586X=
  CONFIG_RTC_DRV_TPS65910=y
  CONFIG_RTC_DRV_S35390A=m
  CONFIG_RTC_DRV_EM3027=y
 +CONFIG_RTC_DRV_DIGICOLOR=m
  CONFIG_RTC_DRV_PL031=y
+ CONFIG_RTC_DRV_AT91RM9200=m
+ CONFIG_RTC_DRV_AT91SAM9=m
  CONFIG_RTC_DRV_VT8500=y
  CONFIG_RTC_DRV_SUN6I=y
  CONFIG_RTC_DRV_SUNXI=y
@@@ -599,14 -613,6 +622,17 @@@ CONFIG_LOCKUP_DETECTOR=
  CONFIG_CRYPTO_DEV_TEGRA_AES=y
  CONFIG_CPUFREQ_DT=y
  CONFIG_KEYSTONE_IRQ=y
 +CONFIG_ARM_CRYPTO=y
 +CONFIG_CRYPTO_SHA1_ARM=m
 +CONFIG_CRYPTO_SHA1_ARM_NEON=m
 +CONFIG_CRYPTO_SHA1_ARM_CE=m
 +CONFIG_CRYPTO_SHA2_ARM_CE=m
 +CONFIG_CRYPTO_SHA256_ARM=m
 +CONFIG_CRYPTO_SHA512_ARM=m
 +CONFIG_CRYPTO_AES_ARM=m
 +CONFIG_CRYPTO_AES_ARM_BS=m
 +CONFIG_CRYPTO_AES_ARM_CE=m
 +CONFIG_CRYPTO_GHASH_ARM_CE=m
+ CONFIG_CRYPTO_DEV_ATMEL_AES=m
+ CONFIG_CRYPTO_DEV_ATMEL_TDES=m
+ CONFIG_CRYPTO_DEV_ATMEL_SHA=m
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/ca8bb4f7/attachment.sig>
