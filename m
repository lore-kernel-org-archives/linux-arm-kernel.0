From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Thu, 24 Nov 2016 23:37:51 +0530
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161124173532.GH14217@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
 <20161123191621.GD14217@n2100.armlinux.org.uk>
 <20161124172535.GA3524@afzalpc>
 <20161124173532.GH14217@n2100.armlinux.org.uk>
Message-ID: <20161124180751.GA5258@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 24, 2016 at 05:35:32PM +0000, Russell King - ARM Linux wrote:

> Right, so Freescale's iMX6, RAM starts at 0x10000000, so when building
> for noMMU, you need to specify DRAM_START as 0x10000000 and DRAM_SIZE
> to be the appropriate size of RAM.

Hmm.., i had thought that Vybrid's memory mappings starts from
0x80000000 (same TI Sitara's), just rechecked the older boot logs of
Vybrid & Data manual, it seems it is @0x80000000, probably iMX6 has a
different map.

> Also note that Cortex-A class CPUs don't perform well with the MMU
> off, because you can't enable the data cache - and you must have the
> data cache enabled for SMP to be functional, and it's also required
> for exclusives to work.

Yes, was aware of the performance degradation due to disabled dcache.

Here the platforms at my disposal are all single core - vf610, am335x
& am437x (though strictly speaking 2 of them are ARM SMP
configurations, but with number of cores as 1). Seems at least from
SMP pov, not expecting issues as they are single core (SMP disabled
kernel with MMU enabled works on those)

> There's also some cases where "Device, non-shared" must be used to
> access some devices, which can only be done with the MMU enabled.

Thanks for your valuable feedbacks.

Regards
afzal
