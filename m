From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 10 Mar 2011 18:40:08 +0300
Subject: [PATCH 1/3] msm: 8660: Add clock control regions to iomap
In-Reply-To: <1299732274-10742-2-git-send-email-sboyd@codeaurora.org>
References: <1299732274-10742-1-git-send-email-sboyd@codeaurora.org>
	<1299732274-10742-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D78F0D8.7000408@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-03-2011 7:44, Stephen Boyd wrote:

> Change-Id: I9e72f10d0da1d6aaaaf7df85d33b998edf424f6f

    This shouldn't be here.

> Signed-off-by: Stephen Boyd<sboyd@codeaurora.org>
[...]

> diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
> index 3b19b8f..ddfc85b 100644
> --- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
> +++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
> @@ -53,6 +53,14 @@
>  #define MSM_TLMM_PHYS		0x00800000
>  #define MSM_TLMM_SIZE		SZ_16K
>
> +#define MSM_CLK_CTL_BASE        IOMEM(0xFA010000)
> +#define MSM_CLK_CTL_PHYS        0x00900000
> +#define MSM_CLK_CTL_SIZE        SZ_16K

    Surrounding code separates the macro names from values by tabs, and you're 
using spaces. Should be more consistent...

> +#define MSM_LPASS_CLK_CTL_BASE  IOMEM(0xFA015000)
> +#define MSM_LPASS_CLK_CTL_PHYS  0x28000000
> +#define MSM_LPASS_CLK_CTL_SIZE  SZ_4K
> +
>  #define MSM_SHARED_RAM_BASE	IOMEM(0xF0100000)
>  #define MSM_SHARED_RAM_SIZE	SZ_1M

WBR, Sergei
