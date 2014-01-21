From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 21 Jan 2014 19:10:11 +0900
Subject: [PATCH 0/5] ARM: firmware: improvements to Trusted Foundations support
Message-ID: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These (mostly minor) patches fix a few typos, improve points that
were agreed upon when the Trusted Foundation series was initially
submitted, and more importantly add support for the do_idle() firmware
operation that is needed for cpuidle to be supported. Tegra's cpuidle
driver is also updated accordingly.

These patches should be the last step before the device trees for NVIDIA
SHIELD and Tegra Note 7 can be submitted.

Alexandre Courbot (5):
  ARM: trusted_foundations: fix vendor prefix typos
  ARM: trusted_foundations: fallback when TF support is missing
  ARM: firmware: enable Trusted Foundations by default
  ARM: trusted_foundations: implement do_idle()
  ARM: tegra: cpuidle: use firmware call for power down

 arch/arm/configs/tegra_defconfig           |  1 -
 arch/arm/firmware/Kconfig                  |  3 ++-
 arch/arm/firmware/trusted_foundations.c    | 20 +++++++++++++++++++-
 arch/arm/include/asm/trusted_foundations.h | 13 +++++++++----
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +++
 5 files changed, 33 insertions(+), 7 deletions(-)

-- 
1.8.5.3
