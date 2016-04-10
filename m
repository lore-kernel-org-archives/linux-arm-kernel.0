From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 10 Apr 2016 17:43:52 +0200
Subject: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
In-Reply-To: <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
Message-ID: <20160410154352.GH5377@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 02/03/2016 at 11:22:04 +0100, Geert Uytterhoeven wrote :
> On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Every new architecture has to add itself to the growing list of those
> > that do not support the legacy PC RTC driver.
> >
> > This replaces the long list of architectures that don't support it
> > with a shorter list of those that do.
> >
> > The list is taken from those architectures that have a non-empty
> > asm/mc146818rtc.h header file and were not explicitly blacklisted.
> 
> M68K was blacklisted...
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/char/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index a043107da2af..9716bc36495a 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -279,8 +279,7 @@ if RTC_LIB=n
> >
> >  config RTC
> >         tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> > -       depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> > -                       && !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> > +       depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
> 
> ... so please drop it here.
> 

Do you plan to resend that one?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
