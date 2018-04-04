From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Apr 2018 12:59:51 -0700
Subject: ARM compile failure in Re: linux-next: Tree for Apr 4
In-Reply-To: <20180404184622.GA8608@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd> <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
Message-ID: <20180404195951.GJ5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180404 18:47]:
> Hi!
> 
> > > When trying to build kernel for N900, I get:
> > > 
> > >   CC      lib/timerqueue.o
> > >     CC      lib/vsprintf.o
> > >     lib/string.c: In function 'strstr':
> > >     lib/string.c:478:8: error: inlining failed in call to
> > >     always_inline 'strlen': function not inlinable
> > >     lib/string.c:903:5: error: called from here
> > >     lib/string.c:478:8: error: inlining failed in call to
> > >     always_inline 'strlen': function not inlinable
> > >     lib/string.c:906:5: error: called from here
> > >     lib/string.c:855:15: error: inlining failed in call to
> > >     always_inline 'memcmp': function not inlinable
> > >     ...
> > > pavel at duo:/data/l/linux-next-n900$ git branch -l
> > > * (detached from next-20180403)
> > > 
> > > I'm using
> > > 
> > > eval ` eldk-switch.sh -r 5.4 armv7a`
> > > 
> > > for cross-compilation.
> > 
> > Hmm I'm not seeing build issues with next-20180404, did this somehow
> > already get sorted out?
> 
> It seems it is config-dependend. omap2plus_defconfig compiles ok for
> me.
> 
> Can you try with attached .config?

That still builds for me. This with plain gcc-7.3.0 binutils-2.30
built with buildall script.

Regards,

Tony
