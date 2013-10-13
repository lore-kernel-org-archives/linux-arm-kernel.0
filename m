From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Oct 2013 12:22:39 +0100
Subject: [PATCH v3 3/3] ARM: add support for bit sliced AES using NEON
 instructions
In-Reply-To: <CAKv+Gu81Bb8jzVUgyS_=meJNLQaxydLLRR-5n5gY8b-reofzUQ@mail.gmail.com>
References: <1380913419-13296-1-git-send-email-ard.biesheuvel@linaro.org>
 <1380913419-13296-4-git-send-email-ard.biesheuvel@linaro.org>
 <20131013100350.GZ25034@n2100.arm.linux.org.uk>
 <CAKv+Gu8gzRjOMhKoydR3DqMqHqREDC7ZHNn9AZcdxGOWE_N9Vw@mail.gmail.com>
 <20131013111457.GB25034@n2100.arm.linux.org.uk>
 <CAKv+Gu81Bb8jzVUgyS_=meJNLQaxydLLRR-5n5gY8b-reofzUQ@mail.gmail.com>
Message-ID: <20131013112239.GD25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 01:19:29PM +0200, Ard Biesheuvel wrote:
> On 13 October 2013 13:14, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Oct 13, 2013 at 12:21:49PM +0200, Ard Biesheuvel wrote:
> >> On 13 October 2013 12:03, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Oct 04, 2013 at 09:03:39PM +0200, Ard Biesheuvel wrote:
> >>
> >> [...]
> >>
> >> >> +#include <asm/neon.h>
> >> >> +#include <crypto/aes.h>
> >> >> +#include <crypto/ablk_helper.h>
> >> >
> >> > This header file doesn't appear to exist, and so causes this build error:
> >> >
> >>
> >> Hi Russell,
> >>
> >> This is expected.
> >>
> >> Perhaps I should have addressed this differently, but I had put the
> >> following in my pull request
> >>
> >> !! NOTE !!: this series build-depends on patch a62b01cd (crypto: create generic
> >> version of ablk_helper) which is in linux-next but not yet in mainline.
> >>
> >> expecting you to either defer pulling it or handle the
> >> cross-dependency in some other way.
> >
> > Where can I find that commit?
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/crypto?id=a62b01cd6cc1feb5e80d64d6937c291473ed82cb

I need a git tree I can pull with this commit in (and preferably without
much in the way of dependencies.)  Commits in linux-next are not deemed
to be stable.
