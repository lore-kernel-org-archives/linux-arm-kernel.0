From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 18 Nov 2009 16:42:56 +0100
Subject: [PATCH 3/5] ARM: MX3: add SPI devices for mx31lite
In-Reply-To: <20091118153708.GN30179@pengutronix.de>
References: <1258551702-8631-1-git-send-email-daniel@caiaq.de>
	<1258551702-8631-2-git-send-email-daniel@caiaq.de>
	<1258551702-8631-3-git-send-email-daniel@caiaq.de>
	<20091118153708.GN30179@pengutronix.de>
Message-ID: <20091118154256.GI14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 04:37:08PM +0100, Sascha Hauer wrote:
> On Wed, Nov 18, 2009 at 02:41:40PM +0100, Daniel Mack wrote:
> >  /*
> > + * SPI
> > + *
> > + * The MX13783 is hard-wired on the module, hence the corresponding
> > + * bus is registered here and not in the board code, in contrast to
> > + * the other SPI bus.
> > + */
> 
> 
> The mc13783 bus is registered in the -db file, and not here. I think you
> mixed something up here.

Hmm, no, that actually correct. The problem is that all devices on the
SPI bus have to be registered in one block via spi_register_board_info,
and as I don't know whether other boards will have more devices
connected, the registration is done in the board support file, not in
the module code.

The bus itself, however, is hardwired, so it makes no sense to add it
conditionally.

> s/MX13783/MC13783/

That's true :) Care to fix it on the fly or do you want me to resend?
There is btw another typo in the first mail of this series: In its
subject, it should have 'ARM' not 'ARN'.

The tradeoff of too small terminal fonts ;)

Daniel
