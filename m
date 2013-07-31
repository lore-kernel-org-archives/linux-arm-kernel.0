From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 31 Jul 2013 13:20:34 +0800
Subject: [PATCH 1/2] pinctrl: imx: Add exception hook for select input
In-Reply-To: <20130730083803.GF12382@S2101-09.ap.freescale.net>
References: <1375152857-32177-1-git-send-email-peter.chen@freescale.com>
 <20130730075018.GD12382@S2101-09.ap.freescale.net>
 <20130730080028.GA8540@nchen-desktop>
 <20130730083803.GF12382@S2101-09.ap.freescale.net>
Message-ID: <20130731052031.GA19098@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 04:38:05PM +0800, Shawn Guo wrote:
> On Tue, Jul 30, 2013 at 04:00:29PM +0800, Peter Chen wrote:
> > I searched the RM, this is the only one. If you don't think we need
> > to consider if it will occur in the future, I am OK to move it at machine
> > code, but every mx6q board need it if it does not use default select input
> > value.
> 
> Yes, maybe you can put it into imx6q_usb_init() with
> if (IS_ENABLED(CONFIG_USB_OTG)) protect.

I misunderstood it.  As it varies from board to board, we can not nicely
handle it in mach-imx6q.c.  I have some other idea to solve the problem,
and will cook up a patch to demonstrate it.

Shawn
