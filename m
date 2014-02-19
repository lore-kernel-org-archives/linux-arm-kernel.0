From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 19 Feb 2014 19:08:44 +0400
Subject: =?UTF-8?B?UmU6IFtQYXRjaCB2MyAyMC8yM10gQVJNOiBjb25maWc6IEFkZCBhIG11bHRp?=
 =?UTF-8?B?X3Y1X2RlZmNvbmZpZw==?=
In-Reply-To: <2697728.sKu8bCFvXU@wuerfel>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
 <1392819548.815735822@f395.i.mail.ru> <2697728.sKu8bCFvXU@wuerfel>
Message-ID: <1392822524.597155607@f84.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 19 ??????? 2014, 15:54 +01:00 ?? Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 19 February 2014 18:19:08 Alexander Shiyan wrote:
> > ?????, 19 ??????? 2014, 15:12 +01:00 ?? Andrew Lunn <andrew@lunn.ch>:
> > > To allow regression build testing of multi v5 systems, add a
> > > multi_v5_defconfig, similar to the multi_v7_defconfig. This is based
> > > on kirkwood_defconfig, but with a few other boards added which claim
> > > to be MULTI_v5.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  arch/arm/configs/multi_v5_defconfig | 183 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 183 insertions(+)
> > >  create mode 100644 arch/arm/configs/multi_v5_defconfig
> > > 
> > > diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> > ...
> > > +CONFIG_DEBUG_LL=y
> > > +CONFIG_DEBUG_MVEBU_UART_ALTERNATE=y
> > > +CONFIG_DEBUG_UART_VIRT=0xfed12000
> > 
> > Should we disable lowlevel debug for multi-* config?
> 
> Yes, definitely.
> 
> On a related note, I'd like to add a CONFIG_BROKEN_MULTIPLATFORM Kconfig
> symbol and make all options depend on that which will result in a kernel
>

config DEBUG_LL
  depends on! ARCH_MULTIPLATFORM

is not enough for this?

---
