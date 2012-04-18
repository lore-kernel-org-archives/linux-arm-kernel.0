From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 09:07:21 +0200
Subject: [PATCH 1/4] clk: select CLKDEV_LOOKUP for COMMON_CLK
In-Reply-To: <CAJOA=zMPqiH2fQJ5JWJ=COnju7Cmur6J2ATYUTcx41C4WMjFQQ@mail.gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-2-git-send-email-robherring2@gmail.com>
 <CAJOA=zMPqiH2fQJ5JWJ=COnju7Cmur6J2ATYUTcx41C4WMjFQQ@mail.gmail.com>
Message-ID: <20120418070721.GL3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 03:13:49PM -0700, Turquette, Mike wrote:
> On Mon, Apr 9, 2012 at 1:24 PM, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > Using the common clock infrastructure without the common clkdev code makes
> > little sense, so select CLKDEV_LOOKUP for COMMON_CLK.
> >
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > ---
> > ?drivers/clk/Kconfig | ? ?1 +
> > ?1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 165e1fe..f05a60d 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -12,6 +12,7 @@ config HAVE_MACH_CLKDEV
> > ?config COMMON_CLK
> > ? ? ? ?bool
> > ? ? ? ?select HAVE_CLK_PREPARE
> > + ? ? ? select CLKDEV_LOOKUP
> > ? ? ? ?---help---
> > ? ? ? ? ?The common clock framework is a single definition of struct
> > ? ? ? ? ?clk, useful across many platforms, as well as an
> 
> Hi Rob,
> 
> I agree that the common clk framework is not particularly useful
> without clkdev.  However the core code has no dependency on clkdev.
> Why not just select it from an arch Kconfig, or even make it a
> dependency based on your own platform clock data/code?

Selecting it from COMMON_CLK means that the compiler/linker will point
everybody trying to implement it without CLKDEV into the right
direction.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
