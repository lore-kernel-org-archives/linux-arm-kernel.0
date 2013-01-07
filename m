From: mikedunn@newsguy.com (Mike Dunn)
Date: Mon,  7 Jan 2013 13:55:11 -0800
Subject: [PATCH 0/3] ALSA: pxa27x: ac97 reset fixes
Message-ID: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
problems:
  - cold reset fails because the GCR register is not set correctly
  - warm reset fails because some code used to work around a hardware bug is
    broken
  - the intent of the work-around code is obfuscated by unfortunate function
    naming

This patch set replaces some earlier individual patches that had some problems.
Thanks Robert and Igor.

Changelog:
v2:
  - don't specify the LPM flag DRIVE_HIGH in #define for the mfp config
  - patches 2 and 3 are combined into one patch
  - mfp level and direction are set only once, during driver initialization

Mike Dunn (3):
  ALSA: pxa2xx: fix ac97 cold reset
  ALSA: pxa27x: fix ac97 warm reset
  ALSA: pxa27x: rename pxa27x_assert_ac97reset()

 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 ++
 arch/arm/mach-pxa/pxa27x.c                  |   24 ++++++++++++------
 sound/arm/pxa2xx-ac97-lib.c                 |   34 +++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 15 deletions(-)

-- 
1.7.8.6
