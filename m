From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Mar 2015 06:27:19 +0100
Subject: [PATCH 0/3] ARM: dts: Define stdout-patch for Exynos Chromebooks
In-Reply-To: <075601d06054$d94e6fa0$8beb4ee0$@kernel.org>
References: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
 <075601d06054$d94e6fa0$8beb4ee0$@kernel.org>
Message-ID: <2791862.CZRe5DtPad@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 March 2015 10:51:13 Kukjin Kim wrote:
> Javier Martinez Canillas wrote:
> > 
> > The kernel can use as the default console a serial port if is defined
> > as stdout device in the Device Tree.
> > 
> > This allows a board to be booted without the need of having a console
> > parameter in the kernel command line.
> > 
> > This small series add a stdout-path property for Exynos5 Chromebooks and
> > is composed of the following patches:
> > 
> > Javier Martinez Canillas (3):
> >   ARM: dts: Define stdout-path property for Peach boards
> >   ARM: dts: Define stdout-path property for Snow board
> >   ARM: dts: Define stdout-path property for Spring board
> > 
> >  arch/arm/boot/dts/exynos5250-snow.dts      | 1 +
> >  arch/arm/boot/dts/exynos5250-spring.dts    | 1 +
> >  arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 ++++
> >  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 ++++
> >  4 files changed, 10 insertions(+)
> > 
> + Arnd
> 
> Basically, I have no objection to add stdout-path property on board DT but I
> need to ask other ARM guys how they think about? Always I'm questioned what
> should be defined in bootloader before entering kernel and IMHO kernel can do
> it, it should be defined in bootloader though 
> 
> Let's wait for other opinions...
> 

We're trying to do this on all machines now so we can replace
debug_ll with earlycon for any normal use case aside from early
early boot debugging.

Please merge this patch set.

	Arnd
