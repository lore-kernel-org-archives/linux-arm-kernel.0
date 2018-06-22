From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 14:31:34 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B2CF723.7010600@hisilicon.com>
References: <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
Message-ID: <20180622133133.GA1802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again, Wei,

On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
> On 2018/6/22 19:16, Will Deacon wrote:
> >On Fri, Jun 22, 2018 at 06:45:15PM +0800, Wei Xu wrote:
> >>On 2018/6/22 17:23, Will Deacon wrote:
> >>>Perhaps just writing back the table entries is enough to cause the issue,
> >>>although I really can't understand why that would be the case. Can you try
> >>>the diff below (without my previous change), please?
> >>Thanks!
> >>But it does not resolve the issue(only apply this patch based on 4.17.0).
> >Thanks, that's a useful data point. It means that it still crashes even if
> >we write back the same table entries, so it's the fact that we're writing
> >them at all which causes the problem, not the value that we write.
> >
> >Whilst looking at the code, we noticed a missing DMB. On the off-chance
> >that it helps, can you try this instead please?
> Thanks!
> Only apply below patch based on 4.17.0, we still got the crash.

Oh well, it was worth a shot (and that's still a fix worth having). Please
can you provide the complete disassembly for kpti_install_ng_mappings()
(I'm referring to the C function in cpufeature.c) along with a corresponding
crash log so that we can correlate the instruction stream with the crash?

Thanks,

Will
