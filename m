From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 10:24:55 +0100
Subject: [PATCH 3/5] ARM: MX3: add SPI devices for mx31lite
In-Reply-To: <20091119083825.GO30179@pengutronix.de>
References: <1258551702-8631-1-git-send-email-daniel@caiaq.de>
	<1258551702-8631-2-git-send-email-daniel@caiaq.de>
	<1258551702-8631-3-git-send-email-daniel@caiaq.de>
	<20091118153708.GN30179@pengutronix.de>
	<20091118154256.GI14091@buzzloop.caiaq.de>
	<20091119083825.GO30179@pengutronix.de>
Message-ID: <20091119092455.GF29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 09:38:25AM +0100, Sascha Hauer wrote:
> On Wed, Nov 18, 2009 at 04:42:56PM +0100, Daniel Mack wrote:
> > On Wed, Nov 18, 2009 at 04:37:08PM +0100, Sascha Hauer wrote:
> > > On Wed, Nov 18, 2009 at 02:41:40PM +0100, Daniel Mack wrote:
> > > >  /*
> > > > + * SPI
> > > > + *
> > > > + * The MX13783 is hard-wired on the module, hence the corresponding
> > > > + * bus is registered here and not in the board code, in contrast to
> > > > + * the other SPI bus.
> > > > + */
> > > 
> > > 
> > > The mc13783 bus is registered in the -db file, and not here. I think you
> > > mixed something up here.
> > 
> > Hmm, no, that actually correct. The problem is that all devices on the
> > SPI bus have to be registered in one block via spi_register_board_info,
> 
> Looking at the SPI code I see no reason why it shouldn't be possible to call
> spi_register_board_info multiple times.

Hmm ok, I didn't know that. I changed that and rebased the patches on
top of this. I'll resend the whole series later.

Thanks,
Daniel
