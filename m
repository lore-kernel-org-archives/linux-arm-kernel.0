From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 09:01:41 +0000
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <20111124071406.GS19986@pengutronix.de>
References: <4ECCDAA2.4070502@prolan.hu>
 <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
 <20111123183640.GQ19986@pengutronix.de>
 <20111123225124.GK9581@n2100.arm.linux.org.uk>
 <20111124071406.GS19986@pengutronix.de>
Message-ID: <20111124090141.GN9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 08:14:06AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Nov 23, 2011 at 10:51:24PM +0000, Russell King - ARM Linux wrote:
> > So really, there's no excuse not to fix this for the imx/mxwhatever SoCs
> > today - the clk framework is totally irrelevant as far as this goes.
> I think doing the clk_prepare seperation and converting to the clk
> framework in one step will be easier.

>From a point of view of being able to separate the changes so there isn't
a flag day, you're wrong.  clk_prepare() is already present in the kernel
as dummy functions, and all you need to do at this point is arrange for
the drivers to make the appropriate calls.  There's no need to write one
line of code behind clk_prepare() at the current time.

If you then want to provide a clk_prepare() implementation, then you need
to select CONFIG_HAVE_CLK_PREPARE to prevent the dummy function being
used.
