From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Jul 2012 08:42:57 +0200
Subject: [PATCH] I2C: MV64XYZ: Add Device Tree support
In-Reply-To: <20120723200359.GB31645@pengutronix.de>
References: <1342954295-13279-1-git-send-email-andrew@lunn.ch>
 <20120723200359.GB31645@pengutronix.de>
Message-ID: <20120724064257.GQ18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 10:03:59PM +0200, Wolfram Sang wrote:
> On Sun, Jul 22, 2012 at 12:51:35PM +0200, Andrew Lunn wrote:
> > Extends the driver to get properties from device tree. Rather than
> > pass the N & M factors in DT, use the more standard clock-frequency
> > property. Calculate N & M at run time. In order to do this, we need to
> > know tclk. So the driver uses clk_get() etc in order to get the clock
> > and clk_get_rate() to determine the tclk rate. Not all platforms
> > however have CLK, so some #ifdefery is needed to ensure the driver
> > still compiles when CLK is not available.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Sparse complained about this:
> 
> drivers/i2c/busses/i2c-mv64xxx.c:584:54: warning: incorrect type in argument 3 (different signedness)
> drivers/i2c/busses/i2c-mv64xxx.c:584:54:    expected unsigned int [usertype] *out_value
> drivers/i2c/busses/i2c-mv64xxx.c:584:54:    got int *<noident>
> drivers/i2c/busses/i2c-mv64xxx.c:586:41: warning: incorrect type in argument 3 (different signedness)
> drivers/i2c/busses/i2c-mv64xxx.c:586:41:    expected int *best_n
> drivers/i2c/busses/i2c-mv64xxx.c:586:41:    got unsigned int *<noident>
> drivers/i2c/busses/i2c-mv64xxx.c:586:60: warning: incorrect type in argument 4 (different signedness)
> drivers/i2c/busses/i2c-mv64xxx.c:586:60:    expected int *best_m
> drivers/i2c/busses/i2c-mv64xxx.c:586:60:    got unsigned int *<noident>
> 
> I applied your patch with the following fix to -next. Let me know if you agree
> with that.

Hi Wolfram

Looks good, thanks for the fix.

      Andrew
