From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 9 Feb 2017 13:14:52 -0500
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170209131414.098c848c@gandalf.local.home>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
 <20170209162956.GH27312@n2100.armlinux.org.uk>
 <20170209121322.5229e6cf@gandalf.local.home>
 <20170209180644.GJ27312@n2100.armlinux.org.uk>
 <20170209131414.098c848c@gandalf.local.home>
Message-ID: <20170209131452.472aa882@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[ sending again with Masami Cc'd ]

On Thu, 9 Feb 2017 13:14:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 9 Feb 2017 18:06:44 +0000
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Thu, Feb 09, 2017 at 12:13:22PM -0500, Steven Rostedt wrote:  
> > > Then came along live kernel patching, which I believe this series is
> > > trying to support. What is needed by pt_regs is a way to "hijack" the
> > > function being called to instead call the patched function. That is,
> > > ftrace is not being used for tracing, but in reality, being used to
> > > modify the running kernel. It is being used to change what function
> > > gets called. ftrace is just a hook for that mechanism.    
> > 
> > So, would I be correct to assume that the only parts of pt_regs that
> > would be touched are those which contain arguments to the function,
> > and the register which would contain the return value?
> >   
> 
> For live kernel patching, perhaps.
> 
> But for kprobes, I think they can touch anything. Matters what the
> creater of the kprobe wanted to do.
> 
> -- Steve
