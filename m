From: tbarr@multitech.com (Tim Barr)
Date: Mon, 30 Nov 2009 15:04:45 -0600
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
Message-ID: <1CD05B980C94AC408B37C82BBABAA3E6129304A4@mtsexchange.dc.multitech.prv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I see a bigger problem here. It is more of an issue of how to properly
handle signals that have more than one pin assignment option. Is there
any sort of kernel design spec for this? As it stands now, I have to
modify the at91sam9260devices.c file every time I change kernels,
because some of the MII pins assigned are not the ones I use in my
design. I think that any pin that has more than one assignment option
should be set in the structures passed by the board file.   

Tim Barr
Development Engineer

Multi-Tech Systems, Inc.

> > This patch update the at91_eth_data to handle the usage of PA10 and 
> > PA11 for EMAC's EXT2 and EXT3 signals.
> >
> > The default configuration overlaps with TWI signals, using the new 
> > platform data configuration option "use_twi_pins" it is possible to 
> > use a different pin routing.
> 
> As everybody until now has used the TWI pins, wouldn't it be 
> better to leave them as the default, and introduce a 
> "use_mcda_pins" option for PA10-11 instead?
> 
> Karl Olsen
> 
