From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 24 Jun 2016 10:57:29 +0800
Subject: [PATCH] arm64:swiotlb:Enable only when Input size through
 command line
In-Reply-To: <9A15F5E5-775E-4079-961F-67FD54B8F2F4@oracle.com>
References: <1466684020-5224-1-git-send-email-manjeet.p@samsung.com>
 <20160623143034.GN6521@e104818-lin.cambridge.arm.com>
 <9A15F5E5-775E-4079-961F-67FD54B8F2F4@oracle.com>
Message-ID: <20160624105729.095e7f1f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Konrad,

On Thu, 23 Jun 2016 12:06:10 -0400 Konrad Rzeszutek Wilk wrote:

> On June 23, 2016 10:30:34 AM EDT, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >On Thu, Jun 23, 2016 at 05:43:40PM +0530, Manjeet Pawar wrote:  
> >> From: Rohit Thapliyal <r.thapliyal@samsung.com>
> >> 
> >> swiotlb default size of 64M is too big as
> >> default value therefore it is made configurable
> >> through command line through swiotlb_size parameter.
> >> swiotlb allocation shall be done only when the
> >> swiotlb size is given through command line.
> >> Otherwise no swiotlb is allocated.  
> >
> >I already queued this patch:
> >
> >http://lkml.kernel.org/g/1465372426-4077-1-git-send-email-jszhang at marvell.com
> >
> >If you have any objections to it, please reply there.  
> 
> 
> I do (sorry about duplicate email, the other got rejected by mailing lists).
> 
> Why not expand the swiotlb= parameter instead of introducing a new one?

Do you mean pass "swiotlb=" for those platforms(most probably, arm64 with less
than 4GB DDR) which don't need swiotlb? I'm afraid this is not convenient, and
users even don't notice swiotlb parameter. From another side, pass "swiotlb=0"
will make the swiotlb reserve 64MB instead, so how can we achieve zero reserved
memory for swiotlb through "swiotlb=" parameter?

PS: my patch didn't introduce new boot parameter.

I'm not sure I got your meaning, so could you please comment my patch
directly?

Thanks,
Jisheng

> 
> Also, why not use the swiotlb by itself? That does the job as well?
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
