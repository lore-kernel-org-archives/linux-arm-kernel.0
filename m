From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 10:57:57 +0100
Subject: [RFC PATCH v2] prevent top pte being overwritten before flushing
In-Reply-To: <CAGCDX1mKn8nJpJ=Sicq8yi1hfW-m0fA+Uyx=Oikhq43Z85muCw@mail.gmail.com>
References: <1350236542-96465-1-git-send-email-yanpai.chen@gmail.com>
 <CANj_sbCbdfvgkKXJjk4L_5Rk-4mQ-zqDqMErry-AzHddDb8WYA@mail.gmail.com>
 <20121017093916.GA5973@mudshark.cambridge.arm.com>
 <CAGCDX1mKn8nJpJ=Sicq8yi1hfW-m0fA+Uyx=Oikhq43Z85muCw@mail.gmail.com>
Message-ID: <20121017095757.GB5973@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 10:54:53AM +0100, Jason Lin wrote:
> 2012/10/17 Will Deacon <will.deacon@arm.com>:
> > On Wed, Oct 17, 2012 at 09:42:19AM +0100, Andrew Yan-Pai Chen wrote:
> >> On Mon, Oct 15, 2012 at 1:42 AM, Andrew Yan-Pai Chen
> >>
> >> Any ideas?
> >
> > I wonder if we could use different ptes for each CPU (by hacking
> > pte_offset_kernel) and then get away with just disabling preemption in both
> > cases?
> >
> > Will
> 
> Single core processor will also cause this issue in flush_pfn_alias().
> So it should use different ptes for each task.
> Will it be so complicated?

You can just disable preemption in that case -- it's the spin_lock that I'd
like to avoid.

Will
