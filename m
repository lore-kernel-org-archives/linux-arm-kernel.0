From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Aug 2014 10:24:09 +0100
Subject: [PATCH v5 3/3] arm64: Add seccomp support
In-Reply-To: <53E47DCE.4080902@linaro.org>
References: <1406020499-5537-1-git-send-email-takahiro.akashi@linaro.org>
 <1406020499-5537-4-git-send-email-takahiro.akashi@linaro.org>
 <53D082E9.8090303@amacapital.net> <53D09C4F.9010104@linaro.org>
 <CALCETrWTDS7VSyuR5wgGxpu-_YMWVUVmv9ht6t1tCSX=GA46cQ@mail.gmail.com>
 <53D2255C.9050006@linaro.org>
 <CAGXu5jJL=zXuSRNomGrB09kqpUhEpkuxDH18JN4NRbWocMw4xg@mail.gmail.com>
 <53E47DCE.4080902@linaro.org>
Message-ID: <20140811092409.GE15344@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 08:35:42AM +0100, AKASHI Takahiro wrote:
> On 08/06/2014 12:08 AM, Kees Cook wrote:
> > On Fri, Jul 25, 2014 at 2:37 AM, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> >> I found a bug in my current patch (v5). When 32-bit tracer skips a system call,
> >> we should not update syscallno from x8 since syscallno is re-written directly
> >> via ptrace(PTRACE_SET_SYSCALL).
> >
> > Ah, yes. Will aarch64 have a PTRACE_SET_SYSCALL option, or is this
> > strictly a 32-bit vs 64-bit issue?
> 
> As discussed in a few weeks ago, aarch64 won't support PTRACE_SET_SYSCALL.

Well, I don't think anything was set in stone. If you have a compelling
reason why adding the new request gives you something over setting w8
directly, then we can extend ptrace.

Will
