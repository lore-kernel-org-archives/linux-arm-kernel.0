From: briannorris@chromium.org (Brian Norris)
Date: Tue, 19 Jul 2016 12:29:14 -0700
Subject: [PATCH] arm64: dts: rockchip: add spiX aliases for rk3399
In-Reply-To: <20160719192754.GA140860@google.com>
References: <1468545873-134339-1-git-send-email-briannorris@chromium.org>
 <20160719063955.GE5368@pengutronix.de> <2679180.WfB7C6de5F@diego>
 <20160719192754.GA140860@google.com>
Message-ID: <20160719192912.GA142821@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 12:27:54PM -0700, Brian Norris wrote:
> + Rob

+ Rob for real

> Hi,
> 
> On Tue, Jul 19, 2016 at 08:56:47PM +0200, Heiko Stuebner wrote:
> > Am Dienstag, 19. Juli 2016, 08:39:55 schrieb Uwe Kleine-K?nig:
> > > On Thu, Jul 14, 2016 at 06:24:33PM -0700, Brian Norris wrote:
> > > > It's nicer to see this:
> > > >     # ls -l /sys/bus/spi/devices/
> > > >     total 0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi0.0 ->
> > > >     ../../../devices/platform/ff1c0000.spi/spi_master/spi0/spi0.0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi1.0 ->
> > > >     ../../../devices/platform/ff1d0000.spi/spi_master/spi1/spi1.0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi2.0 ->
> > > >     ../../../devices/platform/ff1e0000.spi/spi_master/spi2/spi2.0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi5.0 ->
> > > >     ../../../devices/platform/ff200000.spi/spi_master/spi5/spi5.0> 
> > > > than this:
> > > >     # ls -l /sys/bus/spi/devices/
> > > >     total 0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32763.0 ->
> > > >     ../../../devices/platform/ff200000.spi/spi_master/spi32763/spi32763.0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32764.0 ->
> > > >     ../../../devices/platform/ff1e0000.spi/spi_master/spi32764/spi32764.0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32765.0 ->
> > > >     ../../../devices/platform/ff1d0000.spi/spi_master/spi32765/spi32765.0
> > > >     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32766.0 ->
> > > >     ../../../devices/platform/ff1c0000.spi/spi_master/spi32766/spi32766.0> 
> > > > With the latter, it's much clearer which bus devices are on.
> > > > 
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > > 
> > > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> > > > 4c84229789ef..b04abbfd4898 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > @@ -70,6 +70,12 @@
> > > > 
> > > >  		serial2 = &uart2;
> > > >  		serial3 = &uart3;
> > > >  		serial4 = &uart4;
> > > > 
> > > > +		spi0 = &spi0;
> > > > +		spi1 = &spi1;
> > > > +		spi2 = &spi2;
> > > > +		spi3 = &spi3;
> > > > +		spi4 = &spi4;
> > > > +		spi5 = &spi5;
> > > 
> > > Note that Rob Herring (with his dt-maintainer hat on) doesn't like these
> > > aliases.
> > > See for example:
> > > 	http://mid.gmane.org/20160705140546.GA10601 at rob-hp-laptop
> 
> But why? I believe half the arguments in the linked thread were
> Catch-22's -- there were no "mainline" users (which is a false target
> IMO anyway, as Christer Weinigel mentioned somewhere in the thread Rob
> linked), and so we couldn't accept more documentation (or users) for the
> feature. FWIW, my quick grep now shows there are currently 43 mainline
> users.
> 
> This feature is very useful. Some of the thread Rob pointed to argued
> that the indexing isn't HW documentation; in this case, it most
> certainly is. The RK3399 TRM explicitly has these SPI buses named SPI0,
> SPI1, SPI2, SPI3, SPI4, and SPI5, and schematics that I've seen use the
> same terminology. It is therefore *much* nicer to have my device show up
> as 'spi2.0' (reflecting their correct HW name) rather than spi32764.0.
> Sometimes I can't even get as far as mounting sysfs to check what this
> maps to, but having spi2.0 in the kernel log can clearly tell me what
> device is causing problems.
> 
> If Rob can support a better alternative solution, I'd be happy to
> switch. But I don't understand why we can't use a useful (not just to
> me, but presumably to at least 43 other independent users, and many
> more out of tree), existing, and long-supported feature here.
> 
> > thanks for the heads up on this. I've dropped this patch again.
> 
> :(
> 
> Regards,
> Brian
