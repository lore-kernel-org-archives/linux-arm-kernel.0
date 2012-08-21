From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Aug 2012 12:37:24 +0200
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120821114630.545fb771@skate>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120816132839.GO22226@titan.lakedaemon.net>
 <20120816183708.GT22226@titan.lakedaemon.net>
 <20120817152156.4d91ba16@skate>
 <20120819012303.GX22226@titan.lakedaemon.net>
 <20120821114630.545fb771@skate>
Message-ID: <CABJ1b_RVaSjsneDCvejSMot0ZHDr1dmeroVRDUNMF2y83UGXNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/12, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Or maybe, you want me to change the "depends on PLAT_ORION" of the
> Orion NAND driver to "depends on PLAT_ORION_LEGACY" so that this driver
> cannot be selected for now with mach-mvebu? As part of the PLAT_ORION
> -> PLAT_ORION_LEGACY conversion, it would make sense. Of course, I
> would do it for the other drivers as well (crypto, dma, etc.).

Thomas,

I have reworked addr-map to allow for both Armada 370/XP and Orion SoCs
merging into mach-mvebu. Instead of reusing PLAT_ORION this is totally
independent but reusing as much code as possible. I can send it hopefully
today if I get it cleaned up. I also have irq-mvebu, irq-orion, and time-mvebu
patches that merge code. With that patches booting Dove into mach-mvebu
works until DMA kicks in because XOR hasn't event touched for DT support
and is still missing.

Armada 370/XP should still work as they do with current patches in for-3.7
with little changes in DT. But that of course must be tested by you.

Sebastian
