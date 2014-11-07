From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 7 Nov 2014 11:52:25 -0500
Subject: [PATCH] arm: ftrace: Adds support for ftrace operations
In-Reply-To: <1415372352-15664-1-git-send-email-jjhiblot@traphandler.com>
References: <1415372352-15664-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20141107115225.72bc6cbf@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Nov 2014 15:59:11 +0100
Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:

> Hi all,
> 
> This patch adds support for ftrace operations on the ARM architecture.
> This support is needed by kgraft and possibly other ftrace-based tools.
> My goal is to have kgraft working on ARM and aarch64.

Can you add this to the change log of the patch. As that would be what
goes into git history. Because honestly, I had no idea what you meant
by "ftrace operations". If I don't understand that term, how can you
expect anyone else to?

> 
> I tested this patch with a toy implementation of kgraft for ARM and basic
> usage of function and function_graph tracers
> It doesn't show any problem with the ftrace selftests and the tests found
> today in branch ftrace/testing-mystuff of linux-trace repository
> (git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git)

Those tests are no where near what I have. Does this code work on the
beagle bone white? If so, I can probably run my full suite on it.

-- Steve

> 
> Jean-Jacques Hiblot (1):
>   arm: ftrace: Adds support for ftrace operations
> 
>  arch/arm/Kconfig               |  2 ++
>  arch/arm/include/asm/ftrace.h  |  3 ++
>  arch/arm/kernel/entry-common.S | 68 +++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/kernel/ftrace.c       | 34 +++++++++++++++++++++
>  4 files changed, 106 insertions(+), 1 deletion(-)
> 
