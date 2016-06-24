From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jun 2016 16:34:24 +0100
Subject: [PATCH 4/6] arm64: errata: Calling enable functions for CPU
 errata too
In-Reply-To: <1462812590-4494-5-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
 <1462812590-4494-5-git-send-email-andre.przywara@arm.com>
Message-ID: <20160624153423.GF22608@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 05:49:48PM +0100, Andre Przywara wrote:
> Currently we call the (optional) enable function for CPU _features_
> only. As CPU _errata_ descriptions share the same data structure and
> having an enable function is useful for errata as well (for instance
> to set bits in SCTLR), lets call it when enumerating erratas too.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 2 ++
>  arch/arm64/kernel/cpu_errata.c      | 5 +++++
>  arch/arm64/kernel/cpufeature.c      | 4 ++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b9b6494..cb8fb2c 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -174,7 +174,9 @@ void __init setup_cpu_features(void);
>  
>  void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>  			    const char *info);
> +void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
>  void check_local_cpu_errata(void);
> +void __init enable_cpu_errata(void);

Nitpick: I would rather call this enable_errata_workarounds since errata
are already enabled by in hardware ;).

-- 
Catalin
