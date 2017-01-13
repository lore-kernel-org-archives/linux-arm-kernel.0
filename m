From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Jan 2017 11:18:57 +0000
Subject: [PATCH] arm64/mm: use phys_addr_t
In-Reply-To: <1484287175-14342-1-git-send-email-miles.chen@mediatek.com>
References: <1484287175-14342-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20170113111857.GB30292@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 01:59:35PM +0800, miles.chen at mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> Use phys_addr_t instead of unsigned long for the
> return value of __pa(), make code easy to understand.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e4..7eb7c21 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -359,8 +359,8 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
>  
>  static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
>  {
> -	unsigned long kernel_start = __pa(_text);
> -	unsigned long kernel_end = __pa(__init_begin);
> +	phys_addr_t kernel_start = __pa(_text);
> +	phys_addr_t kernel_end = __pa(__init_begin);

Looks fine.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
