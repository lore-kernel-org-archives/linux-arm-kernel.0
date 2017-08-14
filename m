From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:48 -0700
Subject: [PATCH 0/9] ASoC: cygnus: Various improvements and fixes
Message-ID: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains an number of improvements and refinements
to the driver. There is also a fix for a problem when transferring
four or more channels in TDM mode.

Lori Hikichi (9):
  ASoC: cygnus: Add support for 384kHz frame rates
  ASoC: cygnus: Update bindings for audio clock changes
  ASoC: cygnus: Allow each port to select its clock source
  ASoC: cygnus: Only enable MCLK pins when in use
  ASoC: cygnus: Remove support for 8 bit audio and for mono
  ASoc: cygnus: Fix problems with multichannel transfers
  ASoC: cygnus: Remove set_fmt from SPDIF dai ops
  ASoC: cygnus: Add EXPORT_SYMBOL for helper function
  ASoC: cygnus: Tidy up of structure access

 .../bindings/sound/brcm,cygnus-audio.txt           |   70 +-
 sound/soc/bcm/cygnus-pcm.c                         |   50 +-
 sound/soc/bcm/cygnus-ssp.c                         | 1336 ++++++++++----------
 sound/soc/bcm/cygnus-ssp.h                         |   51 +-
 4 files changed, 739 insertions(+), 768 deletions(-)

-- 
1.9.1
