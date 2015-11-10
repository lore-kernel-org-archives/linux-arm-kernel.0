From: ssimran@broadcom.com (Simran Rai)
Date: Mon, 9 Nov 2015 16:17:41 -0800
Subject: [PATCH v4 0/3]ASoC: cygnus: Add audio support for Broadcom Cygnus SoC
Message-ID: <1447114664-21799-1-git-send-email-ssimran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset contains audio support for Broadcom's Cygnus SoC. It
contains DT bindings and core audio driver. The audio driver
supports both capture and playback of Audio PCM samples over I2S/TDM
interface and provides playback support over SPDIF interface.

This patchset is derived from a previously submitted patchset:
http://lkml.iu.edu/hypermail/linux/kernel/1503.3/05434.html

This patchset has been tested on Cygnus wireless audio bcm958305K board.
It is based on v4.3-rc5  and is available from github:

repo: https://github.com/Broadcom/cygnus-linux/tree/cygnus-sound-v4

Changes from v3:
- Fix the subject lines to match the style for the subsystem

Simran Rai (3):
  ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio
  ASoC: cygnus: Add Cygnus audio DAI driver
  ASoC: cygnus: Add Cygnus audio DMA driver

 .../bindings/sound/brcm,cygnus-audio.txt           |   54 +
 sound/soc/bcm/Kconfig                              |    9 +
 sound/soc/bcm/Makefile                             |    5 +
 sound/soc/bcm/cygnus-pcm.c                         |  859 +++++++++++
 sound/soc/bcm/cygnus-ssp.c                         | 1508 ++++++++++++++++++++
 sound/soc/bcm/cygnus-ssp.h                         |  129 ++
 6 files changed, 2564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
 create mode 100644 sound/soc/bcm/cygnus-pcm.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.h

-- 
1.7.9.5
