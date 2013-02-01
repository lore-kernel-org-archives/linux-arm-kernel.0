From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 11:14:24 -0800
Subject: [PATCH v4 4/4] drivers: usb: start using the control module driver
In-Reply-To: <20130125102700.GO15886@arwen.pp.htv.fi>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-5-git-send-email-kishon@ti.com>
 <20130125102700.GO15886@arwen.pp.htv.fi>
Message-ID: <20130201191424.GQ22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130125 02:30]:
> Hi,
> 
> On Fri, Jan 25, 2013 at 03:54:00PM +0530, Kishon Vijay Abraham I wrote:
> > Start using the control module driver for powering on the PHY and for
> > writing to the mailbox instead of writing to the control module
> > registers on their own.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++
> >  Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 ----
> 
> I'm taking this patch but I'm leaving out the omap_hwmod_44xx_data.c
> change just to kill dependency. Can you send that single change as a
> separate patch which Tony can queue ?

For the USB patches, please also leave out patches touching
arch/arm/mach-omap2/devices.c. Those are almost guaranteed to
cause pointless merge conflicts with other branches.

I suggest you set up few immutable branches:

1. Minimal platform_data changes for all your USB changes

This should contain include/linux/platform_data changes and
changes to arch/arm/*omap* so me and Paul can merge it in too
to avoid merge conflicts.

2. The rest of the driver/usb changes

This can then be based on #1 branch above.

3. Changes for the .dts files for Benoit

These can be queued separately from #1 and #2 above.

Regards,

Tony
