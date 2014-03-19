From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:51:05 +0100
Subject: [PATCH 62/62] ARM: tegra: make debug_ll code build for ARMv6
In-Reply-To: <5329F296.6030308@wwwdotorg.org>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-63-git-send-email-arnd@arndb.de>
 <5329F296.6030308@wwwdotorg.org>
Message-ID: <6268308.cWSbPODKo9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014 13:40:06 Stephen Warren wrote:
> Hmmm. This code is guaranteed to only execute on Tegra (well, perhaps
> someone can turn on the wrong debug option and run it on non-Tegra, but
> then it's guaranteed not to work since the HW it touches doesn't exist).
> As such, the code ought to be able to use ARMv7 instructions.
> 
> As a fix for similar issues in assembly code in arch/arm/mach-tegra/*.S,
> Makefile there does:
> 
> asflags-y                               += -march=armv7-a
> 
> (I think you added that? Yes, in 408e713545ca "ARM: tegra: build
> assembly files with -march=armv7-a")
> 
> Shouldn't we use the same fix in this case too?

That was my first idea, but I couldn't come up with a nice way to do this
for arch/arm/kernel/debug.S, which #includes the specific implementation.

I'd rather not put lots of per-platform hacks into arch/arm/kernel/Makefile.

	Arnd
