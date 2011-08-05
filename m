From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Fri, 5 Aug 2011 15:03:01 +0200
Subject: [PATCH v4 0/7] ARM: mx28: add usb host function
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B516A392@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
	<97D3A72708D04647A5AC84A04996E5B516A392@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20110805130301.GG31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 07:53:21AM +0000, Lin Tony-B19295 wrote:
> Any comments for the patch series?

Yes. The way you handle the USB phys is totally inacceptable. Please
understand that there are *two* devices, one is the ehci core and the
other is the associated phy.

You need to register the phy as a platform device, the corresponding
driver then has to register the phy using some kind of usb_transceiver_register().
On the ehci side the mxc-ehci driver has to find its phy using
usb_get_transceiver().

Note that the infrastructure needed for this is not in the kernel, but
there are patches recently posted on linux-usb:

http://www.spinics.net/lists/linux-usb/msg50148.html

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
