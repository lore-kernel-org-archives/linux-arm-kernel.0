From: keescook@chromium.org (Kees Cook)
Date: Wed, 14 Nov 2012 11:07:13 -0800
Subject: [PATCH v5 0/4] arch/arm: support seccomp
In-Reply-To: <1352587485-18348-1-git-send-email-keescook@chromium.org>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
Message-ID: <CAGXu5jKYGCkL3GS4Tbep==WUAqP-c_0edAdgy0XQ84rJxZUU2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, any more thoughts on this series? I'd really like to get it into
-next. It's been running happily for a while now in the Chrome OS ARM
devices.

Thanks,

-Kees

On Sat, Nov 10, 2012 at 2:44 PM, Kees Cook <keescook@chromium.org> wrote:
> This adds support for seccomp BPF to ARM. When built with the seccomp
> improvement patch waiting in linux-next ("seccomp: Make syscall skipping
> and nr changes more consistent"), this passes the seccomp regression
> test suite: https://github.com/redpig/seccomp
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

-- 
Kees Cook
Chrome OS Security
