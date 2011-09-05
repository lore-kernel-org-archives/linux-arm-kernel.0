From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 05 Sep 2011 19:22:02 +0900
Subject: [PATCH] ARM: S5P64X0: Fix mask value for S5P64X0 CPU IDs
In-Reply-To: <1314972141-14387-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1314972141-14387-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <002701cc6bb5$a7615c10$f6241430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ajay Kumar wrote:
> 
> The current value for S5P64XX_CPU_MASK does not include the necessary
> bits, which causes detection failure.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/cpu.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-
> samsung/include/plat/cpu.h
> index aa1f69b..897d161 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -30,7 +30,7 @@ extern unsigned long samsung_cpu_id;
> 
>  #define S5P6440_CPU_ID		0x56440000
>  #define S5P6450_CPU_ID		0x36450000
> -#define S5P64XX_CPU_MASK	0x1FF40000
> +#define S5P64XX_CPU_MASK	0x7FFF0000
> 
>  #define S5PC100_CPU_ID		0x43100000
>  #define S5PC100_CPU_MASK	0xFFFFF000
> --
> 1.7.2.3

Yes, you're right.
But in this case, 0xFFFFF000 is better than 0x7FFF0000.

If any problems with above value, please let me know.

Will apply, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
