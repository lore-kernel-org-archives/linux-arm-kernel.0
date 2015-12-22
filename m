From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Dec 2015 09:48:44 +0000
Subject: [PATCH v7 5/6] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <5678F07F.8030308@linaro.org>
References: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
 <1450168424-10010-6-git-send-email-takahiro.akashi@linaro.org>
 <20151221120438.GI23092@arm.com> <5678F07F.8030308@linaro.org>
Message-ID: <20151222094844.GA32623@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 03:41:03PM +0900, AKASHI Takahiro wrote:
> On 12/21/2015 09:04 PM, Will Deacon wrote:
> >On Tue, Dec 15, 2015 at 05:33:43PM +0900, AKASHI Takahiro wrote:
> >>Regarding a function prologue analyzer, there is no guarantee that we can
> >>handle all the possible patterns of function prologue as gcc does not use
> >>any fixed templates to generate them. 'Instruction scheduling' is another
> >>issue here.
> >
> >Have you run this past any of the GCC folks?  It would be good to at least
> >make them aware of the heuristics you're using and the types of prologue
> >that we can handle. They even have suggestions to improve on your approach
> >(e.g. using -fstack-usage).
> 
> Yeah, I can, but do you mind my including you in CC?
> 'cause I don't know what kind of comments you are expecting.

Sure, I'd be interested to be on Cc. I suspect they will say "we don't
guarantee frame layout, why can't you use -fstack-usage?", to which I
don't have a good answer.

Basically, I don't think a heuristic-based unwinder is supportable in
the long-term, so we need a plan to have unwinding support when building
under future compilers without having to pile more heuristics into this
code. If we have a plan that the compiler guys sign up to, then I'm ok
merging something like you have already as a stop-gap.

Make sense?

Will
