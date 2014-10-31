From: joe@perches.com (Joe Perches)
Date: Fri, 31 Oct 2014 00:58:09 -0700
Subject: [RFC] arm:remove clear_thread_flag(TIF_UPROBE)
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D1827C@CNBJMBX05.corpusers.net>
References: <1414392371.8884.2.camel@perches.com>
 <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825F@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18260@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18261@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18264@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18265@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18266@CNBJMBX05.corpusers.net>
 <20141030120127.GC32589@arm.com>
 <CAKv+Gu9g5Q6fjPUy+P8YxkeDrH+bdO4kKGnxTQZRFhQpgPxaPA@mail.gmail.com>
 <20141030135749.GE32589@arm.com>
 <35FD53F367049845BC99AC72306C23D103E010D18272@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18273@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18275@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D1827B@CNBJMBX05.corpusers.net>
 <1414741535.8928.2.camel@perches.com>
 <35FD53F367049845BC99AC72306C23D103E010D1827C@CNBJMBX05.corpusers.net>
Message-ID: <1414742289.8928.5.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-31 at 15:51 +0800, Wang, Yalin wrote:
> > From: Joe Perches [mailto:joe at perches.com]
> > > diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> > []
> > > @@ -591,10 +591,9 @@ do_work_pending(struct pt_regs *regs, unsigned int
> > thread_flags, int syscall)
> > >  					return restart;
> > >  				}
> > >  				syscall = 0;
> > > -			} else if (thread_flags & _TIF_UPROBE) {
> > > -				clear_thread_flag(TIF_UPROBE);
> > > +			} else if (thread_flags & _TIF_UPROBE)
> > >  				uprobe_notify_resume(regs);
> > > -			} else {
> > > +			else {
> > >  				clear_thread_flag(TIF_NOTIFY_RESUME);
> > >  				tracehook_notify_resume(regs);
> > >  			}
> > 
> > Please keep the braces.
> 
> mm..  could I know the reason ?  :)

Try read Documentation/CodingStyle

		Chapter 3: Placing Braces and Spaces

use braces in both branches:

if (condition) {
	do_this();
	do_that();
} else {
	otherwise();
}
