From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 13:59:23 +0000
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <20120613133938.GV12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <20120613120208.GN12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E2F@DBDE01.ent.ti.com>
 <20120613133938.GV12766@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998F56@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 13, 2012 at 19:09:38, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120613 06:10]:
> > On Wed, Jun 13, 2012 at 17:32:09, Tony Lindgren wrote:

> > Do you mean that gpmc driver should have the capability to calculate peripheral
> > timings at runtime based on frequency ?, I am not sure how this can be handled
> > by gpmc driver as calculation for different peripherals are done in different
> > way, requiring gpmc driver to know about connected peripheral, that would imply
> > that gpmc driver would not be peripheral agnostic.
> > 
> > Or else some sort of a callback to be used ?
> 
> Oops yeah right, we have some platform_retime functions that are in the
> driver platform init code. It would be best that the drivers can do the
> recalculation with no platform init code callbacks needed.

Other than using a platform callback, I am not getting any idea as of now,
how this can be achieved, let me think over it, if you have any suggestions
on ways to deal it, please let me know.

>  
> > Out of the 20,14 are depending on bootloader, both omap3evm & beagle has been
> > converted to utilize runtime calculation, but for other 12 boards, first
> > we need to get values used by bootloader (those include peripherals that doesn't
> > have gpmc-* helpers), then derive it based on expression, after that only, we
> > will have information to achieve it and those are the ones that I do not
> > have access to.
> 
> It's OK to use fixed timings as long as we disable L3 scaling. Some of
> these values we'll probably never be able to calculate dynamically.

Ok

Regards
Afzal
