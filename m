From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 30 Nov 2016 14:10:11 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <583EC488.9010906@arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <583EC488.9010906@arm.com>
Message-ID: <20161130141011.GM1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 12:22:32PM +0000, Szabolcs Nagy wrote:
> On 30/11/16 12:06, Dave Martin wrote:
> > For setcontext/setjmp, we don't save/restore any SVE state due to the
> > caller-save status of SVE, and I would not consider it necessary to
> > save/restore VL itself because of the no-change-on-the-fly policy for
> > this.
> 
> the problem is not changing VL within a thread,
> but that setcontext can resume a context of a
> different thread which had different VL and there
> might be SVE regs spilled on the stack according
> to that.
> 
> (i consider this usage undefined, but at least
> the gccgo runtime does this)

Understood -- which is part of the reason for the argument that although
the kernel may permit different threads to have different VLs, whether
this actually works usefully also depends on your userspace runtime
environment.

This again leads me to the conclusion that the request to create threads
with different VLs within a single process should be explicit, in order
to avoid accidents.

Cheers
---Dave
