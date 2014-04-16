From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 14:45:06 +0100
Subject: [PATCH v7 4/7] arm64: Add ftrace support
In-Reply-To: <1394862353-28963-5-git-send-email-takahiro.akashi@linaro.org>
References: <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862353-28963-5-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416134506.GD1001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 05:45:50AM +0000, AKASHI Takahiro wrote:
> This patch implements arm64 specific part to support function tracers,
> such as function (CONFIG_FUNCTION_TRACER), function_graph
> (CONFIG_FUNCTION_GRAPH_TRACER) and function profiler
> (CONFIG_FUNCTION_PROFILER).
> 
> With 'function' tracer, all the functions in the kernel are traced with
> timestamps in ${sysfs}/tracing/trace. If function_graph tracer is
> specified, call graph is generated.
> 
> The kernel must be compiled with -pg option so that _mcount() is inserted
> at the beginning of functions. This function is called on every function's
> entry as long as tracing is enabled.
> In addition, function_graph tracer also needs to be able to probe function's
> exit. ftrace_graph_caller() & return_to_handler do this by faking link
> register's value to intercept function's return path.
> 
> More details on architecture specific requirements are described in
> Documentation/trace/ftrace-design.txt.
> 
> Reviewed-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

I'm still slightly suspicious about the alignment of your ASCII art, but:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
