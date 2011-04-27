From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 27 Apr 2011 16:49:02 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <35F38DB5B5C4408EA80AF0DB8A6FA178@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<20110425212056.GA29313@kroah.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CAE36A6@dbde02.ent.ti.com>
	<20110426124519.GC5977@suse.de>
	<35F38DB5B5C4408EA80AF0DB8A6FA178@subhasishg>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CBA9959@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 10:53:38, Subhasish Ghosh wrote:
> >> There should be no build time dependency with this patch
> >> (the above patch just changes which pool of SRAM the
> >> allocation happens from)
> >>
> >> But, this brings out an important dependency of the patch
> >> calling platform specific sram allocator functions. There
> >> has been SRAM allocator consolidation work done by Russell
> >> and as a result the SRAM allocator API for DaVinci will
> >> actually change.
> 
> I earlier had an implementation where I would get the sram memory addresses
> through the .resource structure and ioremap it in the driver.

This is wrong since it assumes the whole SRAM is available
for usage by your driver. We already have an allocator
for SRAM.

> 
> >>The driver should probably just get sram
> >> space through platform data so that it doesn't depend on the
> >> platform specific sram allocation function.
> 
> Are you suggesting that I go back to that implementation.

No, the platform code should use the SRAM allocator and
pass on the allocated memory to the driver.

Thanks,
Sekhar
