From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 23 Jul 2013 18:40:18 +0100
Subject: updates for be8 patch series
In-Reply-To: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
Message-ID: <51EEC002.9070808@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 18:24, Victor Kamensky wrote:
> Hi Ben,
>
> Wrt BE8 little endian instructions you will need to fix couple more places:
>      ftrace arch/arm/kernel/ftrace.c
>      kprobes arch/arm/kernel/kprobes.c
> Also in big endian mode atomic64_xxx function will need fixes, otherwise
> perf
> counters will be truncated on max of 32bit values
>      atomic64 arch/arm/include/asm/atomic.h

Hmm, thought ftrace already did the right endian-ness conversions,
although it is possible it could have missed one.

The atomic instructions should work fine for BE8, they're using
STRD which should be correct.

> I've attached board independent (core) patch from my work that made
> Pandaboard ES
> kernel run in BE mode. You can check my version of fixes for above
> issues in the
> patch. Look for corresponding files changes. Please rework them
> according to style
> and rules of your patch series. Note the patch itself contains fixes for
> few other
> issues that already fixed in your series. I'll cross check and compare
> individual
> areas latter. I think you may find attached patch interesting as well,
> it was developed
> independent from yours but matches its very well.

>

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
