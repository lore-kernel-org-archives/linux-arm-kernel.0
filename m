From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 18:47:38 +0100
Subject: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
In-Reply-To: <1399653631-4938-2-git-send-email-broonie@kernel.org>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
Message-ID: <20140509174738.GP7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 05:40:30PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> without IKS support since it implements support for clusters with shared
> clocks (a common big.LITTLE configuration). In order to allow it to be
> built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> cores available.

Have you thought of patching the actual cpufreq driver? Are you adding
this code just to avoid compiler errors on arm64 with this driver?

> It may make sense to make an asm-generic version of these stubs instead

asm-generic/bL_switcher.h? I take it as a good joke ;)

> but
> given that there's only likely to be these two architectures using the code
> and asm-generic stubs also need per architecture updates it's probably more
> trouble than it's worth.

Exactly.

-- 
Catalin
