From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 21 Apr 2010 19:54:20 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100421165420.GP19534@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 11:47:13AM -0500, H Hartley Sweeten wrote:
> On Wednesday, April 21, 2010 12:16 AM, Mika Westerberg wrote:
> > I think it is more readable to do:
> >
> >	ep93xx_spi_select_device(espi, msg->spi);
> >
> > and
> >
> >	ep93xx_spi_deselect_device(espi, msg->spi);
> >
> > It can be seen from the function names what we are doing.
> 
> So rename the combined function to ep93xx_spi_cs_control and pass the "control"
> parameter as a bool; true = selected, false = deselected.
> 
> Having the two almost identical functions is a bit redundant.  It also gives you
> two places to have to maintain basically the same operation.  I think this is
> what Grant was referring to with his previous comment.

Agreed. Will do.

Thanks,
MW
