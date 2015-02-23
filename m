From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Feb 2015 12:24:38 +0100
Subject: Build regressions/improvements in v4.0-rc1
In-Reply-To: <CAMuHMdUTCvQw1q-dJcx9dAnFEXtfJYs+rbVS4KdZgi-3cbSC7g@mail.gmail.com>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <5721217.aGU5oqfDWo@wuerfel>
 <CAMuHMdUTCvQw1q-dJcx9dAnFEXtfJYs+rbVS4KdZgi-3cbSC7g@mail.gmail.com>
Message-ID: <6141970.YzWJy8akUr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 February 2015 11:28:12 Geert Uytterhoeven wrote:
> On Mon, Feb 23, 2015 at 11:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 23 February 2015 10:14:55 Geert Uytterhoeven wrote:
> >> On Mon, Feb 23, 2015 at 10:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> >   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> 
> > I checked the other architectures, and found that the same is missing on
> > ARC, so we should add both:
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index ec35851e5b71..a24d496787d6 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -36,7 +36,7 @@ source "fs/nilfs2/Kconfig"
> >  config FS_DAX
> >         bool "Direct Access (DAX) support"
> >         depends on MMU
> > -       depends on !(ARM || MIPS || SPARC)
> > +       depends on !(ARC || ARM || MIPS || SH || SPARC)
> >         help
> >           Direct Access (DAX) can be used on memory-backed block devices.
> >           If the block device supports DAX and the filesystem supports DAX,
> >
> >
> > It's also not implemented on c6x and blackfin, but both of them have
> > MMU=n, so they are already excluded.
> 
> Exactly.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, let me submit that as a proper patch with a changelog then.

	Arnd
