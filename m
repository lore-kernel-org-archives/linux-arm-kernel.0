From: gadiyar@ti.com (Anand Gadiyar)
Date: Thu, 17 Feb 2011 19:34:51 +0530
Subject: [PATCH 1/2] omap4: 4430sdp: drop ehci support
In-Reply-To: <20110217114916.GA24989@n2100.arm.linux.org.uk>
References: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
	<20110217114916.GA24989@n2100.arm.linux.org.uk>
Message-ID: <9384e5030701b4680b09f7ad49190054@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Feb 16, 2011 at 04:47:19PM +0530, Anand Gadiyar wrote:
> > Most revisions of the OMAP4 Blaze/SDP platform do not have
> > the EHCI signals routed by default. The pads are routed
> > for the alternate HSI functionality instead, and explicit
> > board modifications are needed to route the signals to
> > the USB PHY on the board.
> >
> > Also, turning on the PHY connected to the EHCI port causes
> > a board reboot during bootup due to an unintended short
> > on the rails - this affects many initial revisions of the
> > board, and needs a minor board mod to fix (or as a
> > workaround, one should not attempt to power on the
> > USB PHY).
>
> It's probably a good idea to put some comment in the code to that
> effect - people don't generally look at the history when adding new
> features.

I did part of this in patch 2/2.
I've muxed the pad in "safe mode" which turns off the output drivers
for the pad - so it can no longer drive a 1.

I've also placed a big warning above that line explaining why.

> It's probably also a good idea to claim the GPIO for the
> PHY power control and ensure that it's set to 'off' mode - that code
> can then be a placeholder for the comment.

This is a good idea too. Tony, if you concur, I'll go
respin this series.

- Anand
