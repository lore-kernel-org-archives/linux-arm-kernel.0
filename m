From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 15:57:01 +0100
Subject: [PATCH 1/5] ARM: config: Regenerate multi_v5_defconfig
In-Reply-To: <20151202141756.GG29814@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <2254361.JL23NtLhah@wuerfel> <20151202141756.GG29814@lunn.ch>
Message-ID: <2115626.l90A97hBkH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 15:17:56 Andrew Lunn wrote:
> On Wed, Dec 02, 2015 at 02:44:00PM +0100, Arnd Bergmann wrote:
> > On Wednesday 02 December 2015 00:33:28 Andrew Lunn wrote:
> > > Dues the Kconfig changes, multi_v5_defconfig needs regenerating.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  arch/arm/configs/multi_v5_defconfig | 17 ++++-------------
> > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> > > index f69a459f4f92..f98d4b8b54c5 100644
> > > --- a/arch/arm/configs/multi_v5_defconfig
> > > +++ b/arch/arm/configs/multi_v5_defconfig
> > > @@ -11,10 +11,9 @@ CONFIG_MODULE_UNLOAD=y
> > > @@ -53,7 +52,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
> > >  CONFIG_MTD_CFI_INTELEXT=y
> > >  CONFIG_MTD_CFI_STAA=y
> > >  CONFIG_MTD_PHYSMAP=y
> > > -CONFIG_MTD_M25P80=y
> > 
> > I think we need to enable MTD_SPI_NOR_BASE now to get the driver
> > back, see 03e296f613af ("mtd: m25p80: use the SPI nor framework")
> 
> As you noticed, this is a pure regenerate.
> 
> I will send a few more followups with the MTD_SPI_NOR_BASE, and
> dropping EXT[23].

Maybe you can do those changes first and regenerate afterwards?

That makes it more obvious what's going on than removing a symbol
first and then putting it back.

Sorry for not having a better answer, I realize this is causing extra
work.

	Arnd
