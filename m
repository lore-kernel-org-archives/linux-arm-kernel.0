From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Apr 2015 07:50:41 +0200
Subject: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
In-Reply-To: <20150420205230.GK14892@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
 <20150418173740.GF26185@sirena.org.uk>
 <20150420045017.GI6325@pengutronix.de>
 <20150420205230.GK14892@sirena.org.uk>
Message-ID: <20150421055041.GQ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 09:52:30PM +0100, Mark Brown wrote:
> On Mon, Apr 20, 2015 at 06:50:17AM +0200, Sascha Hauer wrote:
> > On Sat, Apr 18, 2015 at 06:37:40PM +0100, Mark Brown wrote:
> > > On Fri, Apr 10, 2015 at 04:14:08PM +0800, Koro Chen wrote:
> 
> > > > +	[0][0] =   { .creg = 0x020, .cshift =  0, .sreg = 0x020, .sshift = 10},
> > > > +	[0][1] =   { .creg = 0x020, .cshift = 16, .sreg = 0x020, .sshift = 26},
> 
> > > It'd also be nice to have less magic numbers in the table, at least for
> > > the indexes (which I guess correspond to some of the defines in the
> > > headers)?
> 
> > With defines the above two lines would become something like:
> 
> > [0][0] = { .creg = AFE_CONN0, .cshift = CONN0_I00_O00_S, .sreg = AFE_CONN0, .sshift = CONN0_I00_O00_R },
> > [0][1] = { .creg = AFE_CONN0, .cshift = CONN0_I00_O01_S, .sreg = AFE_CONN0, .sshift = CONN0_I00_O01_S },
> 
> > For the registers we could use defines, but I think using defines for
> > the shifts doesn't add much value given they are only used once.
> 
> By indexes I actually meant the [0][0] and so on - they seem the more
> magic bit.

Oh, that's not magic at all, the crossbar switch has inputs and outputs
numbered from 0 to MTK_AFE_INTERCONN_NUM_INPUT /
MTK_AFE_INTERCONN_NUM_OUTPUT (they have the same numbers in the
datasheet. To connect input x with output y look at index [x][y] in the
table and write the register values found at that place. If .creg is 0x0
then it's not possible to connect the given input with the given output.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
