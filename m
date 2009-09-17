From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Sep 2009 22:18:14 -0400 (EDT)
Subject: [PATCH] arm: mmu fix unused variable highmem when HIGHMEM is not
	enable
In-Reply-To: <1253146158-4396-1-git-send-email-plagnioj@jcrosoft.com>
References: <1253146158-4396-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <alpine.LFD.2.00.0909162216550.24133@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2009, Jean-Christophe PLAGNIOL-VILLARD wrote:

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mm/mmu.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4426ee6..650b0f1 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -687,7 +687,10 @@ __early_param("vmalloc=", early_vmalloc);
>  
>  static void __init sanity_check_meminfo(void)
>  {
> -	int i, j, highmem = 0;
> +	int i, j;
> +#ifdef CONFIG_HIGHMEM
> +	int highmen = 0;
> +#endif

NAK.

Without even trying it, I can tell you this patch breaks highmem.


Nicolas
