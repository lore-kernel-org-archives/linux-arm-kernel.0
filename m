From: mikedunn@newsguy.com (Mike Dunn)
Date: Sun,  6 Jan 2013 11:13:56 -0800
Subject: [PATCH 0/4] ALSA: pxa27x: ac97 reset fixes
Message-ID: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
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

Mike Dunn (4):
  ALSA: pxa27x: fix ac97 cold reset
  ALSA: pxa27x: fix ac97 warm reset bug work-around code
  ALSA: pxa27x: ac97 controller driver requests gpio
  ALSA: pxa27x: rename pxa27x_assert_ac97()

 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 ++
 arch/arm/mach-pxa/pxa27x.c                  |   38 +++++++++++++++++++-------
 sound/arm/pxa2xx-ac97-lib.c                 |   26 +++++++++++++-----
 3 files changed, 50 insertions(+), 17 deletions(-)

-- 
1.7.8.6
