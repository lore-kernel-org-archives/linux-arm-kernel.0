From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 5 Aug 2011 22:22:54 +0800
Subject: [PATCH v4 0/7] ARM: mx28: add usb host function
In-Reply-To: <20110805130301.GG31404@pengutronix.de>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
	<97D3A72708D04647A5AC84A04996E5B516A392@039-SN1MPN1-006.039d.mgd.msft.net>
	<20110805130301.GG31404@pengutronix.de>
Message-ID: <20110805142252.GA12405@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 03:03:01PM +0200, s.hauer at pengutronix.de wrote:
> On Fri, Aug 05, 2011 at 07:53:21AM +0000, Lin Tony-B19295 wrote:
> > Any comments for the patch series?
> 
> Yes. The way you handle the USB phys is totally inacceptable. Please
> understand that there are *two* devices, one is the ehci core and the
> other is the associated phy.
> 
> You need to register the phy as a platform device, the corresponding
> driver then has to register the phy using some kind of usb_transceiver_register().
> On the ehci side the mxc-ehci driver has to find its phy using
> usb_get_transceiver().
> 
> Note that the infrastructure needed for this is not in the kernel, but
> there are patches recently posted on linux-usb:
> 
> http://www.spinics.net/lists/linux-usb/msg50148.html
> 
> Sascha
> 
I have discussed with Heikki, his framework is good, it saperates phys from
otg driver, so phy's utilities can be called at both otg and
device only mode, besides it can support usb charger better.

So, do we pause i.mx28 usb's upstream until Heikki's otg modification in
master, or just do thing like ulpi.c?

> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
