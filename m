From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Aug 2012 13:50:45 +0200
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <CABJ1b_RVaSjsneDCvejSMot0ZHDr1dmeroVRDUNMF2y83UGXNA@mail.gmail.com>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120816132839.GO22226@titan.lakedaemon.net>
 <20120816183708.GT22226@titan.lakedaemon.net>
 <20120817152156.4d91ba16@skate>
 <20120819012303.GX22226@titan.lakedaemon.net>
 <20120821114630.545fb771@skate>
 <CABJ1b_RVaSjsneDCvejSMot0ZHDr1dmeroVRDUNMF2y83UGXNA@mail.gmail.com>
Message-ID: <20120821135045.58e2a633@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 21 Aug 2012 12:37:24 +0200,
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :

> I have reworked addr-map to allow for both Armada 370/XP and Orion SoCs
> merging into mach-mvebu. Instead of reusing PLAT_ORION this is totally
> independent but reusing as much code as possible. I can send it hopefully
> today if I get it cleaned up. I also have irq-mvebu, irq-orion, and time-mvebu
> patches that merge code. With that patches booting Dove into mach-mvebu
> works until DMA kicks in because XOR hasn't event touched for DT support
> and is still missing.
> 
> Armada 370/XP should still work as they do with current patches in for-3.7
> with little changes in DT. But that of course must be tested by you.

Ok, I will look at your code, but the purpose of
PLAT_ORION/PLAT_ORION_LEGACY was not only to re-use the addr-map code,
but also to allow drivers to access the header files containing their
platform_data structure and other stuff (i.e, all the header files from
arch/arm/plat-orion/include/). How do you handle this problem if
MACH_MVEBU is not a PLAT_ORION platform?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
