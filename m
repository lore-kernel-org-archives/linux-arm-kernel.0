From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:47:15 +0100
Subject: [PATCH 05/11] Disable kasan's instrumentation
In-Reply-To: <20171011082227.20546-6-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-6-liuwenliang@huawei.com>
Message-ID: <20171019124714.GZ20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 04:22:21PM +0800, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
>  To avoid some build and runtime errors, compiler's instrumentation must
>  be disabled for code not linked with kernel image.

How does that explain the change to unwind.c ?

Does this also disable the string macro changes?

In any case, this should certainly precede patch 4, and very probably
patch 2.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
