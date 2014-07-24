From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 16:16:28 +0100
Subject: [PATCH v5 3/3] arm64: Add seccomp support
In-Reply-To: <CALCETrWTDS7VSyuR5wgGxpu-_YMWVUVmv9ht6t1tCSX=GA46cQ@mail.gmail.com>
References: <1406020499-5537-1-git-send-email-takahiro.akashi@linaro.org>
 <1406020499-5537-4-git-send-email-takahiro.akashi@linaro.org>
 <53D082E9.8090303@amacapital.net> <53D09C4F.9010104@linaro.org>
 <CALCETrWTDS7VSyuR5wgGxpu-_YMWVUVmv9ht6t1tCSX=GA46cQ@mail.gmail.com>
Message-ID: <20140724151628.GH13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 04:00:03PM +0100, Andy Lutomirski wrote:
> On Jul 23, 2014 10:40 PM, "AKASHI Takahiro" <takahiro.akashi@linaro.org> wrote:
> > when I implemented audit for arm64, the assumptions were
> > * If userspace is LE, then the kernel is also LE and if BE, then the kernel is BE.
> > * the syscall numbers and how arguments are encoded are the same btw BE and LE.
> > So syscall_get_arch() always return the same value.
> 
> If arm64 ever adds support for mixed-endian userspace, this could
> become awkward.  Hmm.

I really doubt we would ever support mixed endian user space. Too many
problems with translating syscalls, futexes (someone looked into this
and gave up eventually).

-- 
Catalin
