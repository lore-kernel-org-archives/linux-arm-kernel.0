From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 14:57:47 +0800
Subject: [PATCH v2 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
In-Reply-To: <20110706063648.GM6069@pengutronix.de>
References: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
	<1309878338-25697-2-git-send-email-shawn.guo@linaro.org>
	<CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
	<20110706063648.GM6069@pengutronix.de>
Message-ID: <20110706065746.GE26324@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:36:48AM +0200, Sascha Hauer wrote:
> On Tue, Jul 05, 2011 at 11:27:55AM -0600, Grant Likely wrote:
> > On Tue, Jul 5, 2011 at 9:05 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > The patch removes all the uses of cpu_is_mx1(). ?Instead, it uses
> > > the .id_table of platform_driver to distinguish the uart device type.
> > >
> > > A couple of !cpu_is_mx1() logic gets turned into IS_IMX_UART, as the
> > > codes wrapped there are really IMX specific.
> > >
> > > It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
> > > not used anywhere.
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > 
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > 
> > Who's tree is this one going to get merged through?
> 
> Before we merge this through any tree I'd like to have a policy how
> the bindings are named. With the gpio part we agreed that we name
> the bindings after the oldest i.MX they are compatible with. For example
> the last change in the gpios was on the i.MX31, so every newer i.MX
> claims to be compatible with this the i.MX31.
> 
> The patch below instead follows the approach that the currently newest
> i.MX gets a generic name (imx-uart instead of imx21-uart). This decision
> may look silly when another change to the uart core comes and we have
> given the generic name to some arbitrary version of the core.
> 
> I really like to have a consistent scheme across all devices and we have
> the same problem with spi, nand and several others.
> 
Makes sense.  Will fix it in v3.

-- 
Regards,
Shawn
