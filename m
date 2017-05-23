From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 May 2017 20:53:18 +0100
Subject: [PATCH] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1494623207-17195-1-git-send-email-abelvesa@gmail.com>
References: <1494623207-17195-1-git-send-email-abelvesa@gmail.com>
Message-ID: <20170523195318.GC22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 10:06:47PM +0100, Abel Vesa wrote:
> The DYNAMIC_FTRACE_WITH_REGS configuration makes it possible for a ftrace
> operation to specify if registers need to saved/restored by the ftrace handler.
> This is needed by kgraft and possibly other ftrace-based tools, and the ARM
> architecture is currently lacking this feature. It would also be the first step
> to support the "Kprobes-on-ftrace" optimization on ARM.
> 
> This patch introduces a new ftrace handler that stores the registers on the
> stack before calling the next stage. The registers are restored from the stack
> before going back to the instrumented function.
> 
> A side-effect of this patch is to activate the support for ftrace_modify_call()
> as it defines ARCH_SUPPORTS_FTRACE_OPS for the ARM architecture.

With the exception of the long lines in the commit message (please wrap
before column 72 so that 'git log' is readable on 80 column displays) 
I think this is fine.  Please amend the commit message and sent to the
patch system.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
