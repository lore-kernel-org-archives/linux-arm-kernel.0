From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 18 May 2010 10:40:17 +0200
Subject: i.MX EHCI initialization
In-Reply-To: <20100517095954.GQ30801@buzzloop.caiaq.de>
References: <20100517093652.GP31199@pengutronix.de>
	<20100517095954.GQ30801@buzzloop.caiaq.de>
Message-ID: <20100518084017.GA31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 11:59:55AM +0200, Daniel Mack wrote:
> Hi Sascha,
> 
> On Mon, May 17, 2010 at 11:36:52AM +0200, Sascha Hauer wrote:
> > I see an increasing number of patches trying to change the
> > initialization sequence of the i.MX ehci controller. It's getting harder
> > and harder to keep track what the changes are, what other boards
> > and SoCs a single patch affects and whether it just reverts another
> > patch.
> > 
> > I thought about making the initialization completely board specific and
> > creating a set of helper functions which the board can call if it wants
> > to to prevent too much code duplication.
> 
> If we really need this, I'm pro adding that kind of interface, sure.
> However, at least for the MX51 stuff, altering the init order wasn't
> necessary at all eventually, and I'm not sure about other SoCs.
> 
> I also didn't follow all patches in this area I fear - could you
> summarize which SoC wants it differently than the current code does it?

Valentin changed it with 2f0e40aba1cafe3a834bfcbac8f1e704d496dab9 and
Dinh changed it in his original patch. It may be a feeling at the
moment, but I think we should have an eye on the different SoC and board
specific things we add to the probe function.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
