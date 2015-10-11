From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 12 Oct 2015 10:19:12 +1100
Subject: linux-next: manual merge of the qcom tree with the arm-soc tree
Message-ID: <20151012101912.33e77590@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Today's linux-next merge of the qcom tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commits:

  b605aded4491 ("ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs")
  cc68819a582c ("ARM: multi_v7_defconfig: Enable Rockchip display support")

from the arm-soc tree and commit:

  4e7fb93081f8 ("ARM: multi_v7_defconfig: Enable QCOM SMD/RPM")

from the qcom tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/configs/multi_v7_defconfig
index 0af319ec7047,41aecd75e2aa..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -425,7 -415,7 +425,8 @@@ CONFIG_REGULATOR_MAX77802=
  CONFIG_REGULATOR_PALMAS=y
  CONFIG_REGULATOR_PBIAS=y
  CONFIG_REGULATOR_PWM=m
 +CONFIG_REGULATOR_QCOM_RPM=y
+ CONFIG_REGULATOR_QCOM_SMD_RPM=y
  CONFIG_REGULATOR_S2MPS11=y
  CONFIG_REGULATOR_S5M8767=y
  CONFIG_REGULATOR_TPS51632=y
@@@ -645,7 -631,7 +649,8 @@@ CONFIG_APQ_MMCC_8084=
  CONFIG_MSM_GCC_8660=y
  CONFIG_MSM_MMCC_8960=y
  CONFIG_MSM_MMCC_8974=y
 +CONFIG_ROCKCHIP_IOMMU=y
+ CONFIG_HWSPINLOCK_QCOM=y
  CONFIG_TEGRA_IOMMU_GART=y
  CONFIG_TEGRA_IOMMU_SMMU=y
  CONFIG_PM_DEVFREQ=y
