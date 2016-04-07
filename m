From: puck.chen@hisilicon.com (Chen Feng)
Date: Thu, 7 Apr 2016 15:38:33 +0800
Subject: [PATCH 1/2] arm64: mem-model: add flatmem model for arm64
In-Reply-To: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
References: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <57060E79.8030801@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add Mel Gorman

On 2016/4/5 16:22, Chen Feng wrote:
> We can reduce the memory allocated at mem-map
> by flatmem.
> 
> currently, the default memory-model in arm64 is
> sparse memory. The mem-map array is not freed in
> this scene. If the physical address is too long,
> it will reserved too much memory for the mem-map
> array.
> 
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Fu Jun <oliver.fu@hisilicon.com>
> ---
>  arch/arm64/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f43622..c18930d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -559,6 +559,9 @@ config ARCH_SPARSEMEM_ENABLE
>  	def_bool y
>  	select SPARSEMEM_VMEMMAP_ENABLE
>  
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +
>  config ARCH_SPARSEMEM_DEFAULT
>  	def_bool ARCH_SPARSEMEM_ENABLE
>  
> 
