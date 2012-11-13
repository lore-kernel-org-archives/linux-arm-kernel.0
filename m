From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 13 Nov 2012 11:23:20 -0800
Subject: [PATCH v5 0/4] arch/arm: support seccomp
In-Reply-To: <1352587485-18348-1-git-send-email-keescook@chromium.org>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
Message-ID: <50A29E28.5040303@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2012 02:44 PM, Kees Cook wrote:
> This adds support for seccomp BPF to ARM. When built with the seccomp
> improvement patch waiting in linux-next ("seccomp: Make syscall skipping
> and nr changes more consistent"), this passes the seccomp regression
> test suite: https://github.com/redpig/seccomp

I don't know if this matters much on ARM, but should something like
https://git.kernel.org/?p=linux/kernel/git/luto/linux.git;a=commit;h=dee1ae5a05149f30baeccb4b8f68f22525ba9ca2
be added?

--Andy

> 
> Thanks,
> 
> -Kees
> 
> ---
> v5:
>  - clean up seccomp failure path, as requested by Will Deacon.
> v4:
>  - fixed syscall_get_arch, thanks to Will Deacon.
> v3:
>  - updates suggested by Russell King:
>    - reduced scope of expansion
>    - leveraged TIF_SYSCALL_WORK bit mask
>    - fixed syscall==-1 short-circuit logic
> v2:
>  - expanded ptrace_syscall_trace() into both callers and do
>    secure_computing() hookup there, as requested by Al Viro.
> 
