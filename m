From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 14:10:05 +0000
Subject: [PATCH 04/16] ARM: imx: move platform_data definitions
In-Reply-To: <Pine.LNX.4.64.1209111538000.22084@axis700.grange>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-4-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.64.1209111538000.22084@axis700.grange>
Message-ID: <201209111410.05698.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Guennadi Liakhovetski wrote:
> Hi Arnd
> 
> It probably wouldn't be very difficult to also include 
> arch/arm/plat-mxc/include/mach/ipu.h in this your patch, but you can also 
> leave it for later. Just to make sure it's not something that would make 
> your future patching more complicated.
> 

For now, I've done only the straight renames but left the ones that looked
like they need more complex changes of any sort. Looking at ipu.h, it seems
that this header file defines data that is used inside of the driver but not
in the platform device definition, so we'd need to split it up and move
the part that is only used inside of the driver into a different place.

Of course, I could alo be mistaken and not have realized that actually all
of this file is platform data.

	Arnd
