From: pavel@denx.de (Pavel Machek)
Date: Sat, 27 Oct 2012 13:24:49 +0200
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <201210271043.40569.arnd@arndb.de>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
 <20121026224358.GD21164@n2100.arm.linux.org.uk>
 <20121026230052.GA24573@elf.ucw.cz>
 <201210271043.40569.arnd@arndb.de>
Message-ID: <20121027112449.GA5912@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2012-10-27 10:43:40, Arnd Bergmann wrote:
> On Friday 26 October 2012, Pavel Machek wrote:
> > arch/arm/mach-socfpga/headsmp.S:21: Error: attempt to use an ARM
> > instruction on a Thumb-only processor -- `movw
> > r0,#:lower16:(0xffd08000+0x10)'
> > ...
> > 
> > Using .arch armv7-a indeed works and is a very nice solution.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > 
> > --- a/arch/arm/mach-socfpga/headsmp.S
> > +++ b/arch/arm/mach-socfpga/headsmp.S
> > @@ -11,6 +11,7 @@
> >  #include <linux/init.h>
> >  
> >         __INIT
> > +       .arch   armv7-a
> >  
> >  #define HPS_SYSMGR_ADDRESS     0xffd08000
> >  #define CONFIG_SYSTEM_MANAGER  HPS_SYSMGR_ADDRESS
> > 
> 
> Thanks, applied with new commit message.

Thanks!
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
