From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Sep 2014 11:36:13 +0100
Subject: [RFC PATCH] arm64:mm: delete max_mapnr init.
In-Reply-To: <1410426973-32393-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1410426973-32393-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <20140911103613.GB6158@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:16:13AM +0100, Ganapatrao Kulkarni wrote:
> setting max_mapnr results in to error, if enabled with CONFIG_NUMA,
> which i have to replace with function set_max_mapnr.
> However this variable is not used in arm64(with default defconfig) and better to
> delete instead.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> ---
>  arch/arm64/mm/init.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 5472c24..548bd01 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -256,7 +256,6 @@ static void __init free_unused_memmap(void)
>   */
>  void __init mem_init(void)
>  {
> -	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;

I think it's cleaner to call set_max_mapnr in case this grows a use in core
code outside of pfn_valid (which we always override).

Will
