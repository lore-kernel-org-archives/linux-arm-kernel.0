From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 25 Apr 2018 18:54:46 +0100
Subject: [PATCH 6/6] arm: Allow to enable PCI_DOMAINS manually
In-Reply-To: <4b97c00b9cd72f508aa27f0b58711d73de2cd397.1524582822.git.jan.kiszka@siemens.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <4b97c00b9cd72f508aa27f0b58711d73de2cd397.1524582822.git.jan.kiszka@siemens.com>
Message-ID: <20180425175446.GC21628@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 05:13:42PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Required when running over Jailhouse, and there is already a physical
> host controller that Jailhouse does not intercept and rather adds a
> virtual one. That is the case for the Tegra TK1, e.g.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/Kconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a7f8e7f4b88f..5f8190cb057d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1248,8 +1248,13 @@ config PCI
>  	  VESA. If you have PCI, say Y, otherwise N.
>  
>  config PCI_DOMAINS
> -	bool
> +	bool "Support for multiple PCI domains"
>  	depends on PCI
> +	help
> +	  Automatically enabled if the platform supports multiple PCI host
> +	  controllers. Say Y if running over a hypervisor like Jailhouse that
> +	  dynamically adds further host controllers while the system is
> +	  running. Say N otherwise.

Alternatively, you could select it under PCI_HOST_GENERIC if that's all
you need in Jailhouse. Actually that's a change that makes sense anyway
I think.

Lorenzo
