From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 21:40:48 +0100
Subject: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
In-Reply-To: <1418658882-14809-1-git-send-email-broonie@kernel.org>
References: <1418658882-14809-1-git-send-email-broonie@kernel.org>
Message-ID: <2060329.N1WYSODiQy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 15:54:42 Mark Brown wrote:
> The Exynos IOMMU driver uses the ARM specific dmac_flush_range() and
> outer_flush_range() functions. This breaks the build on arm64 allmodconfig
> in -next since support has been merged for some Exynos ARMv8 SoCs. Add a
> dependency on ARM to keep things building until either the driver has the
> ARM dependencies removed or the ARMv8 architecture code implements these
> ARM specific APIs.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Resending to the arm-soc people since the addition of the Exynos
> platform for ARMv8 went via them, Krzysztof also sent a fix for this
> earlier but it there's been no response.
> 

Applied to fixes branch, thansk!

	Arnd
