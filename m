From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Apr 2012 08:27:32 +0200
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <20120427050549.GG2234@S2101-09.ap.freescale.net>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
 <20120427034401.GE2234@S2101-09.ap.freescale.net>
 <CAOMZO5DLwrKJQjZD3RWptd4TjUHq=4HLopnzZbFRFvB60pm8XA@mail.gmail.com>
 <20120427050549.GG2234@S2101-09.ap.freescale.net>
Message-ID: <20120427062732.GM20039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 01:05:51PM +0800, Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 12:51:01AM -0300, Fabio Estevam wrote:
> > On Fri, Apr 27, 2012 at 12:44 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > > I applied both patches and see the following modprobe error message
> > > with my testing. ?Any relevance, or I missed something?
> > >
> > > spi_imx 2008000.ecspi: master is unqueued, this is deprecated
> > 
> > This happens in imx-spi driver and I have reported it in the spi-devel list:
> > http://www.mail-archive.com/spi-devel-general at lists.sourceforge.net/msg08019.html
> > 
> I'm fine with that, since it's an info printed by spi core to draw
> people's attention on purpose.
> 
> > > modprobe: FATAL: Could not load /lib/modules/3.4.0-rc4+/modules.dep: No such fil
> > 
> > I have only tested it as built-in.
> > 
> The problem is we do not have this error message before applying these
> two patches, while we are seeing the message with your patches applied.
> What I am saying is your changes on defconfig should not introduce any
> message like that.
This seems to me to be a userspace problem? My guess is applying the
patch changed the kernel version (appends '+') and you didn't run make
modules_install and/or depmod?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
