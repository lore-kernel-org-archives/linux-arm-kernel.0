From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 29 Nov 2011 17:00:13 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
In-Reply-To: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20111129170013.GD2829@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 03:11:08PM +0000, Pawel Moll wrote:
> Hi All,
> 
> Another, hopefully close to the final, version of the series...
> 
> Changes from v2:
> 
> * new patch adding ENDPROC at the end of arch/arm/plat-versatile/headsmp.S
>   and removing use of BSYM() realview and vexpress platform SMP calls
> 
> * updated binding documentation according to Dave's comments
> 
> * changed motherboard labels prefix from mb_ to v2m_ (to be
>   consistent across code and DT files)
> 
> * reworked v2m timer initialization (again) so no #ifdefs are required
>   in non-DT code
> 
> * renamed (to vendor- and platform-specific "arm,v2m-timer") and moved
>   (to vexpress-v2m*.dtsi files) timer DT alias, as it is actually
>   motherboard specific and the tile DTS shouldn't have to care;
>   documentation updated accordingly
> 
> Tested on V2P-CA9 with ATAGs and DT and on V2P-CA5s with DT.
> 
> Previous version has been also tested by Ryan Harkin and
> provisionally acked by Rob Herring.
> 
> Thanks for all your help, especially to Dave for his continuous support!

I'm trying to build... what tree are you basing on?

With v3.2-rc3 or next, I get OF header failures like the following:

arch/arm/kernel/devtree.c: In function ?arm_dt_memblock_reserve?:
arch/arm/kernel/devtree.c:41:7: error: ?initial_boot_params? undeclared (first use in this function)
arch/arm/kernel/devtree.c:41:7: note: each undeclared identifier is reported only once for each function it appears in

[...]

arch/arm/mach-vexpress/v2m.c: In function ?v2m_dt_scan_memory_map?:
arch/arm/mach-vexpress/v2m.c:529:2: error: implicit declaration of function ?of_get_flat_dt_prop?
arch/arm/mach-vexpress/v2m.c:529:7: warning: assignment makes pointer from integer without a cast

arch/arm/mach-vexpress/v2m.c: In function ?v2m_dt_map_io?:
arch/arm/mach-vexpress/v2m.c:538:2: error: implicit declaration of function ?of_scan_flat_dt?

Cheers
---Dave
