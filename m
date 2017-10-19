From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:05:55 +0100
Subject: [PATCH 02/11] replace memory function
In-Reply-To: <20171011082227.20546-3-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-3-liuwenliang@huawei.com>
Message-ID: <20171019120555.GU20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 04:22:18PM +0800, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> Functions like memset/memmove/memcpy do a lot of memory accesses.
> If bad pointer passed to one of these function it is important
> to catch this. Compiler's instrumentation cannot do this since
> these functions are written in assembly.
> 
> KASan replaces memory functions with manually instrumented variants.
> Original functions declared as weak symbols so strong definitions
> in mm/kasan/kasan.c could replace them. Original functions have aliases
> with '__' prefix in name, so we could call non-instrumented variant
> if needed.

KASAN in the decompressor makes no sense, so I think you need to
mark the decompressor compilation as such in this patch so it,
as a whole, sees no change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
