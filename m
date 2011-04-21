From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 21 Apr 2011 12:01:28 -0600
Subject: [PATCH 0/4] Tegra patches for 2.6.40
Message-ID: <1303408892-7472-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below are the patches I have queued up for Tegra in 2.6.40.

The first 2 and last 1 are bug fixes and can be applied immediately. I
believe these are all reposts too.

The 3rd updates the Seaboard board to define to required platform data
for the audio driver. This one patch relies on the git pull request that
I sent out earlier today.

I tested:

* After applying these changes, everything builds OK and runs fine on
  Harmony, including audio.
* After additionally merging Mark's ASoC for-2.6.40/for-next branch,
  there are no merge conflicts, everything builds OK, and everything
  runs OK on Seaboard clamshell, including a full audio checkout.
  Note that non-clamshell Seaboard has difficulty initializing I2C.
  I'm investigating this, but don't expect to need to modify any of
  these changes because of this issue; most likely some unrelated bug
  needs fixing.
 
Stephen Warren (4):
  ARM: Tegra: Harmony: Fix conflicting GPIO numbering
  ARM: Tegra: Seaboard: Re-order sdhci device registration
  ARM: Tegra: Seaboard board updates for audio
  ARM: tegra: Harmony: Register and configure WM8903 IRQ GPIO

 arch/arm/mach-tegra/board-harmony-power.c   |    4 +-
 arch/arm/mach-tegra/board-harmony.c         |    3 +
 arch/arm/mach-tegra/board-harmony.h         |    3 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   21 +++++++++-
 arch/arm/mach-tegra/board-seaboard.c        |   56 ++++++++++++++++++++++++++-
 arch/arm/mach-tegra/board-seaboard.h        |   12 ++++--
 6 files changed, 89 insertions(+), 10 deletions(-)
