From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Oct 2013 17:18:47 +0100
Subject: [PATCH v2 1/3] arm64: check for number of arguments in
 syscall_get/set_arguments()
In-Reply-To: <1380779266-11753-2-git-send-email-takahiro.akashi@linaro.org>
References: <1380605584-22125-git-send-email-takahiro.akashi@linaro.org>
 <1380779266-11753-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20131003161846.GC7408@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 06:47:44AM +0100, AKASHI Takahiro wrote:
> In ftrace_syscall_enter(),
>     syscall_get_arguments(..., 0, n, ...)
>         if (i == 0) { <handle orig_x0> ...; n--;}
>         memcpy(..., n * sizeof(args[0]));
> If 'number of arguments(n)' is zero and 'argument index(i)' is also zero in
> syscall_get_arguments(), none of arguments should be copied by memcpy().
> Otherwise 'n--' can be a big positive number and unexpected amount of data
> will be copied. Tracing system calls which take no argument, say sync(void),
> may hit this case and eventually make the system corrupted.
> This patch fixes the issue both in syscall_get_arguments() and
> syscall_set_arguments().
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
