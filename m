From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 Feb 2015 07:38:09 -0800
Subject: 3.20-rc0 breaks nfsroot over usb
In-Reply-To: <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
References: <20150217185518.GA3825@amd> <20150226221950.GC10204@amd>
 <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <20150227153809.GS11056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [150226 15:06]:
> Hi,
> 
> On Thu, Feb 26, 2015 at 11:19:50PM +0100, Pavel Machek wrote:
> > Ok, it seems that new config dependencies broke my kconfig. These will
> > not be enabled if you just to make oldconfig; you want to make sure
> > they are on.
> > 
> >  OMAP2430 and onwards (USB_MUSB_OMAP2PLUS) [N/m/y] (NEW)
> > TWL4030 USB Transceiver Driver (TWL4030_USB) [N/m/y/?] (NEW)
> 
> Yes, also other users have reported "USB breakage" with 4.0-rc1 on N900
> etc caused by this.
> 
> Commit fbba7db3990cb707ff91cd6507d53a0a730afe97 (usb: musb:
> add omap-control dependency) changed USB_MUSB_OMAP2PLUS to depend
> on OMAP_CONTROL_PHY but that seems to be wrong at least for OMAP3.
> omap_control_phy.h provides dummy functions when it's not enabled.
> So there should be no dependency.

I guess the solution would be to make drivers/phy handle whatever
omap_control_usb_set_mode is doing in a generic way.

Regards,

Tony
