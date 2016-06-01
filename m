From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 20:35:21 +0300
Subject: [PATCH 0/5] ARM: OMAP5: add support for fref-xtal-clk
Message-ID: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

fref_xtal_clk is a clock going out from omap5 chip, sourced directly
from the system oscillator. fref_xtal_clk can be used to provide a
high frequency clock to some external component, in omap5 setups,
typically twl6040 audio chip.

Testing done (number of boards on the test farm are currently out of order):

am335x-evm      : BOOT FAIL!
am335x-evmsk    : boot
am37x-evm       : boot
am437x-sk       : boot
am43x-epos-evm  : boot
am437x-gp-evm   : boot
am57xx-evm      : boot
omap3-beagle-xm : boot
am335x-boneblack: boot
am335x-bone     : boot
dra72x-evm      : boot
dra7xx-evm      : boot
omap5-uevm      : boot

On omap5, also verified that the new clock node appears under debugfs.

am335x-evm failure is due to inability to mount NFS rootfs on the board
in question the boot goes fine until that. There are some issues with
the u-boot installed on this board currently.

-Tero
