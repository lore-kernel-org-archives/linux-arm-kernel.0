From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 10:54:34 +0200
Subject: [PATCH] video: clcd-versatile: Depend on ARM
In-Reply-To: <1406480658-27243-1-git-send-email-broonie@kernel.org>
References: <1406480658-27243-1-git-send-email-broonie@kernel.org>
Message-ID: <5789388.BhevNhh9tO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 July 2014 18:04:18 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The Versatile CLCD helpers call dma_alloc_writecombine() which is only
> available on ARM and AVR32, meaning they won't build on other platforms
> including arm64. Unfortunately the current Kconfig enables the symbol
> by default if ARCH_VEXPRESS is defined which means that it is enabled on
> arm64 when building for the ARM reference platforms and models for ARMv8
> since they have many hardware similarities with their pre-ARMv8 systems.
> 
> Since all the systems that need the helpers are ARM systems fix this by
> adding a dependency on ARM.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

I guess this one is for me, as the bug only exists in linux-next through
arm-soc, introduced by my previous fix for another bug.

Applied to next/cleanup, thanks a lot for fixing it!

	Arnd
