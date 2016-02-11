From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Feb 2016 14:40:24 +0000
Subject: [PATCH v2 0/2] Misc ARM optimizations
In-Reply-To: <1453980229-5678-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453980229-5678-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160211144023.GI32084@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:23:47PM +0100, Thomas Petazzoni wrote:
> Here is a set of two patches that I already sent on March 2015 (first
> patch) and June 2015 (second patch).
> 
> The first patch hasn't gotten any feedback.
> 
> The second patch received some feedback: Russell said he would like
> this to be merged at the beginning of a cycle, to give it enough time
> for testing. And we are precisely at the beginning of a cycle :-) Rob
> Herring had some comments, which I also addressed in a reply.
> 
> Would it be possible to either get those patches merged, or a decision
> be taken that they are not acceptable, so that I can stop worrying
> about them ? :-)

There's a PL310 erratum [(729806) Speculative reads from the Cortex-A9
MPCore processor can cause deadlock] that requires both speculative
linefills and L1 prefetch to be disabled, otherwise there is scope for
deadlock.

So, these need to be predicated on a Kconfig option if nothing else,
otherwise we may run into nasty regressions on things like OMAP4 (and
anything else with PL310 r3p0 afaict).

Will
