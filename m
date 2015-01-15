From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Jan 2015 14:50:42 +0100
Subject: [PATCH v2 0/2] ARM: shmobile: r8a73a4: Correct mask for GIC PPI
 interrupts
Message-ID: <1421329844-19707-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series corrects the masks in the second interrupt cells for
Private Peripheral Interrupts in dtsi files for members of the
shmobile family of SoCs containing big.LITTLE configurations.

This mask should reflect the actual number of CPU cores the interrupt
is wired too.  Hence on big.LITTLE configurations with four Cortex-A15
cores and four Cortex-A7 cores, like r8a7790 and r8a73a4, it should be
"GIC_CPU_MASK_SIMPLE(8)", not "GIC_CPU_MASK_SIMPLE(4)".

Note that incorrect masks for GIC PPI interrupts are not limited to
shmobile. Presumably the interrupt specifiers got copied around a lot,
cfr. the proliferation of "GIC_CPU_MASK_SIMPLE(4)" (and the older
hardcoded "0xf0x" variant) in various dtsi files, not always limited to
quad-core CPUs.

Changes compared to v1:
  - Dropped patches for r8a7791 and r8a7794 that have been applied by
    Simon,
  - Dropped RFC status after receiving confirmation from Liviu Dudau.

This was untested on real hardware.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: r8a73a4: Correct mask for GIC PPI interrupts
  ARM: shmobile: r8a7790: Correct mask for GIC PPI interrupts

 arch/arm/boot/dts/r8a73a4.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7790.dtsi | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
