From: songjun.wu@atmel.com (Songjun Wu)
Date: Mon, 28 Sep 2015 13:14:35 +0800
Subject: [RESEND PATCH v2 0/2] ASoC: atmel-classd: add driver for Atmel CLASSD
Message-ID: <1443417278-19657-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Audio Class D Amplifier driver includes two parts.
1) Driver code to implement the Audio Class D Amplifier function.
2) Device tree binding document, it describes how to add the Audio
   Class D Amplifier in device tree.

Changes in v2:
- Change the "Mono", "Swap" and "Deemphasis" controls to
  "Mono Switch", "Swap Switch" and "Deemphasis Switch".
- Merge "EQ Bass", "EQ Medium" and "EQ Treble" controls
  into one "EQ" control.
- Change the "single-ended" and "differential" to
  "Single ended", "Differential".
- Merge separate left and right controls into one single
  stereo control.
- Add a warning if the user trys to specify an invalid
  value in function "atmel_classd_codec_probe".
- Use the "dev_get_regmap()" in function
  "atmel_classd_codec_get_remap".
- Check for errors when invoking the "clk_prepare_enable".
- Remove the "dev_info" in function "atmel_classd_probe".
- Add some code to create a sound card in function
  "atmel_classd_probe".
- Remove the DT node "Sound" and the related code.
- Delete the device node "Sound" in dts.

Songjun Wu (2):
  ASoC: atmel-classd: add the Audio Class D Amplifier
  SoC: atmel-classd: DT binding for Class D audio amplifier driver

 .../devicetree/bindings/sound/atmel-classd.txt     |   52 ++
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-classd.c                     |  680 ++++++++++++++++++++
 sound/soc/atmel/atmel-classd.h                     |  120 ++++
 5 files changed, 863 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
 create mode 100644 sound/soc/atmel/atmel-classd.c
 create mode 100644 sound/soc/atmel/atmel-classd.h

-- 
1.7.9.5
