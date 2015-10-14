From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 14 Oct 2015 15:58:29 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014135005.GS11639@twins.programming.kicks-ass.net>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014102706.GR14956@sirena.org.uk>
 <20151014110717.GT17308@twins.programming.kicks-ass.net>
 <20151014123624.GV14956@sirena.org.uk>
 <20151014134721.GD3816@twins.programming.kicks-ass.net>
 <20151014135005.GS11639@twins.programming.kicks-ass.net>
Message-ID: <20151014135829.GA10942@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 14, 2015 at 03:47:21PM +0200, Peter Zijlstra wrote:
> > ---
> >  Documentation/locking/lockdep-design.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
> > index 5001280e9d82..e8e9ad4e6f5e 100644
> > --- a/Documentation/locking/lockdep-design.txt
> > +++ b/Documentation/locking/lockdep-design.txt
> > @@ -24,6 +24,10 @@ a lock-class is used for the first time after bootup it gets registered,
> >  and all subsequent uses of that lock-class will be attached to this
> >  lock-class.
> >  
> > +A class is typically associated with a lock's initialisation site; although
> > +its possible to explicitly initialize a lock with a different class key --
> > +such class keys much come from static storage.
> 
> Now if only I could actually type: s/much/must/

also:

   s/its/it's

:-)

Thanks,

	Ingo
