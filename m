From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Sep 2013 09:18:22 -0700
Subject: [PATCH v2 3/9] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
In-Reply-To: <20130920154406.GV26101@radagast>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <1376561909-4406-4-git-send-email-rogerq@ti.com>
 <20130920154406.GV26101@radagast>
Message-ID: <20130920161822.GR9994@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130920 08:52]:
> Hi,
> 
> On Thu, Aug 15, 2013 at 01:18:23PM +0300, Roger Quadros wrote:
> > The platform data bits can be inferred from the other members of
> > struct usbhs_phy_data. So get rid of the platform_data member.
> > 
> > Build the platform data for the PHY device in usbhs_init_phys() instead.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Tony, do I get your Acked-by here and all following arch/arm/mach-omap2*
> patches in this series ?

If you can merge just this series without the .dts changes
into an immutable topic branch against let's say v3.12-rc2
when it comes out, then yes I can ack them:

Acked-by: Tony Lindgren <tony@atomide.com>

That way I can also pull in the topic branch as needed to
avoid self inflicted merge conflicts ;) And Benoit can
set up a separate .dts branch based on your branch to make
sure the dependencies are in place before merging that one
upstream.

Regards,

Tony
