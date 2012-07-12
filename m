From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 08:45:22 +0800
Subject: [PATCH] i2c i.MX: Fix divider table
In-Reply-To: <20120711183838.GM30009@pengutronix.de>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <20120705145236.GA2735@richard-laptop>
 <20120705160153.GT30009@pengutronix.de>
 <20120706005249.GA26888@b20223-02.ap.freescale.net>
 <20120706062852.GZ30009@pengutronix.de>
 <20120711060121.GB30055@b20223-02.ap.freescale.net>
 <20120711183838.GM30009@pengutronix.de>
Message-ID: <20120712004522.GA21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 08:38:38PM +0200, Sascha Hauer wrote:
> Hi Richard,
> 
> On Wed, Jul 11, 2012 at 02:01:21PM +0800, Richard Zhao wrote:
> > 
> > IC guys confirmed that the spec is right:
> > 
> > This an adaptive feature of our I2C module may apply to all IMX chips.
> > No mistake in the table of RMs.
> > 
> > The divider is designed to guarantee SCL high level and low level last
> > time. Divider will hold when SCL transition from 1 to 0 or 0 to 1, if
> > the transition time is longer than 1 internal pre-divided clock cycle.
> > The pre-divided clock is divided from I2C module clock, used for
> > generating SCL. So you will see SCL clock cycle is some way longer than
> > calculated value using IFDR.
> > 
> > Transition time will different from rising or falling edge, different
> > pull-up resistors, and different SCL loading.
> > 
> > This feature make sure transition time won?t eat both level time of SCL.
> 
> Thanks for clarification. Does this mean that this feature is used to
> synchronize between the bus clock and and bitclock?
Per my understanding,
Not exactly. Divided clock is only used for count time of SCL level
hold. This means, even if the i2c bus loading is high (long level
setup time), the i2c may still work.

Thanks
Richard
> 
> I'll send a documentation patch for this next week to make this clear.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
