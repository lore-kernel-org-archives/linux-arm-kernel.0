From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 2 Oct 2018 05:56:47 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <20181001175622.GT30658@n2100.armlinux.org.uk>
 <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
Message-ID: <CAHmME9ocfHx2BxCqor-hg0ida6mS7x9M3RU2rZdoaxk=s9bHTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Oct 2, 2018 at 5:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> So Arnd's suggestion to switch to armv3-m would actually be feasible
> then? The code in question does not use ldrh only umull, and so it
> should build with armv3m as well. And we will even generate some
> better code for RiscPC if we apply it to both the cflags and the
> asflags.

It turns out armv3m isn't a solution for the crypto code, since it
does other armv4-isms. So we'll need to find another solution for
that; I'm partial to my initial Kconfig one just doing "depends
!CPU_32V3".

With regards to RiscPC though, given that armv3 codegen might be
better, it sounds like it's a good idea to set -march=armv3m anyway
for the platform, irrespective of fixing the problem at hand here.

Regards,
Jason
