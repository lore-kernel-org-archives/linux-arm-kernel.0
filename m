From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 28 Nov 2011 08:08:21 +0100
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111128070821.GD3869@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On Mon, Nov 28, 2011 at 03:06:48AM +0000, Chen Peter-B29397 wrote:
> Tony Lin has submitted Freescale mx28 USB Patch at August (See:
> http://www.spinics.net/lists/linux-usb/msg50201.html), but it hasn't
> been accepted. I would like to re-submit mx28 usb patches, before
> that, I would like get some suggestion from you. I think your
> suggestion will also be benefit for coming mx53, mx50 and mx6q's
> submission.
>
> All Recently Freescale SoC's USB controller are the same, they are
> mx23, mx25, mx28, mx31, mx35, mx37, mx50, mx51, mx53, and mx6.

We have recently worked on the USB device part of the MX28, and it
turned out that it is an Synopsys IP core and the driver for that is
ci13xxx_udc.c. Marc Kleine-Budde has sent patches to make it more
generic and fix several locking issues, so it currently works up to a
certain degree on MX28.

The whole ci13xxx issue is a huge mess: there are 4 different drivers
for this IP core in the kernel, all in different states.

So my suggestion is:

- help to mainline Heikki's patches (port your platform, help testing)
- let's improve the ci13xxx driver for i.MX.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
