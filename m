From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 14 Feb 2014 11:52:01 +0000
Subject: [PATCH RESEND] ARM: mcpm: Make all mcpm functions notrace
In-Reply-To: <alpine.LFD.2.11.1402131542120.17677@knanqh.ubzr>
References: <1392279975.3469.4.camel@linaro1.home>
 <alpine.LFD.2.11.1402131542120.17677@knanqh.ubzr>
Message-ID: <1392378721.3475.12.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-13 at 15:42 -0500, Nicolas Pitre wrote:
> On Thu, 13 Feb 2014, Jon Medhurst (Tixy) wrote:
> 
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > The functions in mcpm_entry.c are mostly intended for use during
> > scary cache and coherency disabling sequences, or do other things
> > which confuse trace ...  like powering a CPU down and not
> > returning.  Similarly for the backend code.
> > 
> > For simplicity, this patch just makes whole files notrace.
> > There should be more than enough traceable points on the paths to
> > these functions, but we can be more fine-grained later if there is
> > a need for it.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > Also added spc.o to the list of files as it contains functions used by
> > MCPM code which have comments comments like: "might be used in code
> > paths where normal cacheable locks are not working"
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Please send to RMK's patch system.

Thanks, added as patch 7962/2 [1]. (My first attempt accidentally
omitted the "From: Dave Martin" line - I hope the patch system
understands such lines).

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7962/2

-- 
Tixy
