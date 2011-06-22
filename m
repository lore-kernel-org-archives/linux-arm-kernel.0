From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 23 Jun 2011 04:56:26 +0530
Subject: [PATCH 00/25 v2] Re-jig cpu_suspend for a saner calling convention
In-Reply-To: <20110622210147.GC9449@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<20110622210147.GC9449@n2100.arm.linux.org.uk>
Message-ID: <4E027A22.6020503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/23/2011 2:31 AM, Russell King - ARM Linux wrote:
> On Wed, Jun 22, 2011 at 04:08:16PM +0100, Russell King - ARM Linux wrote:
>> Tested on Assabet (SA1100) and 3430LDP only.
>
> Correction - because suspend only goes into retention mode, these
> changes have not been tested on the 3430.  Someone who knows what
> they're doing with the mega-complicated OMAPs (and so knows how to
> trigger the required modes to test these code paths) needs to test
> this.
>
> It will currently fail when trying to call cpu_resume() because we're
> trying the virtual address for that function, whereas it needs to be
> the physical address.  That's left as an exercise to solve (easiest
> way is probably to pass virt_to_phys(cpu_resume) into _omap_sram_idle
> and get it to save that away in SRAM.)
>
Firstly thanks for taking time to include OMAP this time. Even if the
changes are not tested, we can get them working with necessary fixes.

Have looked at your series briefly and have some comments for the same.
Am planning to test these patches, but it might take bit more time.

Will update the results as soon as I have them.

Regards
Santosh
