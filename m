From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Dec 2015 16:08:01 +0100
Subject: [PATCH 1/5] ARM: config: Regenerate multi_v5_defconfig
In-Reply-To: <2115626.l90A97hBkH@wuerfel>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <2254361.JL23NtLhah@wuerfel> <20151202141756.GG29814@lunn.ch>
 <2115626.l90A97hBkH@wuerfel>
Message-ID: <20151202150801.GL29814@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 03:57:01PM +0100, Arnd Bergmann wrote:
> On Wednesday 02 December 2015 15:17:56 Andrew Lunn wrote:
> > On Wed, Dec 02, 2015 at 02:44:00PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 02 December 2015 00:33:28 Andrew Lunn wrote:
> > > > Dues the Kconfig changes, multi_v5_defconfig needs regenerating.
> > > > 
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > ---
> > > >  arch/arm/configs/multi_v5_defconfig | 17 ++++-------------
> > > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> > > > index f69a459f4f92..f98d4b8b54c5 100644
> > > > --- a/arch/arm/configs/multi_v5_defconfig
> > > > +++ b/arch/arm/configs/multi_v5_defconfig
> > > > @@ -11,10 +11,9 @@ CONFIG_MODULE_UNLOAD=y
> > > > @@ -53,7 +52,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
> > > >  CONFIG_MTD_CFI_INTELEXT=y
> > > >  CONFIG_MTD_CFI_STAA=y
> > > >  CONFIG_MTD_PHYSMAP=y
> > > > -CONFIG_MTD_M25P80=y
> > > 
> > > I think we need to enable MTD_SPI_NOR_BASE now to get the driver
> > > back, see 03e296f613af ("mtd: m25p80: use the SPI nor framework")
> > 
> > As you noticed, this is a pure regenerate.
> > 
> > I will send a few more followups with the MTD_SPI_NOR_BASE, and
> > dropping EXT[23].
> 
> Maybe you can do those changes first and regenerate afterwards?
> 
> That makes it more obvious what's going on than removing a symbol
> first and then putting it back.

The flip side is that the regenerate makes it reflect reality. Those
options actually are disabled in todays kernel.

Also, doing it the other way around is quite a bit of work, since you
have to manually edit the _defconfig and figure out manually where the
option needs to be placed in the file.

Humm, i wounder if 0-day could be of use here. How about at the end of
each patch series, it regenerates the _defconfig files. If there are
any changes, issue a warning. That will help keep them in sync with
reality.

	Andrew
