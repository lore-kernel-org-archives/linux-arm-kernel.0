From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 9 Aug 2013 19:56:11 +0200
Subject: [PATCH 1/7] gpio: mxc: Support initialization as subdevice
In-Reply-To: <CACRpkda+oLASgNkCWD5n9f6a2ECvvb95wJoEvqXF3ebeQu9Spw@mail.gmail.com>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-2-git-send-email-mpa@pengutronix.de>
 <CACRpkda+oLASgNkCWD5n9f6a2ECvvb95wJoEvqXF3ebeQu9Spw@mail.gmail.com>
Message-ID: <20130809175611.GH13664@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 09:03:36PM +0200, Linus Walleij wrote:
> On Fri, Aug 2, 2013 at 12:38 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > On imx27 and imx21, there is no clear seperation between iomux control
> > registers and GPIO data registers. For easier pingroup definitions, the
> > gpio drivers will be initialized as subnodes of the iomux controller. It
> > is necessary to share the registers between iomux and gpio.
> >
> > This patch adds support to pass a register memory region via platform
> > data.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> I think you have misunderstood that it is perfectly legal for
> several drivers to remap the same memory range. I think
> you should just drop this quirk and happily remap the memory
> in both drivers.

Yes, thank you, I didn't know that is possible. Fixed.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
