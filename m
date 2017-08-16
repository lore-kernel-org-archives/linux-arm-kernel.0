From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 16 Aug 2017 10:18:22 +0100
Subject: [PATCH] ARM: hisi: Fix typo in comment
In-Reply-To: <20170807093322.26050-1-yunzhi.li@deephi.tech>
References: <20170807093322.26050-1-yunzhi.li@deephi.tech>
Message-ID: <59940DDE.1000906@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yunzhi,

On 2017/8/7 10:33, Yunzhi Li wrote:
> Fix the rc vs. pc typo. There is no a register named rc, I felt
> confused when I read this assembler command in comment.
>

Thanks!
Yes, it is a typo.
And 0xe51ff004 is the machine code to do the jump.
I will change the commit msg as below and pick up it:

The machine code "0xe51ff004" means "ldr pc, [pc, #-4]".
This patch fixed the comment typo to avoid any confusion.

Best Regards,
Wei

> Signed-off-by: Yunzhi Li <yunzhi.li@deephi.tech>
> ---
> 
>  arch/arm/mach-hisi/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index 91bb02dec20f..da5689ababf7 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c
> @@ -109,7 +109,7 @@ static void hix5hd2_set_scu_boot_addr(phys_addr_t start_addr, phys_addr_t jump_a
>  
>  	virt = ioremap(start_addr, PAGE_SIZE);
>  
> -	writel_relaxed(0xe51ff004, virt);	/* ldr pc, [rc, #-4] */
> +	writel_relaxed(0xe51ff004, virt);	/* ldr pc, [pc, #-4] */
>  	writel_relaxed(jump_addr, virt + 4);	/* pc jump phy address */
>  	iounmap(virt);
>  }
> 
