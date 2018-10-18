From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 18 Oct 2018 12:59:48 -0400
Subject: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <20181018162548.6399-3-changbin.du@gmail.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
 <20181018162548.6399-3-changbin.du@gmail.com>
Message-ID: <20181018125948.789c72de@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2018 16:25:46 +0000
Du Changbin <changbin.du@gmail.com> wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
> 
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I have acked patch this before, but this particular patch has extra
changes that I have not acked.



> +config ENABLE_WARN_DEPRECATED
> +	bool "Enable __deprecated logic"
> +	default y
> +	help
> +	  Enable the __deprecated logic in the kernel build.
> +	  Disable this to suppress the "warning: 'foo' is deprecated
> +	  (declared at kernel/power/somefile.c:1234)" messages.
> +

What is that?

-- Steve
