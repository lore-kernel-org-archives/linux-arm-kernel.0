From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 19 Feb 2013 14:00:35 -0800
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219215432.GP20312@moon>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org> <5123444D.6000806@suse.cz>
 <20130219093154.GF20312@moon> <5123BC2B.6000304@zytor.com>
 <20130219182838.GL20312@moon>
 <20130219134256.f4cedf44.akpm@linux-foundation.org>
 <20130219215432.GP20312@moon>
Message-ID: <20130219140035.373ce4d2.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Feb 2013 01:54:32 +0400
Cyrill Gorcunov <gorcunov@openvz.org> wrote:

> On Tue, Feb 19, 2013 at 01:42:56PM -0800, Andrew Morton wrote:
> > > Index: linux-2.6.git/kernel/Makefile
> > > ===================================================================
> > > --- linux-2.6.git.orig/kernel/Makefile
> > > +++ linux-2.6.git/kernel/Makefile
> > > @@ -25,9 +25,7 @@ endif
> > >  obj-y += sched/
> > >  obj-y += power/
> > >  
> > > -ifeq ($(CONFIG_CHECKPOINT_RESTORE),y)
> > > -obj-$(CONFIG_X86) += kcmp.o
> > > -endif
> > > +obj-$(CONFIG_KCMP) += kcmp.o
> > >  obj-$(CONFIG_FREEZER) += freezer.o
> > >  obj-$(CONFIG_PROFILING) += profile.o
> > >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> > 
> > This permits people to select kcmp with CONFIG_CHECKPOINT_RESTORE=n. 
> > Is there any point in doing that?
> > 
> > What would be wrong with just doing
> > 
> > 	obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
> 
> I think this syscall is usefull even without c/r stuff.
> That's why I made it with separate config option.

hm, OK.

But the patch also permits CONFIG_CHECKPOINT_RESTORE=y, CONFIG_KCMP=n
which surely isn't something which CRIU wants to support?
