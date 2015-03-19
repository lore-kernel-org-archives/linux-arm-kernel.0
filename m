From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 19 Mar 2015 12:40:23 -0400
Subject: [PATCH v2] ring-buffer: Replace this_cpu_*() with __this_cpu_*()
In-Reply-To: <alpine.DEB.2.11.1503191130330.27377@gentwo.org>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
 <20150317101113.32f5618a@gandalf.local.home>
 <20150317104038.312e73d1@gandalf.local.home>
 <20150317144701.GJ10068@pengutronix.de>
 <20150317110750.2a0e2b73@gandalf.local.home>
 <alpine.DEB.2.11.1503191120310.26866@gentwo.org>
 <alpine.DEB.2.11.1503191130330.27377@gentwo.org>
Message-ID: <20150319124023.4c1b1094@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015 11:33:30 -0500 (CDT)
Christoph Lameter <cl@linux.com> wrote:

> If you are redoing it then please get the comments a bit cleared up. The

What comments should I clear up? This version did not have a comment.
It just switched this_cpu_* to __this_cpu_*, and also updated a
variable algorithm.

-- Steve


> heaviness of the fallback version of this_cpu_read/write can usually
> easily be remedied by arch specific definitions. The per cpu
> offset is somewhere in a register and one needs to define a macro that
> creates an instruction that does a fetch from that register plus
> the current offset into the area that is needed. This is similarly easy
> for the write path. But then its often easier to just use the __this_cpu
> instructions since preemption is often off in these code paths.
> 
> I have had code for IA64 in the past that does this.
