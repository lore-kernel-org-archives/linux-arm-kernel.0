From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 11 Mar 2014 08:31:07 -0400
Subject: [PATCH] arm: LLVMLinux: use static inline in ARM ftrace.h
In-Reply-To: <531EB4D8.6030207@converseincode.com>
References: <1392949370-26422-1-git-send-email-behanw@converseincode.com>
 <531EB4D8.6030207@converseincode.com>
Message-ID: <20140311083107.6aa2bba4@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Mar 2014 00:01:44 -0700
Behan Webster <behanw@converseincode.com> wrote:

> On 02/20/14 18:22, behanw at converseincode.com wrote:
> > From: Behan Webster <behanw@converseincode.com>
> >
> > With compilers which follow the C99 standard (like modern versions of gcc and
> > clang), "extern inline" does the wrong thing (emits code for an externally
> > linkable version of the inline function). In this case using static inline
> > and removing the NULL version of return_address in return_address.c does
> > the right thing.
> Any input? Is it good as it is?

I'm fine with it. But you need approval from the arm folks. I know
there was some issues with the return_address() code in the past. But
from the ftrace perspective:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
