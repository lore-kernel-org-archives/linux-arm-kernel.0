From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 22 Nov 2010 14:33:07 -0500
Subject: [PATCH] ftrace/ARM: add ARM support for C version of recordmcount
In-Reply-To: <1290449586-1512-1-git-send-email-rabin@rab.in>
References: <1290449586-1512-1-git-send-email-rabin@rab.in>
Message-ID: <1290454387.30543.304.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-22 at 23:43 +0530, Rabin Vincent wrote:
> Depending on the compiler version, ARM GCC calls the mcount function
> either __gnu_mcount_nc or mcount.
> 
> Also, arch/arm/kernel/ftrace.c references mcount like
> kernel/tracing/ftrace.c, so change the exclusion filter to match any
> ftrace.c
> 

Could you separate that out into two patches. I think this is too much
of a "side effect" for a "add arch" patch.

Thanks,

-- Steve
