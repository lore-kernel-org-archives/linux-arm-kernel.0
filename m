From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Nov 2014 18:43:44 +0000
Subject: [PATCH v10 0/6] arm64: add seccomp support
In-Reply-To: <1417152399-32717-1-git-send-email-takahiro.akashi@linaro.org>
References: <1417152399-32717-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20141128184344.GA3968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 05:26:33AM +0000, AKASHI Takahiro wrote:
> This patch series enables secure computing (system call filtering) on arm64,
> and contains related enhancements and bug fixes.
> 
>   NOTE: This versions contain a workaround against possible BUG_ON() failure
>   at audit_syscall_exit(), but doesn't contain an extra optimization, as I
>   submitted for arm, of excluding syscall enter/exit tracing against invalid
>   system calls due to an issue that I reported in:
>        http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/292170.html
> 
> The code was tested on ARMv8 fast model with 64-bit/32-bit userspace using:
>  * libseccomp v2.1.1 with modifications for arm64, especially its "live"
>    tests: No.20, 21 and 24.
>  * modified version of Kees' seccomp test for 'changing/skipping a syscall'
>    and seccomp() system call
>  * in-house tests for 'changing/skipping a system call' by tracing with
>    ptrace(SETREGSET, NT_SYSTEM_CALL) (that is, not via seccomp filter)'
> with and without audit tracing.
> 
> 
> Changes v9 -> v10:
> * modified system_call_get() for big-endian build [1/6]
> * modified the way to check for syscall(-1) on syscall entry [2/6]

Applied, thanks.

Will
