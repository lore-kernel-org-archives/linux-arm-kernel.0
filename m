From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 30 Oct 2014 07:10:39 -0400
Subject: [PATCH] tracing/syscalls: ignore numbers outside NR_syscalls'
 range
In-Reply-To: <20141030101808.GO27405@n2100.arm.linux.org.uk>
References: <1414620418-29472-1-git-send-email-rabin@rab.in>
 <20141030082606.GA7945@infradead.org>
 <20141030101808.GO27405@n2100.arm.linux.org.uk>
Message-ID: <20141030071039.37633bf5@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Oct 2014 10:18:08 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Oct 30, 2014 at 01:26:06AM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 29, 2014 at 11:06:58PM +0100, Rabin Vincent wrote:
> > > ARM has some private syscalls (for example, set_tls(2)) which lie
> > > outside the range of NR_syscalls.  If any of these are called while
> > > syscall tracing is being performed, out-of-bounds array access will
> > > occur in the ftrace and perf sys_{enter,exit} handlers.
> > 
> > While this patch looks like good caution, having syscalls outside of
> > NR_syscalls seems like a receipe for a disaster.  Can you try to fix
> > that issue as ell, please?
> 
> No.  We've had them since the inception of Linux on ARM.  They predate
> this tracing crap by more than a decade.  We're not changing them
> because that would be a massive user API breakage.
> 

Since syscall tracing is only broken on ARM, then the fix needs to be
ARM specific, and not remove the check for all other architectures that
have a sane NR_syscalls variable.

-- Steve
