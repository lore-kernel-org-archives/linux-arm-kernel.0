From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Wed, 30 Nov 2016 12:22:32 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161130120654.GJ1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
Message-ID: <583EC488.9010906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/16 12:06, Dave Martin wrote:
> For setcontext/setjmp, we don't save/restore any SVE state due to the
> caller-save status of SVE, and I would not consider it necessary to
> save/restore VL itself because of the no-change-on-the-fly policy for
> this.

the problem is not changing VL within a thread,
but that setcontext can resume a context of a
different thread which had different VL and there
might be SVE regs spilled on the stack according
to that.

(i consider this usage undefined, but at least
the gccgo runtime does this)
