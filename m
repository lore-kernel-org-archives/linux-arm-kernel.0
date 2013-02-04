From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Feb 2013 09:22:00 -0800
Subject: [PATCH v4 4/4] drivers: usb: start using the control module driver
In-Reply-To: <20130204155300.GC18237@arwen.pp.htv.fi>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-5-git-send-email-kishon@ti.com>
 <20130125102700.GO15886@arwen.pp.htv.fi>
 <20130201191424.GQ22517@atomide.com>
 <20130204155300.GC18237@arwen.pp.htv.fi>
Message-ID: <20130204172200.GM22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130204 07:57]:
> Hi,
> 
> On Fri, Feb 01, 2013 at 11:14:24AM -0800, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [130125 02:30]:
> > > Hi,
> > > 
> > > On Fri, Jan 25, 2013 at 03:54:00PM +0530, Kishon Vijay Abraham I wrote:
> > > > Start using the control module driver for powering on the PHY and for
> > > > writing to the mailbox instead of writing to the control module
> > > > registers on their own.
> > > > 
> > > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++
> > > >  Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
> > > >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 ----
> > > 
> > > I'm taking this patch but I'm leaving out the omap_hwmod_44xx_data.c
> > > change just to kill dependency. Can you send that single change as a
> > > separate patch which Tony can queue ?
> > 
> > For the USB patches, please also leave out patches touching
> > arch/arm/mach-omap2/devices.c. Those are almost guaranteed to
> > cause pointless merge conflicts with other branches.
> > 
> > I suggest you set up few immutable branches:
> > 
> > 1. Minimal platform_data changes for all your USB changes
> > 
> > This should contain include/linux/platform_data changes and
> > changes to arch/arm/*omap* so me and Paul can merge it in too
> > to avoid merge conflicts.
> > 
> > 2. The rest of the driver/usb changes
> > 
> > This can then be based on #1 branch above.
> > 
> > 3. Changes for the .dts files for Benoit
> > 
> > These can be queued separately from #1 and #2 above.
> 
> I'm done with all USB stuff for this merge window. The patches which I
> didn't take have no dependencies on any drivers/ part. You can easily
> queue this through your tree.

Sorry with a huge pile of USB patches being posted I have no idea at
this point which USB related patches for arch/arm/*omap* have no
dependencies to the USB driver changes.

So I suggest that you, Kishon and Roger figure it out and put together
a pull request for me against v3.8-rc6 for the patches I should merge.

Regards,

Tony
