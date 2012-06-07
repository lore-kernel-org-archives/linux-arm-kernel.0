From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jun 2012 21:24:27 +0200
Subject: [PATCH] ARM: mx35: add WEIM register addresses
In-Reply-To: <1339093049.4704.192.camel@mars>
References: <20120509131638.GA2057@lovely.krouter>
 <20120607180738.GM30400@pengutronix.de>
 <1339093049.4704.192.camel@mars>
Message-ID: <20120607192427.GO30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 08:17:29PM +0200, Christoph Fritz wrote:
> On Thu, 2012-06-07 at 20:07 +0200, Sascha Hauer wrote:
> 
> > The same could be used on i.MX25 aswell. I think we should clean this
> > up before adding more SoCs.
> 
> :) full ack. What would you suggest? A macro?

Something like the following should do. We still could do better, but at
least we have all pieces together.

imx-weim.h:

#define IMX_WEIM_CSU_BITS	...

static inline void imx_weim_cs(void __iomem *base, int cs, u32 csu, u32 csl, u32 csa)
{
	do_it
}

static inline void mx27_weim_cs(int cs, u32 csu, u32 csl, u32 csa)
{
	imx_weim_cs(MX27_IO_ADDRESS(MX27_WEIM_BASE), cs, csu, csl, csa));
}


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
