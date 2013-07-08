From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon,  8 Jul 2013 15:29:48 +0200
Subject: [PATCH v2 0/5] Sound support for at91sam9x5-wm8731 based boards
Message-ID: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset add sound on the at91sam9x5ek board.
It's based on Nicolas Ferre's work in the 2.6.39 atmel patch for sam9x5:
https://github.com/linux4sam/linux-at91/commit/0aa157c9e71ccccf3abc30fa37eb5c95b392978d

It needs Bo Chen's patchset on the generic dmaengine (topic/atmel branch
on Mark's sound tree) and the SSC interrupts disabled (cf
http://www.spinics.net/lists/arm-kernel/msg256901.html)


Tested on at91sam9g35ek.

patches applies on next-20130708

[I let the original signed-off from Nicolas and Uwe in place, I don't
know if I should replace them by something like "originaly-signed-off-by"
since the code has been changed.]

[Sorry if it's too late for 3.11]

Changes from V1-RFC:
 * drop patches on SSC since Bo Chen already did the work
 * reorder patches to have the machine driver first
 * drop code already handled by the ASoC framework
 * drop unneeded SND_ATMEL_SOC_PDC config selection
 * use static snd_soc_card and  snd_soc_dai_link structures.

Best regards,
Richard.

Nicolas Ferre (1):
  sound: sam9x5_wm8731: machine driver for at91sam9x5 wm8731 boards

Richard Genoud (4):
  ARM: AT91: DTS: sam9x5: add SSC DMA parameters
  ARM: AT91: DTS: sam9x5ek: add WM8731 codec
  ARM: AT91: DTS: sam9x5ek: add sound configuration
  ARM: AT91: DTS: sam9x5ek: enable SSC

 arch/arm/boot/dts/at91sam9x5.dtsi   |    3 +
 arch/arm/boot/dts/at91sam9x5ek.dtsi |   27 +++++
 sound/soc/atmel/Kconfig             |   10 ++
 sound/soc/atmel/Makefile            |    2 +
 sound/soc/atmel/sam9x5_wm8731.c     |  206 +++++++++++++++++++++++++++++++++++
 5 files changed, 248 insertions(+)
 create mode 100644 sound/soc/atmel/sam9x5_wm8731.c

-- 
1.7.10.4
