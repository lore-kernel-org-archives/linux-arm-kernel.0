From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 26 Feb 2015 15:39:28 -0800
Subject: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
In-Reply-To: <CAGXu5jJ8UM5J58CpBwP=+kHi9td0mKP0SV36HjpckEjxCzm45g@mail.gmail.com>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
 <CAGXu5jJ8UM5J58CpBwP=+kHi9td0mKP0SV36HjpckEjxCzm45g@mail.gmail.com>
Message-ID: <20150226153928.1df44df8a0d885fa71c471ce@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015 15:34:36 -0800 Kees Cook <keescook@chromium.org> wrote:

> >> That pointless repetition should be avoided.
> >
> > That's surprisingly hard!
> >
> > After renaming mips brk_rnd() to mmap_rnd() I had a shot.  I'm not very
> > confident in the result.  Does that __weak trick even work?
> 
> In theory, it shouldn't be needed since only randomize_et_dyn will
> call mmap_rnd, and only architectures that use randomize_et_dyn will
> call it ... and will define mmap_rnd.

But randomize_et_dyn() is compiled for all architectures.  Or it was,
until I did the CONFIG_ARCH_HAVE_ELF_ASLR thing.

It seems odd that we have this per-arch feature but no Kconfig switch
for it.
