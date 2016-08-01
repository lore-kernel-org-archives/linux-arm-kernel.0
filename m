From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Aug 2016 09:24:50 +1000
Subject: linux-next: manual merge of the clockevents tree with the
 arm-soc tree
In-Reply-To: <20160727080845.12b58ebe@canb.auug.org.au>
References: <20160707141226.2b9c1e15@canb.auug.org.au>
 <20160727080845.12b58ebe@canb.auug.org.au>
Message-ID: <20160802092450.36780125@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Wed, 27 Jul 2016 08:08:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Thu, 7 Jul 2016 14:12:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Today's linux-next merge of the clockevents tree got a conflict in:
> > 
> >   arch/arm/Kconfig
> > 
> > between commit:
> > 
> >   c86f51737f8d ("ARM: clps711x: Switch to MULTIPLATFORM")
> > 
> > from the arm-soc tree and commit:
> > 
> >   250e46aa3bb3 ("clocksource/drivers/clps_711x: Add the COMPILE_TEST option")
> > 
> > from the clockevents tree.
> > 
> > I fixed it up (I used the arm-soc version of this file and then added
> > the following merge fix patch) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 7 Jul 2016 13:59:06 +1000
> > Subject: [PATCH] clocksource/drivers/clps_711x: fixup for "ARM: clps711x: Switch to MULTIPLATFORM"
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/arm/mach-clps711x/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
> > index 3b56197ccfd0..dc7c6edeab39 100644
> > --- a/arch/arm/mach-clps711x/Kconfig
> > +++ b/arch/arm/mach-clps711x/Kconfig
> > @@ -3,8 +3,8 @@ menuconfig ARCH_CLPS711X
> >  	depends on ARCH_MULTI_V4T
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select AUTO_ZRELADDR
> > -	select CLKSRC_MMIO
> >  	select CLKSRC_OF
> > +	select CLPS711X_TIMER
> >  	select COMMON_CLK
> >  	select CPU_ARM720T
> >  	select GENERIC_CLOCKEVENTS
> > -- 
> > 2.8.1  
> 
> Since Linus has merged most of the tip tree now, this merge fixup is
> required when (part of) the arm-soc tree is moerged with Linus' tree.

This merge fix patch was missed when Linus merged the various bits of
the arm-soc tree overnight. :-(

Here is the merge fix patch again:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 7 Jul 2016 13:59:06 +1000
Subject: [PATCH] clocksource/drivers/clps_711x: fixup for "ARM: clps711x:
 Switch to MULTIPLATFORM"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-clps711x/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index 3b56197ccfd0..dc7c6edeab39 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -3,8 +3,8 @@ menuconfig ARCH_CLPS711X
 	depends on ARCH_MULTI_V4T
 	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
-	select CLKSRC_MMIO
 	select CLKSRC_OF
+	select CLPS711X_TIMER
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
-- 
2.8.1

-- 
Cheers,
Stephen Rothwell
