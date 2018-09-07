From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Sep 2018 15:56:05 +0100
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
In-Reply-To: <20180906170534.20726-1-aryabinin@virtuozzo.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
Message-ID: <20180907145605.GE12788@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 08:05:33PM +0300, Andrey Ryabinin wrote:
> ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
> code, thus it can potentially miss many bugs.
> 
> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
> enabled, so the generic implementations from lib/string.c will be used.
> 
> Declare asm functions as weak instead of removing them because they
> still can be used by efistub.

I don't understand this bit: efistub uses the __pi_ prefixed versions of the
routines, so why do we need to declare them as weak?

Will
