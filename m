From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Nov 2015 14:57:59 +0000
Subject: [PATCH] ARM64: mark cpus_have_hwcap as __maybe_unused
In-Reply-To: <5369626.MJXv4CTaxt@wuerfel>
References: <5369626.MJXv4CTaxt@wuerfel>
Message-ID: <20151112145759.GH5627@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 03:20:16PM +0100, Arnd Bergmann wrote:
> cpus_have_hwcap() is defined as a 'static' function an only used in
> one place that is inside of an #ifdef, so we get a warning when
> the only user is disabled:
> 
> arch/arm64/kernel/cpufeature.c:699:13: warning: 'cpus_have_hwcap' defined but not used [-Wunused-function]
> 
> This marks the function as __maybe_unused, so the compiler knows that
> it can drop the function definition without warning about it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 37b01d53ceef ("arm64/HWCAP: Use system wide safe values")
> ---
> Found on arm64 allnoconfig

I applied this patch and the other two you just posted. Thanks.

-- 
Catalin
