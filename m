From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Oct 2016 11:12:08 +0100
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
 <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
 <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
Message-ID: <20161004101208.GA18083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 03:20:57PM -0400, bdegraaf at codeaurora.org wrote:
> On 2016-10-01 14:11, Mark Rutland wrote:
> >Hi Brent,
> >
> >Evidently my questions weren't sufficiently clear; even with your
> >answers it's not clear to me what precise issue you're attempting to
> >solve.  I've tried to be more specific this time.
> >
> >At a high-level, can you clarify whether you're attempting to solve is:
> >
> >(a) a functional correctness issue (e.g. data corruption)
> >(b) a performance issue
> >
> >And whether this was seen in practice, or found through code
> >inspection?

> Thinking about this, as the reader/writer code has no known "abuse"
> case, I'll remove it from the patchset, then provide a v2 patchset
> with a detailed explanation for the lockref problem using the commits
> you provided as an example, as well as performance consideration.

If there's a functional problem, let's consider that in isolation first.
Once we understand that, then we can consider doing what is optimal.

As should be obvious from the above, I'm confused because this patch
conflates functional details with performance optimisations which (to
me) sound architecturally dubious.

I completely agree with Peter that if the problem lies with lockref, it
should be solved in the lockref code.

Thanks,
Mark.
