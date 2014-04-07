From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Apr 2014 09:14:08 -0700
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <20140407063100.GN29751@pengutronix.de>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
Message-ID: <144e5c25-abd4-4a5f-85b5-79e6c3d8181e@AM1EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 08:31AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> > During development, the driver first really needed to depend on
> > COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> > forgotten to update the dependencies, so build errors occured:
> > 
> > config: make ARCH=i386 allyesconfig
> > 
> > All error/warnings:
> > 
> >    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
> > >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
> > >> of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> > 
> > Use a very safe dependency for now.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  drivers/i2c/busses/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 93165ff453ab..3d3b9b3577c5 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> >  
> >  config I2C_CADENCE
> >  	tristate "Cadence I2C Controller"
> > -	depends on COMMON_CLK
> > +	depends on ARCH_ZYNQ
> I'd suggest:
> 
> 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)

This misses COMMON_CLK in the COMPILE_TEST case.

	S?ren
