From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 4 Apr 2018 20:15:13 +0200
Subject: ARM compile failure in Re: linux-next: Tree for Apr 4
In-Reply-To: <20180404175852.GI5700@atomide.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd> <20180404175852.GI5700@atomide.com>
Message-ID: <20180404181513.GA29233@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Please do not add any v4.18 destined stuff to your linux-next included
> > > trees until after v4.17-rc1 has been released.
> > > 
> > > Changes since 20180403:
> > > 
> > > The vfs tree still had its build failure for which I reverted a commit.
> > > 
> > > Non-merge commits (relative to Linus' tree): 8505
> > >  8493 files changed, 392779 insertions(+), 275941 deletions(-)
> > > 
> > > ----------------------------------------------------------------------------
> > 
> > When trying to build kernel for N900, I get:
> > 
> >   CC      lib/timerqueue.o
> >     CC      lib/vsprintf.o
> >     lib/string.c: In function 'strstr':
> >     lib/string.c:478:8: error: inlining failed in call to
> >     always_inline 'strlen': function not inlinable
> >     lib/string.c:903:5: error: called from here
> >     lib/string.c:478:8: error: inlining failed in call to
> >     always_inline 'strlen': function not inlinable
> >     lib/string.c:906:5: error: called from here
> >     lib/string.c:855:15: error: inlining failed in call to
> >     always_inline 'memcmp': function not inlinable
> >     ...
> > pavel at duo:/data/l/linux-next-n900$ git branch -l
> > * (detached from next-20180403)
> > 
> > I'm using
> > 
> > eval ` eldk-switch.sh -r 5.4 armv7a`
> > 
> > for cross-compilation.
> 
> Hmm I'm not seeing build issues with next-20180404, did this somehow
> already get sorted out?

Let me check...

  CC      lib/vsprintf.o
  lib/string.c: In function 'strstr':
  lib/string.c:478:8: error: inlining failed in call to always_inline
  'strlen': function not inlinable

Same problem.

pavel at duo:~$ eval ` eldk-switch.sh -r 5.4 armv7a`
pavel at duo:~$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (GCC) 4.7.2

Best regards,								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/780b4b19/attachment.sig>
