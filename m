From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 27 Aug 2011 13:31:05 -0600 (MDT)
Subject: How to handle named resources with DT?
In-Reply-To: <5595208.OB5dBohxQP@wuerfel>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108261741.29850.arnd@arndb.de>
	<20110827143736.GA10182@yookeroo.fritz.box>
	<5595208.OB5dBohxQP@wuerfel>
Message-ID: <alpine.DEB.2.00.1108271306500.23968@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Aug 2011, Arnd Bergmann wrote:

> Right, and I guess we can simply ignore DMA and ioport resources because 
> they are extremely rare, right?

DMA resources are quite widely used.

For example, looking at the SoCs with some publicly-available 
documentation, the Motorola i.MX51 reference manual lists 47 SDMA request 
lines across about 17 different IP block types[1], and to pick a 
representative OMAP, the OMAP3430 technical reference manual lists 77 SDMA 
request lines, used by at least 9 different IP block types[2].

Also, many IP blocks have multiple DMA resources.  For example, the above 
references list UART, MCSPI, PATA, I2C, FIRI, MCBSP, SSI, CTI, CSPI, 
eCSPI, EMI, eSDHC, SPI, and DSS.


- Paul

1. Table 3-3, "SDMA Event Mapping".  _MCIMX51 Multimedia Applications 
   Processor Reference Manual (MCIMX51RM) Rev. 1 2/2010_.  Available from
   http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=i.MX515&fpsp=1&tab=Documentation_Tab

2. This is simply one example from the OMAP3430 TRM, but similar tables
   are available for OMAP2420, 2430, 3430, 3630, 4430, 4460, 4470, etc.
   Table 9-3, "SDMA Request Mapping". _OMAP34xx Multimedia Device Silicon 
   Revision 3.1.x Version J (SWPU223J)_ (public version).  Available from 
   http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?templateId=6123&navigationId=12667
