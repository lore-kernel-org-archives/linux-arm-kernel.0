From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 Mar 2015 10:11:13 -0400
Subject: [RFC][PATCH] ring-buffer: Replace this_cpu_{read,write} with
 this_cpu_ptr()
In-Reply-To: <20150317081341.0f9a8b4c@gandalf.local.home>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
Message-ID: <20150317101113.32f5618a@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015 08:13:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > I may go and remove all this_cpu_read,write() calls from my code
> > > because of this.
> > 
> > You could do that with __this_cpo_* but not this_cpu_*(). Doing
> > it to this_cpu_* would make the operations no longer per cpu atomic. If
> > they do not need per cpu atomicity then you could have used __this_cpu_*
> > instead. And  __this_cpu_* do not disable preemption or interrupts.
> 
> I do not need it to be atomic.

I test this out with __this_cpu_* versions and see if that solves it
too. If it does, I'll use that version instead.

Thanks,

-- Steve
