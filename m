From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 30 Mar 2015 20:16:22 -0700
Subject: [PATCH 0/2] Cygnus Audio Driver
Message-ID: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please provide comments on the initial version of this driver.

This patchset contains the devicetree bindings and core audio driver
for the Cygnus SoC.

There is an open question on how to fit this driver into the clock
framework (if at all).

The audio PLL is embedded in the audio block and only used
by the audio block. The audio PLL registers are also in the middle of 
the audio register map.

In addition, the audio PLL is adjustable to less than 1 Hz.
The existing clock driver framework does not provide a mechanism to take
advantage of the resolution of the hardware.

Can the audio PLL remain within the audio driver and/or any modifications
required?

Lori Hikichi (2):
  ASoC: cygnus-audio: adding device tree bindings
  ASoC: add core audio driver for Broadcom Cygnus SOC.

 .../bindings/sound/brcm,cygnus-audio.txt           |   68 +
 sound/soc/bcm/Kconfig                              |   11 +
 sound/soc/bcm/Makefile                             |    5 +-
 sound/soc/bcm/cygnus-pcm.c                         |  918 +++++++++++
 sound/soc/bcm/cygnus-pcm.h                         |   45 +
 sound/soc/bcm/cygnus-ssp.c                         | 1613 ++++++++++++++++++++
 sound/soc/bcm/cygnus-ssp.h                         |   84 +
 7 files changed, 2743 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
 create mode 100644 sound/soc/bcm/cygnus-pcm.c
 create mode 100644 sound/soc/bcm/cygnus-pcm.h
 create mode 100644 sound/soc/bcm/cygnus-ssp.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.h

-- 
2.3.3
