From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 15 Oct 2014 08:54:34 +1100
Subject: [PATCH] gcov: add ARM64 to GCOV_PROFILE_ALL
In-Reply-To: <20141014144048.e2bf1f5ec23c39d2a59700f6@linux-foundation.org>
References: <1412852099-23099-1-git-send-email-riku.voipio@linaro.org>
 <543694F4.3070306@linux.vnet.ibm.com>
 <20141014144048.e2bf1f5ec23c39d2a59700f6@linux-foundation.org>
Message-ID: <20141015085434.2c155706@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, 14 Oct 2014 14:40:48 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > > index cf66c5c..3b74087 100644
> > > --- a/kernel/gcov/Kconfig
> > > +++ b/kernel/gcov/Kconfig
> > > @@ -35,7 +35,7 @@ config GCOV_KERNEL
> > >  config GCOV_PROFILE_ALL
> > >  	bool "Profile entire Kernel"
> > >  	depends on GCOV_KERNEL
> > > -	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
> > > +	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM || ARM64
> > >  	default n
> > >  	---help---
> > >  	This options activates profiling for the entire kernel.
> 
> gcov is doing this the wrong way.  There should be a `select
> GCOV_PROFILE_ALL' in each arch/*/Kconfig.

What they should actually do is select (say) ARCH_HAS_GCOV_PROFILE_ALL
and then GCOV_PROFILE_ALL should depend on that.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/bc456ecb/attachment.sig>
