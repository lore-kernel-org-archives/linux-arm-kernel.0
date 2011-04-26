From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 26 Apr 2011 12:21:04 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <20110425212056.GA29313@kroah.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<20110425212056.GA29313@kroah.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CAE36A6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 02:50:56, Greg KH wrote:
> On Fri, Apr 22, 2011 at 05:38:26PM +0530, Subhasish Ghosh wrote:
> > This patch adds support for the TTY compliant
> > Soft-UART device emulated on PRUSS.
> > 
> > This patch depends on:
> > davinci: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS.
> >             https://patchwork.kernel.org/patch/615681/

This is already in mainline. Plus this patch
doesn't really seem to depend on this commit.

> > davinci: changed SRAM allocator to shared ram.
> >             https://patchwork.kernel.org/patch/549351/

There should be no build time dependency with this patch
(the above patch just changes which pool of SRAM the
allocation happens from)

But, this brings out an important dependency of the patch
calling platform specific sram allocator functions. There
has been SRAM allocator consolidation work done by Russell
and as a result the SRAM allocator API for DaVinci will
actually change. The driver should probably just get sram
space through platform data so that it doesn't depend on the
platform specific sram allocation function.

> 
> Who is going to be applying these patches to the tree?
> 
> Should this driver go through a davinci subtree because of these
> dependancies?

No, driver and platform changes can be merged separately
if the above aspect is taken care of. Russell has been
pushing back on merging driver patches through his tree
unless absolutely required.

Thanks,
Sekhar
