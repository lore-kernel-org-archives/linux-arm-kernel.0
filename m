From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Feb 2016 17:04:56 +0100
Subject: [PATCH 04/11] arm64: Introduce Allwinner SoC config option
In-Reply-To: <56B0CBA8.3020804@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <56B0C95B.4040500@gmail.com> <56B0CBA8.3020804@arm.com>
Message-ID: <6587581.Opm4UCG8SA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 February 2016 15:30:48 Andre Przywara wrote:
> Hi,
> 
> On 02/02/16 15:20, Matthias Brugger wrote:
> > 
> > 
> > On 01/02/16 18:39, Andre Przywara wrote:
> >> To prepare for the Allwinner A64 SoC support, introduce a config
> >> option to allow compiling Allwinner (aka. sunxi) specific drivers
> >> for the arm64 architecture as well.
> >> This patch just defines the ARCH_SUNXI symbol to allow Allwinner
> >> specific drivers to be selected during kernel configuration.
> >> Since the MMC driver is quite essential for Linux to be useful, select
> >> it by default.
> >>
> > 
> > This mostly depends on the board you have. The rootfs could be on the
> > flash, on nfs or even on a usb stick.
> 
> Yeah, could be. It's just that all boards I know of so far have either
> SD card or eMMC.
> Maybe it's better put in defconfig.

Yes, definitely. The current patch also causes a Kconfig warning when
a user disables CONFIG_MMC, as that a dependency for MMC_SUNXI.

There are tons of other options that users need to select to have
a usable system, no need to treat this one special.

	Arnd
