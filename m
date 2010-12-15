From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 15 Dec 2010 16:17:48 +0300
Subject: [PATCH 2/7] msm: Physical offset for MSM8960
In-Reply-To: <1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
Message-ID: <4D08BFFC.3020103@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-12-2010 6:49, Stepan Moskovchenko wrote:

> Add the physical memory offset value for the Qualcomm
> MSM8960 chip.

> Signed-off-by: Stepan Moskovchenko<stepanm@codeaurora.org>
[...]

> diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
> index 070e17d..014bbd3 100644
> --- a/arch/arm/mach-msm/include/mach/memory.h
> +++ b/arch/arm/mach-msm/include/mach/memory.h
> @@ -25,6 +25,8 @@
>  #define PHYS_OFFSET		UL(0x00200000)
>  #elif defined(CONFIG_ARCH_MSM8X60)
>  #define PHYS_OFFSET		UL(0x40200000)
> +#elif defined(CONFIG_ARCH_MSM8960)
> +#define PHYS_OFFSET		UL(0x40200000)

    Why not:

-#elif defined(CONFIG_ARCH_MSM8X60)
+#elif defined(CONFIG_ARCH_MSM8X60) || defined(CONFIG_ARCH_MSM8960)

WBR, Sergei
