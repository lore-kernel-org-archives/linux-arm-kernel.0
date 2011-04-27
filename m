From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 27 Apr 2011 23:20:18 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <F6E90395B84D4E9FA9497247841035FC@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<20110425212056.GA29313@kroah.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CAE36A6@dbde02.ent.ti.com>
	<20110426124519.GC5977@suse.de>
	<35F38DB5B5C4408EA80AF0DB8A6FA178@subhasishg>
	<B85A65D85D7EB246BE421B3FB0FBB593024CBA9959@dbde02.ent.ti.com>
	<F6E90395B84D4E9FA9497247841035FC@subhasishg>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CBA9B31@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Subhasish,

On Wed, Apr 27, 2011 at 18:45:06, Subhasish Ghosh wrote:
>  >> >>The driver should probably just get sram
> >> >> space through platform data so that it doesn't depend on the
> >> >> platform specific sram allocation function.
> >>
> >> Are you suggesting that I go back to that implementation.
> >
> > No, the platform code should use the SRAM allocator and
> > pass on the allocated memory to the driver.
> 
> SG - So, should I call the sram_alloc() in the platform setup function. 

Can you please shed some light on how SRAM
is being used in the driver? Looking at the
driver, it looks like it is used as a shared
buffer between the PRU firmware and kernel.

If yes, how do you cope with dynamic allocation
of SRAM? That is, how do you inform the firmware
what portion of SRAM has been allocated to the
driver?

Also, usage of SRAM is not required for basic driver
function, correct? So, a platform which does not
have SRAM to spare for this driver could still have
a portion of SDRAM/DDR allocated to be used as the
shared buffer? I guess SRAM was used only for lower
access times. But it should still be possible to
sustain lower baudrates with SDRAM/DDR?

Thanks,
Sekhar
