From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 16:24:07 +0100
Subject: [PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM
In-Reply-To: <20140113152011.GA15107@ulmo.nvidia.com>
References: <E1Vyl3Q-0005Lt-Lo@rmk-PC.arm.linux.org.uk>
 <20140113134813.GX15937@n2100.arm.linux.org.uk>
 <20140113152011.GA15107@ulmo.nvidia.com>
Message-ID: <201401131624.08206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 January 2014, Thierry Reding wrote:
> From ee1347c28bb7cb56a3c178321253e38de4bbc676 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Fri, 10 Jan 2014 17:12:07 +0100
> Subject: [PATCH] ARM: Remove redundant select AUTO_ZRELADDR
> 
> ARCH_MXC depends on ARCH_MULTI_V4_V5 or ARCH_MULTI_V6_V7, both of which
> can only be enabled when ARCH_MULTIPLATFORM is selected. If so, then the
> AUTO_ZRELADDR will already be selected.
> 
> Removing the selection of AUTO_ZRELADDR from ARCH_MXC has the additional
> benefit of getting rid of the following Kconfig error:
> 
>         arch/arm/Kconfig:1965:error: recursive dependency detected!
>         arch/arm/Kconfig:1965:  symbol ZBOOT_ROM depends on AUTO_ZRELADDR
>         arch/arm/Kconfig:2153:  symbol AUTO_ZRELADDR is selected by ZBOOT_ROM
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'm not sure through which tree this needs to go to make sure that 
both the arm-soc tree and rmk's arm tree are correct by themselves
as well as when they get merged.

	Arnd
