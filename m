From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 1 Nov 2013 15:04:47 +0800
Subject: No subject
Message-ID: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

This patch series is mostly Freescale's SAI SoC Digital Audio Interface driver implementation. And the implementation is only compatible with device tree definition.

This patch series is based on linux-next and has been tested on Vybrid VF610 Tower board using device tree.

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
