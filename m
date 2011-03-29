From: martin.furmanski@gmail.com (Martin Furmanski)
Date: Tue, 29 Mar 2011 21:06:45 -0000
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in for
	device accesses
In-Reply-To: <1301416642.583.101.camel@e102109-lin.cambridge.arm.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
	<AANLkTim1=686NAO7ox8s-HAd_KT4OjiUb1Y7jrUtgia3@mail.gmail.com>
	<1301416642.583.101.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTi=eXRhZEVUuX8aT8n=heZnTR6TjxXdasV_ObgNh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These statements appear not even remotely valid. Certainly the CPU is only a
bus master, so when you say slave/master memory access, what are you
referring to?

(Sorry for accidentally bringing the thread off the list for the last 2
posts. Bringing it back.)

Best Regards,
Martin Furmanski

On Tue, Mar 29, 2011 at 6:37 PM, Catalin Marinas <catalin.marinas@arm.com>wrote:

> On Tue, 2011-03-29 at 17:16 +0100, Martin Furmanski wrote:
> > From memory_barriers.txt, regarding rmb():
> >
> > " (3) Read (or load) memory barriers.
> >
> >      A read barrier is a data dependency barrier plus a guarantee that
> all the
> >      LOAD operations specified before the barrier will appear to happen
> before
> >      all the LOAD operations specified after the barrier with respect to
> the
> >      other components of the system."
> >
> > If above is the semantics that you are aiming for, then it is still
> irrelevant whether
> > the memory is Normal or Device. But other than that, I see no issues.
>
> The relevant part is that a Device access is usually a *slave* access
> while Normal memory access is a *master* one. The DMB only ensures the
> latter (as specified by the ARM ARM, though probably not very clear).
>
> I'm not sure whether the memory-barriers.txt doc covers all the usage in
> the kernel but the mandatory barriers (mb/rmb/wmb) may be used to
> control the effect of I/O accesses (as per the above document). On ARM,
> this needs to be DSB rather than DMB.
>
> I can even give examples where a DMB would fail with regards to Device
> memory.
>
> --
> Catalin
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110329/06e8ffc3/attachment-0001.html>
