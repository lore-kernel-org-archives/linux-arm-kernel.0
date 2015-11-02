From: ssimran@broadcom.com (Simran Rai)
Date: Mon, 2 Nov 2015 14:11:22 -0800
Subject: [PATCH v2 0/2] Add audio support for Broadcom Cygnus SoC
Message-ID: <1446502284-23907-1-git-send-email-ssimran@broadcom.com>
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

repo: https://github.com/Broadcom/cygnus-linux/tree/cygnus-sound-v2

Changes from v1:
  - Address code review comments. Fixed print format of type size_t and
    pointer.

Simran Rai (2):
  dt-bindings: sound: Add DT bindings for Broadcom Cygnus audio
  VOIP-5227 Add Broadcom Cygnus audio driver.

 .../bindings/sound/brcm,cygnus-audio.txt           |   63 +
 sound/soc/bcm/Kconfig                              |   18 +
 sound/soc/bcm/Makefile                             |    5 +
 sound/soc/bcm/cygnus-pcm.c                         |  903 ++++++++++++
 sound/soc/bcm/cygnus-ssp.c                         | 1532 ++++++++++++++++++++
 sound/soc/bcm/cygnus-ssp.h                         |  129 ++
 6 files changed, 2650 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
 create mode 100644 sound/soc/bcm/cygnus-pcm.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.h

-- 
1.7.9.5
