From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 5 May 2018 11:32:37 +0200
Subject: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
In-Reply-To: <CACT4Y+Z1WKxdkodRBc5PzfyQQmfJCJ3n1JyQc-+WCkqGZeg5Wg@mail.gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <CACT4Y+Z1WKxdkodRBc5PzfyQQmfJCJ3n1JyQc-+WCkqGZeg5Wg@mail.gmail.com>
Message-ID: <20180505093237.GD12217@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2018 at 11:05:51AM +0200, Dmitry Vyukov wrote:
> On Sat, May 5, 2018 at 10:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > And I seriously hate this one:
> >
> >   ba1c9f83f633 ("locking/atomic/x86: Un-macro-ify atomic ops implementation")
> >
> > and will likely undo that the moment I need to change anything there.

> That was asked by Ingo:
> https://groups.google.com/d/msg/kasan-dev/3sNHjjb4GCI/Xz1uVWaaAAAJ
> 
> I think in the end all of current options suck in one way or another,
> so we are just going in circles.

Yeah, and I disagree with him, but didn't have the energy to fight at
that time (and still don't really, I'm just complaining).

> We either need something different (e.g. codegen), or settle on one
> option for doing it.

Codegen I think is the only sensible option at this point for all the
wrappers. The existing ones (without the annotation muck) were already
cumbersome, the annotation stuff just makes it completely horrid.
