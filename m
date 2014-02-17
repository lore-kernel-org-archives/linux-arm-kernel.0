From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Feb 2014 17:42:48 +0000
Subject: [PATCH] arm64: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <CAKv+Gu_=kgP1LS-HN6n+QfHMyi142aNpGR0roqRo2tinYXdxPw@mail.gmail.com>
References: <1390768248-1688-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140217122334.GA19102@arm.com>
 <CAKv+Gu_=kgP1LS-HN6n+QfHMyi142aNpGR0roqRo2tinYXdxPw@mail.gmail.com>
Message-ID: <20140217174247.GA8361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 12:40:18PM +0000, Ard Biesheuvel wrote:
> On 17 February 2014 13:23, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Sun, Jan 26, 2014 at 08:30:48PM +0000, Ard Biesheuvel wrote:
> >> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> >> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> >> are used in stdint.h so its definitions of uint64_t and int64_t are
> >> compatible with those of the kernel.
> >>
> >> In order to do so, drop types.h from generic-y and create a specific arm64
> >> version identical to the generic one with just the #define overrides added.
> >
> > I tried but still can't get what this patch is about. Do the
> > linux/types.h types ever get to user space? We have uapi/linux/types.h
> > for this.
> >
> > Can you give an example of where this is needed? Which source file
> > includes both stdint.h and linux/types.h (non-uapi version)?
> 
> It's not about user space, it is mainly about the use of NEON
> instrinsics in the kernel.
> 
> If you do the following:
> 
> #Include <linux/types.h>
> #include <arm_neon.h>

For other intrinsics that we use like __builtin_ctzl(), do we need to
explicitly include gcc headers? I don't think we do and I really don't
like such arm_neon.h include which brings in other user headers. Don't
we have any work around this?

My inbox only has some discussion in May last year on the linaro-kernel
list without any clear conclusion (it could be that I deleted other
emails).

-- 
Catalin
