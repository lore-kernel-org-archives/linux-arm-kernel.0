From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 7 Feb 2014 13:35:00 +0900
Subject: [PATCH v2 0/6] ARM: firmware: improvements to Trusted Foundations
 support
Message-ID: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These (mostly minor) patches fix a few typos, improve points that
were agreed upon when the Trusted Foundation series was initially
submitted, and more importantly add support for a prepare_idle()
firmware operation that informs the firmware a CPU is doing idle.
Tegra's cpuidle driver is then also updated accordingly.

These patches should be the last step before device trees for NVIDIA
SHIELD and Tegra Note 7 can be submitted.

Changes since v1:
- Do not remove TF support from tegra_defconfig (will automatically be taken
  care of during next configuration update)
- Add a new prepare_idle() operation to firmware_ops that informs the firmware
  a CPU is going idle (vs. asking the firmware to do it itself as do_idle()
  does)
- Fix idle states names in TF implementation of prepare_idle to sound less
  Tegra-specific

Alexandre Courbot (6):
  ARM: trusted_foundations: fix vendor prefix typos
  ARM: trusted_foundations: fallback when TF support is missing
  ARM: firmware: enable Trusted Foundations by default
  ARM: firmware: add prepare_idle() operation
  ARM: trusted_foundations: implement prepare_idle()
  ARM: tegra: cpuidle: use firmware for power down

 arch/arm/firmware/Kconfig                  |  3 ++-
 arch/arm/firmware/trusted_foundations.c    | 20 +++++++++++++++++++-
 arch/arm/include/asm/firmware.h            |  4 ++++
 arch/arm/include/asm/trusted_foundations.h | 13 +++++++++----
 arch/arm/mach-tegra/cpuidle-tegra114.c     | 11 ++++++++++-
 5 files changed, 44 insertions(+), 7 deletions(-)

-- 
1.8.5.3
