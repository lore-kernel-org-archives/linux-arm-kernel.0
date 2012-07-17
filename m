From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 21:23:17 +0000
Subject: [RFC PATCHv2 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <1342560692.26186.2.camel@dinh-ubuntu>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <201207171547.58324.arnd@arndb.de> <1342560692.26186.2.camel@dinh-ubuntu>
Message-ID: <201207172123.17473.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Dinh.Nguyen wrote:
> > > +static struct clk apb_pclk = { .rate = 200000000};
> > > +static struct clk i2c_clk = { .rate = 100000000};
> > > +static struct clk spim_clk = { .rate = 100000000};
> > > +static struct clk mpu_pclk = { .rate = SOCFPGA_MPU_PERIHCLK_FREQ_HZ};
> > > +static struct clk l4_main_clk = { .rate = SOCFPGA_L4_MAIN_CLK};
> > 
> > Then move this file into drivers/clk/ using that code.
> 
> This doesn't quite make sense to me. You want me to move platform
> specific information to drivers folder? I only see mxs and spear under
> drivers/clk. Surely, you don't want me to create another socfpga folder
> under there, or do you?

Yes, that was the idea. We're in the process of moving most or all of
the clock drivers there, and the two that you see there are just the
start.

The distinction between "platform specific code" and "device driver"
is quite artificial anyway, and we're constantly moving it so that
we have less platform code.

	Arnd
