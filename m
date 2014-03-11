From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Mar 2014 14:35:36 +0000
Subject: [PATCH v5 0/7] arm64: Add ftrace support
In-Reply-To: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393320196-2942-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140311143535.GE7944@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Fri, Feb 28, 2014 at 05:18:37AM +0000, AKASHI Takahiro wrote:
> This patchset implements a function tracer on arm64.
> There was another implementation from Cavium network, but both of us agreed
> to use my patchset as future base. He is supposed to review this code, too.
> 
> The only issue that I had some concern on was "fault protection" code
> in prepare_ftrace_return(). With discussions with Steven and Tim (as author
> of arm ftrace), I removed that code since I'm not quite sure about possibility
> of "fault" occurrences in this function.
> 
> The code is tested on ARMv8 Fast Model with the following tracers & events:
>      function tracer with dynamic ftrace
>      function graph tracer with dynamic ftrace
>      syscall tracepoint
>      irqsoff & preemptirqsoff (which use CALLER_ADDRx)
> and also verified with in-kernel tests, FTRACE_SELFTEST, FTRACE_STARTUP_TEST
> and EVENT_TRACE_TEST_SYSCALLS.
> 
> Prerequisites are:
>  * "arm64: Add regs_return_value() in syscall.h"
>  * "arm64: make a single hook to syscall_trace() for all syscall features" patch

It looks like there might be some more dependencies that that. Do you have a
branch anywhere containing this series, along with all the dependencies so I
can have a play?

Cheers,

Will
