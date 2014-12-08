From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon, 08 Dec 2014 09:06:04 +0100
Subject: [PATCH 1/2] ARM: Add printf annotation to early_print
In-Reply-To: <1413277169-6941-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1413277169-6941-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <3816915.CA4nKfAtzf@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Any feedback in this?

Best regards,
Alexander

On Tuesday 14 October 2014 10:59:28, Alexander Stein wrote:
> This adds the printf format annotation to early_print to warn users about
> incompatible formats and argument.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  arch/arm/include/asm/setup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index e0adb9f..d4e06cc 100644
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
>  #endif
> 

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein at systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
