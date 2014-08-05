From: keescook@chromium.org (Kees Cook)
Date: Tue, 5 Aug 2014 08:08:47 -0700
Subject: [PATCH v5 3/3] arm64: Add seccomp support
In-Reply-To: <53D2255C.9050006@linaro.org>
References: <1406020499-5537-1-git-send-email-takahiro.akashi@linaro.org>
 <1406020499-5537-4-git-send-email-takahiro.akashi@linaro.org>
 <53D082E9.8090303@amacapital.net> <53D09C4F.9010104@linaro.org>
 <CALCETrWTDS7VSyuR5wgGxpu-_YMWVUVmv9ht6t1tCSX=GA46cQ@mail.gmail.com>
 <53D2255C.9050006@linaro.org>
Message-ID: <CAGXu5jJL=zXuSRNomGrB09kqpUhEpkuxDH18JN4NRbWocMw4xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 2:37 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> I found a bug in my current patch (v5). When 32-bit tracer skips a system call,
> we should not update syscallno from x8 since syscallno is re-written directly
> via ptrace(PTRACE_SET_SYSCALL).

Ah, yes. Will aarch64 have a PTRACE_SET_SYSCALL option, or is this
strictly a 32-bit vs 64-bit issue?

> I'm sure that my next version should work with 32/64-bit tracers on 64-bit
> kernel.

Do you have a git tree uploaded anywhere? I'd love to follow this more
closely. When do you expect a v6?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
