From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Tue, 23 Sep 2014 21:43:27 +0200
Subject: [PATCH] atomic_read: Use ACCESS_ONCE() instead of cast to volatile
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
Message-ID: <20140923194327.GA5940@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Tue 23 Sep 2014 10:29:50 -0400 or thereabout, Pranith Kumar wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/alpha/include/asm/atomic.h    | 4 ++--
>  arch/arm/include/asm/atomic.h      | 2 +-
>  arch/arm64/include/asm/atomic.h    | 4 ++--
>  arch/avr32/include/asm/atomic.h    | 2 +-

For the AVR32 related part.

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

>  arch/cris/include/asm/atomic.h     | 2 +-
>  arch/frv/include/asm/atomic.h      | 2 +-
>  arch/ia64/include/asm/atomic.h     | 4 ++--
>  arch/m32r/include/asm/atomic.h     | 2 +-
>  arch/m68k/include/asm/atomic.h     | 2 +-
>  arch/mips/include/asm/atomic.h     | 4 ++--
>  arch/parisc/include/asm/atomic.h   | 4 ++--
>  arch/sh/include/asm/atomic.h       | 2 +-
>  arch/sparc/include/asm/atomic_32.h | 2 +-
>  arch/sparc/include/asm/atomic_64.h | 4 ++--
>  arch/x86/include/asm/atomic.h      | 2 +-
>  arch/x86/include/asm/atomic64_64.h | 2 +-
>  arch/xtensa/include/asm/atomic.h   | 2 +-
>  include/asm-generic/atomic.h       | 2 +-
>  18 files changed, 24 insertions(+), 24 deletions(-)

<snipp diff>

-- 
BR, HcE
