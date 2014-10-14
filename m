From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 14 Oct 2014 14:40:48 -0700
Subject: [PATCH] gcov: add ARM64 to GCOV_PROFILE_ALL
In-Reply-To: <543694F4.3070306@linux.vnet.ibm.com>
References: <1412852099-23099-1-git-send-email-riku.voipio@linaro.org>
 <543694F4.3070306@linux.vnet.ibm.com>
Message-ID: <20141014144048.e2bf1f5ec23c39d2a59700f6@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Oct 2014 16:00:20 +0200 Peter Oberparleiter <oberpar@linux.vnet.ibm.com> wrote:

> Looks good. Andrew, can you pick this change up via your tree?
> 

Sure.

> 
> On 09.10.2014 12:54, Riku Voipio wrote:
> > Following up the arm testing of gcov, turns out gcov on ARM64
> > works fine as well. Only change needed is adding ARM64 to Kconfig
> > depends.
> > 
> > Tested with qemu and mach-virt
> > 
> > Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> > ---
> >  kernel/gcov/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > index cf66c5c..3b74087 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfig
> > @@ -35,7 +35,7 @@ config GCOV_KERNEL
> >  config GCOV_PROFILE_ALL
> >  	bool "Profile entire Kernel"
> >  	depends on GCOV_KERNEL
> > -	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
> > +	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM || ARM64
> >  	default n
> >  	---help---
> >  	This options activates profiling for the entire kernel.

gcov is doing this the wrong way.  There should be a `select
GCOV_PROFILE_ALL' in each arch/*/Kconfig.

(But pleeeeeeze not at the end of the list!  That's the perfect way of
maximizing patch conflicts, but nobody seems to understand this)
