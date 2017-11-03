From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Nov 2017 12:06:04 +0000
Subject: [PATCH v2 1/3] arm64: Fix static use of function graph
In-Reply-To: <1509709458-44541-2-git-send-email-julien.thierry@arm.com>
References: <1509709458-44541-1-git-send-email-julien.thierry@arm.com>
 <1509709458-44541-2-git-send-email-julien.thierry@arm.com>
Message-ID: <20171103120603.GA11628@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:44:16AM +0000, Julien Thierry wrote:
> Function graph does not work currently when CONFIG_DYNAMIC_TRACE is not
> set. This is because ftrace_function_trace is not always set to ftrace_stub
> when function_graph is in use.
> 
> Do not skip checking of graph tracer functions when ftrace_function_trace
> is set.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Reviewed-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> ---
>  arch/arm64/kernel/entry-ftrace.S | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Thanks, applied. I assume you'll route the other two patches via their
respective trees.

Will
