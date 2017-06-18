From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 18 Jun 2017 23:55:23 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.13
In-Reply-To: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1497801323-6389-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.13

for you to fetch changes up to 6db53373884327f0457d90aa665d249a11461b07:

  ARM: imx_v6_v7_defconfig: Select CONFIG_IMX7D_ADC (2017-06-18 07:32:01 +0800)

----------------------------------------------------------------
The i.MX defconfig updates for 4.13:
 - Enable i.MX7 ADC driver support.
 - Enable THERMAL_WRITABLE_TRIPS, so that i.MX thermal driver can set
   trip points for testing.
 - CONFIG_DEBUG_FS gets lost by accident because of a change around
   CONFIG_RCU_TRACE.  Re-enable it explicitly.
 - Enable MXS LRADC driver and CONFIG_CGROUPS for mxs_defconfig.
 - Enable more common cpufreq governors to help test cpufreq driver.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select CONFIG_IMX7D_ADC

Leonard Crestez (3):
      ARM: imx_v6_v7_defconfig: Enable cpufreq governors
      ARM: imx_v6_v7_defconfig: Explicitly restore CONFIG_DEBUG_FS
      ARM: imx_v6_v7_defconfig: Set THERMAL_WRITABLE_TRIPS=y for testing

Stefan Wahren (2):
      ARM: mxs_defconfig: Enable CONFIG_CGROUPS
      ARM: mxs_defconfig: Re-enable MXS LRADC

 arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
 arch/arm/configs/mxs_defconfig       | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)
