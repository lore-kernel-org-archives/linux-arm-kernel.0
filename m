From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 1 Dec 2016 20:11:30 +0000
Subject: [RFC v2 PATCH 23/23] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <583EA390.7000705@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
 <1480423205-48436-24-git-send-email-vladimir.murzin@arm.com>
 <20161129172234.GY14217@n2100.armlinux.org.uk> <583EA390.7000705@arm.com>
Message-ID: <SG2PR06MB116568255B0E7CBF5AE474038A8F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016, Vladimir Murzin wrote:
> >> motivation behind of this patch:
> >> - bring build coverage for NOMMU configurations
> >> - allow known working NOMMU platforms (like R-class) to be used
> >> - pave a way to add support for single address space (aka 1:1 mapping)
> >>   for MMU platforms, so they can be usable in NOMMU configurations


I use XIP_KERNEL with a MMU platform (Renesas RZ/A1, Cortex A9) which is
also ARCH_MULTIPLATFORM.

So I also have to hack the Kconfig to get it to build.

I had proposed this patch to allow you to select which multiplatform
devices are XIP capable, but it never made it in.

https://patchwork.kernel.org/patch/8395661/


Maybe you can do the same idea for !MMU platforms as well (just
say whether the device can do XIP regardless of MMU or !MMU)


Chris
