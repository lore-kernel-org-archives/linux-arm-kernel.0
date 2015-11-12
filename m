From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 12 Nov 2015 10:49:13 -0500
Subject: [PATCH] sched/rt: hide push_irq_work_func declaration
In-Reply-To: <4129441.9nXLnMzV6v@wuerfel>
References: <3810009.VdDTV0h1Qp@wuerfel>
 <20151112094739.0168e191@gandalf.local.home>
 <4129441.9nXLnMzV6v@wuerfel>
Message-ID: <20151112104913.4f68a92c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Nov 2015 16:14:06 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 12 November 2015 09:47:39 Steven Rostedt wrote:
> > > -#ifdef CONFIG_SMP
> > > +#if IS_ENABLED(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)  
> > 
> > Why IS_ENABLED() and not defined()?
> >
> > #if defined(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
> > 
> > I thought IS_ENABLED() is used for C code, like:
> > 
> >         if (IS_ENABLED(CONFIG_SMP)) {
> >                 [...]
> >         }  
> 
> "#if IS_ENABLED(CONFIG_foo)" has another property, which is
> to evaluate to true when Kconfig has set the symbol to "=m".
> Obviously that cannot happen for CONFIG_SMP, but some
> maintainers prefer using IS_ENABLED() consistently for all
> config symbols.
> 
> I don't care much either way, and it's easily changed if
> we still want the patch and you prefer a plain #if defined().
> 

For this instance, I do prefer the "defined()" version. I can
understand the IS_ENABLED() for module configs. But I don't see the
need to make all #if's use it. Maybe because I don't deal with module
configs much.

Anyway, this patch should probably go in now as a current "fix", and
the redesign should be looked at as well, but that's unrelated to your
arch, and you shouldn't need to worry about it.

Thanks,

-- Steve
