From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Feb 2016 17:03:46 +0000
Subject: [PATCH] arm64: remove redundant preempt.h
In-Reply-To: <20160222095205.GA31168@arm.com>
References: <1455299803-317-1-git-send-email-yang.shi@linaro.org>
 <56C7AE26.1060407@linaro.org> <20160222095205.GA31168@arm.com>
Message-ID: <20160222170346.GN3435@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:52:05AM +0000, Will Deacon wrote:
> On Fri, Feb 19, 2016 at 04:07:02PM -0800, Shi, Yang wrote:
> > Any comment on this one?
> 
> I don't really see the point in it, to be honest. Relying on implicit
> #includes is usually a bad idea,

FWIW, in this case we aren't relying on implicit includes. That's when
you explicitly use something but haven't included the relevant header
directly.

For everything we explicitly use, we have included the relevant headers.

Anything that uses preempt.h implicitly should've pulled in preempt.h
via its headers.

> there are other files in the kernel including both of these headers
> and there's not actually a problem to fix as far as I can tell.

Up to you.

The patch does appear correct in that the include is redundant, but its
presence is admittedly not harmful.

Mark.

> 
> Will
> 
> > On 2/12/2016 9:56 AM, Yang Shi wrote:
> > >preempt.h has been included by sched.h, so it is not necessary to include
> > >both, just keep sched.h.
> > >
> > >Signed-off-by: Yang Shi <yang.shi@linaro.org>
> > >---
> > >Happened to find this when checking preempt.h include for another patch review.
> > >Build test is passed with and without CONFIG_PREEMPT enabled.
> > >
> > >  arch/arm64/kernel/cpuinfo.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > >diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > >index 212ae63..e2b37ff 100644
> > >--- a/arch/arm64/kernel/cpuinfo.c
> > >+++ b/arch/arm64/kernel/cpuinfo.c
> > >@@ -25,7 +25,6 @@
> > >  #include <linux/init.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/personality.h>
> > >-#include <linux/preempt.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/sched.h>
> > >
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
