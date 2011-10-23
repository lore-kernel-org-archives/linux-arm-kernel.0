From: zdevai@gmail.com (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:21:16 +0200
Subject: [RFC][PATCH] uncompress.h cleanup and DT support
In-Reply-To: <20111023090247.GH2638@game.jcrosoft.org>
References: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
	<20111023090247.GH2638@game.jcrosoft.org>
Message-ID: <CAGVye5PUxS=UPPWg+8jnVyGvJwd4oD426dtbUco33oQxUf9PuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/23 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> On 10:18 Sun 23 Oct ? ? , Zoltan Devai wrote:
>> Hi,
>>
>> Originally, I just wanted to get rid of arch_decomp_* in all the uncompress.h
>> files, that were mostly empty. But then, I couldn't stop. Which may also mean
>> I have gone too far.
> on small SoC arm926 the kernel may more time that the watchdog refreshing so
> the kernel will never have enough time to decompress
Sure, but:
- only Samsung was using it (with optional Kconfig)
- the feature wasn't working since ARM moved to use the decompress_* libs
  instead of inflate.c (2.6.33)

Carrying around a 95% empty definition, that does nothing even when not
empty, doesn't make sense.
If someone needs a decomp_wdog, he needs to re-implement it from scratch,
using the new decompressor libraries.

Z
