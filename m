From: songjun.wu@atmel.com (Songjun Wu)
Date: Thu, 17 Dec 2015 17:49:58 +0800
Subject: [RESEND PATCH v2 0/2] ASoC: atmel-pdmic: add driver for Atmel PDMIC
Message-ID: <1450345800-21299-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pulse Density Modulation Inteface Controller driver
includes two parts.
1) Driver code to implement the PDMIC function.
2) Device tree binding documentation, it describes how to add
   the PDMIC in device tree.

Changes in v2:
- Remove the function 'atmel_pdmic_codec_get_remap', since the regmap
  is initialized in the core.
- Replace 'if' with 'switch' in function 'atmel_pdmic_codec_dai_hw_params'.
- Fix the coding style issue in function 'atmel_pdmic_dt_init',
  'atmel_pdmic_interrupt','pdmic_put_mic_volsw', 'atmel_pdmic_codec_probe',
  'pdmic_get_mic_volsw' and 'atmel_pdmic_codec_dai_hw_params'.

Songjun Wu (2):
  ASoC: atmel-pdmic: add the Pulse Density Modulation Interface
    Controller
  ASoC: atmel-classd: DT binding for PDMIC driver

 .../devicetree/bindings/sound/atmel-pdmic.txt      |   55 ++
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-pdmic.c                      |  738 ++++++++++++++++++++
 sound/soc/atmel/atmel-pdmic.h                      |   80 +++
 5 files changed, 884 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt
 create mode 100644 sound/soc/atmel/atmel-pdmic.c
 create mode 100644 sound/soc/atmel/atmel-pdmic.h

-- 
1.7.9.5
