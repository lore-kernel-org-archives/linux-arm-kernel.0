From: padma.v@samsung.com (Padmavathi Venna)
Date: Sat, 01 Dec 2012 15:37:25 +0530
Subject: [PATCH 0/2] ASoC: Samsung: Remove platform device support
Message-ID: <1354356447-16784-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung audio DMA device and machine device were getting registered as
platform devices with out having any real H/W peripherials associated
with them. With device tree support we can't add these platform devices
in the machine file. So Added basic device tree based look up for the
machine device.

The sole purpose of DMA platform device is to call the
"snd_soc_register_platform". So removed the pdev support in the DMA device
and each Samsung DAI now registers the ASoC 'platform' itself.

Padmavathi Venna (2):
  ASoC: Samsung: WM8994: Add basic device tree support for machine file
  ASoC: Samsung: Do not register samsung audio dma device as pdev

 sound/soc/samsung/dma.c         |   24 ++++++------------------
 sound/soc/samsung/dma.h         |    3 +++
 sound/soc/samsung/i2s.c         |    3 +++
 sound/soc/samsung/smdk_wm8994.c |   30 ++++++++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 20 deletions(-)

-- 
1.7.4.4
