From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 6 Nov 2015 08:39:45 -0500
Subject: [PATCH v5 3/6] ftrace: allow arch-specific stack tracer
In-Reply-To: <1446792285-1154-4-git-send-email-takahiro.akashi@linaro.org>
References: <1446792285-1154-1-git-send-email-takahiro.akashi@linaro.org>
 <1446792285-1154-4-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20151106083945.6442b59b@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  6 Nov 2015 15:44:42 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> A stack frame may be used in a different way depending on cpu architecture.
> Thus it is not always appropriate to slurp the stack contents, as current
> check_stack() does, in order to calcurate a stack index (height) at a given
> function call. At least not on arm64.
> In addition, there is a possibility that we will mistakenly detect a stale
> stack frame which has not been overwritten.
> 
> This patch makes check_stack() a weak function so as to later implement
> arch-specific version.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Note, I already accepted this patch. I'll be pushing it to Linus today.

I also added a patch on top of it to rename max_stack_lock to
stack_trace_max_lock to stay consistent with the other global variables
used in this file. You may need to update your code to handle that.

-- Steve
