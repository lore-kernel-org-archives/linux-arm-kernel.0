From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Apr 2012 12:07:52 +0300
Subject: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <4F87240F.6060902@ti.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
 <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
 <20120412030044.GA26236@kroah.com> <4F867A95.9030104@ti.com>
 <20120412131045.GB31384@kroah.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E95947E@DQHE04.ent.ti.com>
 <alpine.DEB.2.00.1204121053570.29473@utopia.booyaka.com>
 <4F87240F.6060902@ti.com>
Message-ID: <20120413090750.GM4343@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 08:50:55PM +0200, Cousson, Benoit wrote:
> + Felipe,
> 
> Hi Paul,
> 
> On 4/12/2012 7:00 PM, Paul Walmsley wrote:
> >Hi
> >
> >On Thu, 12 Apr 2012, Mohammed, Afzal wrote:
> >
> >>On Thu, Apr 12, 2012 at 18:40:45, Greg KH wrote:
> >>>On Thu, Apr 12, 2012 at 12:17:49PM +0530, Santosh Shilimkar wrote:
> >>>>I was hoping that we will have some thing like drivers/memory/*
> >>>>but since it doesn't exist, we used drivers/misc.
> >>>
> >>>Why not create it?  I have no objection to that, it makes it more
> >>>obvious as to what this really is.
> >>
> >>There is another memory controller used in a few TI SoCs,
> >>namely GPMC [1], do you prefer having it too there.
> >>
> >>As of now it is not a driver, platform code handles GPMC, a patch
> >>series for converting it into a driver (but still residing in
> >>platform folder) was sent a few days back [2,3].
> >
> >Probably the GPMC driver should go into a slightly different place than
> >SDRC/EMIF.
> >
> >GPMC is actually a general-purpose parallel bus driver.  It's used to
> >interface Ethernet controllers, UARTs, FPGAs, NAND/NOR flash, SRAM, etc.
> >It cannot be used to control DRAM, at least not without a separate DRAM
> >controller chip.
> >
> >SDRC/EMIF are both DRAM controllers.  That's all they do.  They can't be
> >used to control anything else.  They implement DRAM refresh, etc.
> 
> The LPDDR2 spec does consider as well NVM (Non Volatile Memory), so I
> think we should stick to driver/memory for EMIF.
> 
> >So perhaps something like drivers/memory/dram/ for the SDRAM controllers,
> >and maybe drivers/memory/ for the GPMC?
> 
> In fact Felipe was considering something else for that kind of
> general purpose bus driver like GMPC, C2C and LLI...
> 
> ... But I do not remember the name :-)

the name matters very little :-) But the idea was to avoid writing yet
another bus driver and just use the platform_bus instead. We would do
all the channel/port setup before hand and far-end device driver
wouldn't have to know if it's integrated into the SoC or plugged though
LLI/C2C/GPMC.

>From the driver's perspective it would look the same.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/f54b34a4/attachment.sig>
