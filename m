From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Tue, 17 Dec 2013 11:24:37 +0800
Subject: [PATCHv3 0/8] ALSA: Add SAI driver and enable SGT15000 codec
Message-ID: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series is mostly Freescale's SAI SoC Digital Audio Interface
driver implementation. And the implementation is only compatible with
device tree definition.

This patch series is based on linux-next and has been tested on Vybrid
VF610 Tower board using device tree.

Changed in v3:
- Add big-endian mode support.
- Revise some commit comments, coding styles,etc.
- Keep header files ordered by alphabet,etc.
- Add MODULE_ALIAS("platform:fsl-sai") for SAI driver.
- Rename the files to be in a same pattern with the existed ones.
- Remove some not useful functions or code.
- Only enable the clock while the device is in active use.
- Revise one error message according to Bill.

Changed in v2:
- Use default settings for the generic dmaengine PCM driver.
- Separate receive and transmit setting in most functions, but some couldn't for the HW limitation.
- Drop some not reduntant code.
- Use devm_snd_soc_register_component() instead of snd_soc_register_component().
- Use devm_snd_soc_register_card() instead of devm_snd_soc_register_card().
- Adjust the code sentences sequence.
- Make the namespacing consistent.
- Rename CONFIG_SND_SOC_FSL_SGTL5000 to CONFIG_SND_SOC_FSL_SGTL5000_VF610.
- Drop some meaningless lines.
- Rename the binding document file.

Added in v1:
- Add SAI SoC Digital Audio Interface driver.
- Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
- Enables SAI ALSA SoC DAI device for Vybrid VF610 TOWER board.
- Add device tree bindings for Freescale SAI.
- Revise the bugs about the sgt15000 codec.
- Add SGT15000 based audio machine driver.
- Enable SGT15000 codec based audio driver node for VF610.
- Add device tree bindings for Freescale VF610 sound.
