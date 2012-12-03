From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Dec 2012 14:12:51 +0000
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
In-Reply-To: <20121203133735.GG20074@mudshark.cambridge.arm.com>
References: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
 <20121203133735.GG20074@mudshark.cambridge.arm.com>
Message-ID: <20121203141251.GB14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 01:37:36PM +0000, Will Deacon wrote:
> It might be worth stashing the return value into a local variable prior to
> the ptrace_syscall_trace invocation, just in case a debugger decides to
> rewrite the child's registers.

And if so, ensure that there's a comment there explaining it, otherwise
the reasoning will get lost over time.
