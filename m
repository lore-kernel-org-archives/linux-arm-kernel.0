From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Apr 2018 10:58:52 -0700
Subject: ARM compile failure in Re: linux-next: Tree for Apr 4
In-Reply-To: <20180404074856.GA9342@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
Message-ID: <20180404175852.GI5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180404 07:50]:
> Hi!
> 
> > Please do not add any v4.18 destined stuff to your linux-next included
> > trees until after v4.17-rc1 has been released.
> > 
> > Changes since 20180403:
> > 
> > The vfs tree still had its build failure for which I reverted a commit.
> > 
> > Non-merge commits (relative to Linus' tree): 8505
> >  8493 files changed, 392779 insertions(+), 275941 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> 
> When trying to build kernel for N900, I get:
> 
>   CC      lib/timerqueue.o
>     CC      lib/vsprintf.o
>     lib/string.c: In function 'strstr':
>     lib/string.c:478:8: error: inlining failed in call to
>     always_inline 'strlen': function not inlinable
>     lib/string.c:903:5: error: called from here
>     lib/string.c:478:8: error: inlining failed in call to
>     always_inline 'strlen': function not inlinable
>     lib/string.c:906:5: error: called from here
>     lib/string.c:855:15: error: inlining failed in call to
>     always_inline 'memcmp': function not inlinable
>     ...
> pavel at duo:/data/l/linux-next-n900$ git branch -l
> * (detached from next-20180403)
> 
> I'm using
> 
> eval ` eldk-switch.sh -r 5.4 armv7a`
> 
> for cross-compilation.

Hmm I'm not seeing build issues with next-20180404, did this somehow
already get sorted out?

Regards,

Tony
