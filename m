From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Jan 2018 14:49:04 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
References: <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
Message-ID: <20180115144903.cdbud6akuavq4qnl@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 03:32:49PM +0100, Borislav Petkov wrote:
> On Mon, Jan 15, 2018 at 02:21:54PM +0000, Mark Rutland wrote:
> > I'm not sure it's possible to cover all potential EDAC implementations
> > behind the same driver.
> > 
> > If we need these drivers, they should be <cpuname>_edac or <soc>_edac.
> 
> Yuck, I wanted to avoid that...
> 
> Oh well, can we at least share the barebones design and exchange
> registers/DT only or is it more complicated than that?

Unfortunately, it's likely to be more complicated than that. The HW may
be wildly different.

The ARMv8 RAS extensions provide some level of architected EDAC support,
which should be more uniform across CPUs, FW, hypervisors, etc. That we
could support as armv8_ras_edac, and going forward I'd hope that
implementations align with that.

Thanks,
Mark.
