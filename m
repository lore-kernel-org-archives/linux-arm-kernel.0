From: dave.hansen@intel.com (Dave Hansen)
Date: Wed, 09 Jul 2014 14:19:18 -0700
Subject: [RFC/PATCH RESEND -next 00/21] Address sanitizer for kernel
 (kasan) - dynamic memory error detector.
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <53BDB1D6.1090605@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is totally self-serving (and employer-serving), but has anybody
thought about this large collection of memory debugging tools that we
are growing?  It helps to have them all in the same places in the menus
(thanks for adding it to Memory Debugging, btw!).

But, this gives us at least four things that overlap with kasan's
features on some level.  Each of these has its own advantages and
disadvantages, of course:

1. DEBUG_PAGEALLOC
2. SLUB debugging / DEBUG_OBJECTS
3. kmemcheck
4. kasan
... and there are surely more coming down pike.  Like Intel MPX:

> https://software.intel.com/en-us/articles/introduction-to-intel-memory-protection-extensions

Or, do we just keep adding these overlapping tools and their associated
code over and over and fragment their user bases?

You're also claiming that "KASAN is better than all of
CONFIG_DEBUG_PAGEALLOC".  So should we just disallow (or hide)
DEBUG_PAGEALLOC on kernels where KASAN is available?

Maybe we just need to keep these out of mainline and make Andrew carry
it in -mm until the end of time. :)
