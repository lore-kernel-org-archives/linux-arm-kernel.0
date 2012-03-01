From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Mar 2012 19:20:25 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120301105239.GA3124@opensource.wolfsonmicro.com>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120301100847.GF26642@pengutronix.de>
 <20120301105239.GA3124@opensource.wolfsonmicro.com>
Message-ID: <20120301182025.GC3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 10:52:40AM +0000, Mark Brown wrote:
> On Thu, Mar 01, 2012 at 11:08:47AM +0100, Sascha Hauer wrote:
> 
> > Ok, I tried to do this. I Changed the function to:
> 
> > static struct platform_device *regulator_register_fixed(int id,
> > 		struct regulator_consumer_supply *supplies, int num_supplies)
> 
> > Now I have to register a fixed regulator with some invented value
> > for microvolts. What value should I choose? I tried 0 but the core
> > won't accept this as explained earlier, in short regulator_register()
> > returns with an error.
> 
> I've already suggested just fixing the fixed voltage regulator to be
> more sensible when it doesn't have a voltage but you say that won't work
> without explaining why you think that is the case and are still ignoring
> my repeated queries about that.

Maybe because I don't understand what you mean. What should the fixed
regulator do when voltage == 0?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
