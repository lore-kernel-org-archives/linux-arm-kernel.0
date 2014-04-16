From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 14:27:16 +0100
Subject: [PATCH v5 2/4] arm64: split syscall_trace() into separate
 functions for enter/exit
In-Reply-To: <1394861948-28712-3-git-send-email-takahiro.akashi@linaro.org>
References: <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
 <1394861948-28712-1-git-send-email-takahiro.akashi@linaro.org>
 <1394861948-28712-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416132716.GA1001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Sat, Mar 15, 2014 at 05:39:06AM +0000, AKASHI Takahiro wrote:
> As done in arm, this change makes it easy to confirm we invoke syscall
> related hooks, including syscall tracepoint, audit and seccomp which would
> be implemented later, in correct order. That is, undoing operations in the
> opposite order on exit that they were done on entry.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

[...]

> +static void tracehook_report_syscall(struct pt_regs *regs,
> +				     enum ptrace_syscall_dir dir)
>  {
> +	int scrach;

s/scrach/scratch/

Although, I'd rather have a variable with a more meaningful name. How about
regno?

With that,

  Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
