From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Feb 2012 09:27:15 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120227235359.GA23230@opensource.wolfsonmicro.com>
References: <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120227090453.GE26642@pengutronix.de>
 <20120227132908.GA3191@opensource.wolfsonmicro.com>
 <20120227172020.GC3852@pengutronix.de>
 <20120227235359.GA23230@opensource.wolfsonmicro.com>
Message-ID: <20120228082715.GK3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 11:54:00PM +0000, Mark Brown wrote:
> On Mon, Feb 27, 2012 at 06:20:20PM +0100, Sascha Hauer wrote:
> 
> > I don't know what to do here. Probably the check for value <= 0 should
> > be removed, but then again the description shows:
> 
> No, zero is intentionally a valid response - it means that the selector
> is invalid (for example, due to being documented as a reserved value)
> allowing a non-error return that doesn't provide a voltage.  The fixed
> regulator should be fixed to return an error if it hasn't got a voltage
> configured.

Hm, you asked me to drop the voltage parameter from the helper function
registering a fixed regulator as dummy. When the fixed regulator bails
out in this case I can't see how this can be done.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
