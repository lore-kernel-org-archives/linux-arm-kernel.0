From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 30 Sep 2012 10:58:05 +1300
Subject: [PATCH] arm: vt8500: Fixup for missing gpio.h
In-Reply-To: <20120929211805.GF12999@quad.lixom.net>
References: <1348595239-30577-1-git-send-email-linux@prisktech.co.nz>
 <1348595239-30577-2-git-send-email-linux@prisktech.co.nz>
 <20120929211805.GF12999@quad.lixom.net>
Message-ID: <1348955885.25268.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-09-29 at 14:18 -0700, Olof Johansson wrote:
> On Wed, Sep 26, 2012 at 05:47:19AM +1200, Tony Prisk wrote:
> > mach/include/gpio.h was removed as part of the multiplatform-3.7
> > update. This patch removes the include from arch-vt8500/vt8500.c
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  arch/arm/mach-vt8500/vt8500.c |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
> > index 4494993..587ea95 100644
> > --- a/arch/arm/mach-vt8500/vt8500.c
> > +++ b/arch/arm/mach-vt8500/vt8500.c
> > @@ -32,7 +32,6 @@
> >  #include <linux/of_platform.h>
> >  
> >  #include <mach/restart.h>
> > -#include <mach/gpio.h>
> >  
> >  #include "common.h"
> 
> Applied on top of existing vt8500/devel branch, thanks.
> 
> By the way, I noticed that there is no VT8500 defconfig in the tree, so there's
> no easy way for us to check for build breakages of your platform. You might
> want to add one.
> 
> Also, I noticed the following build warnings that you might want to address
> when I just built a very trivial config that enables the platform:
> 
> arch/arm/mach-vt8500/vt8500.c: In function 'vt8500_init':
> arch/arm/mach-vt8500/vt8500.c:81:8: warning: unused variable 'gpio_base' [-Wunused-variable]
> arch/arm/mach-vt8500/vt8500.c:80:27: warning: unused variable 'fb' [-Wunused-variable]
> 
> 
> -Olof

Argh.. I fixed that twice already.
Somehow I must have lost it while fixing up other problems.

I'll include that in the 3.7 cleanup stuff once -rc comes around.

Regards

Tony P
