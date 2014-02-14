From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 14 Feb 2014 13:57:36 +0000
Subject: [PATCH RESEND] ARM: mcpm: Make all mcpm functions notrace
In-Reply-To: <1392378721.3475.12.camel@linaro1.home>
References: <1392279975.3469.4.camel@linaro1.home>
 <alpine.LFD.2.11.1402131542120.17677@knanqh.ubzr>
 <1392378721.3475.12.camel@linaro1.home>
Message-ID: <20140214135731.GA2331@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 11:52:01AM +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-02-13 at 15:42 -0500, Nicolas Pitre wrote:
> > On Thu, 13 Feb 2014, Jon Medhurst (Tixy) wrote:
> > 
> > > From: Dave Martin <dave.martin@linaro.org>
> > > 
> > > The functions in mcpm_entry.c are mostly intended for use during
> > > scary cache and coherency disabling sequences, or do other things
> > > which confuse trace ...  like powering a CPU down and not
> > > returning.  Similarly for the backend code.
> > > 
> > > For simplicity, this patch just makes whole files notrace.
> > > There should be more than enough traceable points on the paths to
> > > these functions, but we can be more fine-grained later if there is
> > > a need for it.
> > > 
> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > > 
> > > Also added spc.o to the list of files as it contains functions used by
> > > MCPM code which have comments comments like: "might be used in code
> > > paths where normal cacheable locks are not working"
> > > 
> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > 
> > Please send to RMK's patch system.
> 
> Thanks, added as patch 7962/2 [1]. (My first attempt accidentally
> omitted the "From: Dave Martin" line - I hope the patch system
> understands such lines).

I won't lost sleep over it if not...

I'd forgotten about this patch, to be honest.

Cheers
---Dave
