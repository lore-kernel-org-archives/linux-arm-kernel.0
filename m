From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2012 18:57:00 +0000
Subject: [PATCH] ARM: pxa: Fix build error caused by sram.h rename
In-Reply-To: <87d30xgel3.fsf@octavius.laptop.org>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <201210022027.45461.arnd@arndb.de> <87d30xgel3.fsf@octavius.laptop.org>
Message-ID: <201210051857.01311.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 October 2012, Chris Ball wrote:
> On Tue, Oct 02 2012, Arnd Bergmann wrote:
> > On Tuesday 02 October 2012, Chris Ball wrote:
> >> Commit 293b2da1b61 ("ARM: pxa: move platform_data definitions")
> >> renamed arch/arm/mach-mmp/include/mach/sram.h to
> >> include/linux/platform_data/dma-mmp_tdma.h, but didn't update
> >> mmp-pcm.c which uses the header.  Fix the build error.
> >> 
> >> Signed-off-by: Chris Ball <cjb@laptop.org>
> >> ---
> >>  sound/soc/pxa/mmp-pcm.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Sorry I didn't catch this earlier. The file was only recently added
> > and somehow didn't appear in my build tests.
> 
> Thanks.  Do you want to send this to mainline, or should Mark do it?
> 

I think it's better for Mark to queue it up than me. sound/soc/
is his domain, and I don't have any other patches that would go
along with this fix.

	Arnd
