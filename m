From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 17:42:32 +0100
Subject: [Patch v3 20/23] ARM: config: Add a multi_v5_defconfig
In-Reply-To: <1392825573.346096924@f191.i.mail.ru>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
 <1392822524.597155607@f84.i.mail.ru> <2242951.MozLvvuPx0@wuerfel>
 <1392825573.346096924@f191.i.mail.ru>
Message-ID: <20140219164232.GB11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 07:59:33PM +0400, Alexander Shiyan wrote:
> ?????, 19 ??????? 2014, 16:54 +01:00 ?? Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 19 February 2014 19:08:44 Alexander Shiyan wrote:
> > > ?????, 19 ??????? 2014, 15:54 +01:00 ?? Arnd Bergmann <arnd@arndb.de>:
> > > > On Wednesday 19 February 2014 18:19:08 Alexander Shiyan wrote:
> > 
> > > > > Should we disable lowlevel debug for multi-* config?
> > > > 
> > > > Yes, definitely.
> > > > 
> > > > On a related note, I'd like to add a CONFIG_BROKEN_MULTIPLATFORM Kconfig
> > > > symbol and make all options depend on that which will result in a kernel
> > > >
> > > 
> > > config DEBUG_LL
> > >   depends on! ARCH_MULTIPLATFORM
> > > 
> > > is not enough for this?
> > 
> > No, because that means you can no longer enable DEBUG_LL for any
> > kernel on MVEBU, IMX or any platform that depends on ARCH_MULTIPLATFORM.
> 
> Case when I chose multiplatform but I know exactly what machine/platform I use?
> OK. Understood.

Correct. This is how these options got in there. I selected the
specific configuration for my board, and forgot to remove them again
after fixing my crash. So they got exported as part of "make savedefconfig".

      Andrew
