From: durgesh.pattamatta@nxp.com (Durgesh Pattamatta)
Date: Thu, 12 Nov 2009 03:10:33 +0100
Subject: Submitting patches for new LPC313x machine support
Message-ID: <A2403073D589354FB342892C1CB8F90607DC7C8FA7@EU1RDCRDC1WX029.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

We would like to submit patches to support our (NXP microcontrollers) new SoCs LPC313x/4x/5x.
Currently Embedded Artist's LPC3131 board is the widely available development
board for these chips. We have Linux 2.6.28.2 kernel running on this board and the
patches are distributed on our server http://www.standardics.nxp.com/support/software/lpc313x.bsp.linux/
and also through LTIB.

The variation between these SoCs are minor and hence we plan to have single
'mach-lpc313x' directory. Please let us know if it acceptable or do we need to
create "plat-lpc31xx" area?
Below is the brief list showing the difference between
these chips.

- LPC3131 = LPC3130 + extra 96KB of ISRAM. (LPC3130 has 96KB of ISRAM)
- LPC3141 = LPC3131 + speed enhancement (LPC3131 max. speed 180MHz while
   LPC3141 can run upto 270MHz) + One-time programmable polyfuses (this doesn't
effect kernel)
- LPC3143 = LPC3141 + secure boot (so no change to kernel code)
- LPC3152 = LPC3131 + analog die. The analog die has power management unit,
audio codec, battery charger. Since drivers for these analog components will be
in their respective driver directories mach area is unchanged.
- LPC3154 = LPC3152 + secure boot

Also we would greatly appreciate if you could guide/point us to any recent/good mach
submissions so that we could follow their procedure to split our patch accordingly.

We have used 'mach-lh7a40x' as an example in accessing registers. But other mach- use
readl()/writel() routines to access chip registers. Is 'mach-lh7a40x' technique acceptable?

Regards,
Durgesh
