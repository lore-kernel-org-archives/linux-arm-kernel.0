From: nicolas.iooss_linux@m4x.org (Nicolas Iooss)
Date: Sat, 24 Sep 2016 14:31:46 +0200
Subject: [PATCH 1/1] ARM: add printf format attribute to early_print()
In-Reply-To: <20160828165815.25647-1-nicolas.iooss_linux@m4x.org>
References: <20160828165815.25647-1-nicolas.iooss_linux@m4x.org>
Message-ID: <57873573-dd8f-d2f6-ef1c-4c6b76e70308@m4x.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/16 18:58, Nicolas Iooss wrote:
> Adding such an attribute is helpful to detect errors related to printf
> formats at compile-time.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> ---
>  arch/arm/include/asm/setup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index 3613d7e9fc40..797b8505b49a 100644
> --- a/arch/arm/include/asm/setup.h
> +++ b/arch/arm/include/asm/setup.h
> @@ -22,7 +22,7 @@
>  static const struct tagtable __tagtable_##fn __tag = { tag, fn }
>  
>  extern int arm_add_memory(u64 start, u64 size);
> -extern void early_print(const char *str, ...);
> +extern __printf(1, 2) void early_print(const char *str, ...);
>  extern void dump_machine_table(void);
>  
>  #ifdef CONFIG_ATAGS_PROC

Hello,
I sent this patch a few weeks ago and got no reply (and nothing showed
up on https://patchwork.kernel.org/patch/9302825/). Could you please
consider it for 4.9?

Thanks,
Nicolas
