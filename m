From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Mar 2017 13:44:22 +0100
Subject: [PATCH] ARM: tegra: Select SOC_TEGRA_PMC to fix linking error
In-Reply-To: <20170311202614.6052-1-krzk@kernel.org>
References: <20170311202614.6052-1-krzk@kernel.org>
Message-ID: <20170320124422.GB22463@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 10:26:14PM +0200, Krzysztof Kozlowski wrote:
> It is possible to create a ARMv7 config with ARCH_TEGRA but without any
> SoC specific flavors.  Such configs fails because mach-tegra/pm.c is
> compiled always and it references SOC_TEGRA_PMC driver:
> 
> 	arch/arm/mach-tegra/built-in.o: In function `tegra_pm_set':
> 	arch/arm/mach-tegra/pm.c:188: undefined reference to `tegra_pmc_enter_suspend_mode'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-tegra/Kconfig | 1 +
>  drivers/soc/tegra/Kconfig   | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)

I was going to apply this, when Arnd sent in a variant that fixes this
in a way that is more in line with how we handle this for other drivers.

I've credited you with a Reported-by, though.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/75050c8d/attachment.sig>
