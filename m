From: andi@firstfloor.org (Andi Kleen)
Date: Wed, 09 Jul 2014 14:44:56 -0700
Subject: [RFC/PATCH RESEND -next 00/21] Address sanitizer for kernel
 (kasan) - dynamic memory error detector.
In-Reply-To: <53BDB1D6.1090605@intel.com> (Dave Hansen's message of "Wed, 09
 Jul 2014 14:19:18 -0700")
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <53BDB1D6.1090605@intel.com>
Message-ID: <8761j6nr53.fsf@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Hansen <dave.hansen@intel.com> writes:
>
> You're also claiming that "KASAN is better than all of

better as in finding more bugs, but surely not better as in
"do so with less overhead"

> CONFIG_DEBUG_PAGEALLOC".  So should we just disallow (or hide)
> DEBUG_PAGEALLOC on kernels where KASAN is available?

I don't think DEBUG_PAGEALLOC/SLUB debug and kasan really conflict.

DEBUG_PAGEALLOC/SLUB is "much lower overhead but less bugs found".
KASAN is "slow but thorough" There are niches for both.

But I could see KASAN eventually deprecating kmemcheck, which
is just incredible slow.

-Andi

-- 
ak at linux.intel.com -- Speaking for myself only
