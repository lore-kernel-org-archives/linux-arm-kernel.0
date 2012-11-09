From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 9 Nov 2012 20:00:15 +0100
Subject: [PATCH 1/6] spi: imx: specify spi base for device tree probe
In-Reply-To: <20121109163830.GP23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-2-git-send-email-s.trumtrar@pengutronix.de>
 <20121109163830.GP23807@opensource.wolfsonmicro.com>
Message-ID: <20121109190015.GB3660@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 04:38:30PM +0000, Mark Brown wrote:
> On Fri, Nov 09, 2012 at 03:00:20PM +0100, Steffen Trumtrar wrote:
> 
> > * This breaks compatibility with user space applications between non-DT and DT.
> 
> > * On platforms that are in between DT and non-DT, it breaks registration of
> >   devices via spi_board_info.
> 
> > Use the same method as 7e6086d9e54a159a6257c02bb7fc5805c614aad2 does for gpios:
> > Use alias to identify the spi port, and then specify the base via the port id.
> > If alias is not defined in DT, allocate the base dynamically.
> 
> This sounds like a fix userspace and/or complete your DT conversion
> problem...

Well, it may lead to problems in userspace and does lead to problems with an
incomplete DT support, but there are only so many hours in a day...

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
