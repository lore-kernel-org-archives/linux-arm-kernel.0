From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:03:23 +0530
Subject: [PATCH 0/5] ASoC: Handle platform_get_irq's error checking and return
Message-ID: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct and and we must check its return value.

Arvind Yadav (5):
  [PATCH 1/5] ASoC: ep93xx-ac97: Fix platform_get_irq's error checking
  [PATCH 2/5] ASoC: mt8173: Fix platform_get_irq's error checking
  [PATCH 3/5] ASoC: nuc900: Fix platform_get_irq's error checking
  [PATCH 4/5] ASoC: intel: sst: Handle return value of platform_get_irq
  [PATCH 5/5] ASoC: intel: mfld: Handle return value of platform_get_irq

 sound/soc/cirrus/ep93xx-ac97.c             | 4 ++--
 sound/soc/intel/atom/sst/sst_acpi.c        | 3 +++
 sound/soc/intel/boards/mfld_machine.c      | 2 ++
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 4 ++--
 sound/soc/nuc900/nuc900-ac97.c             | 4 ++--
 5 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.7.4
