From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 08 May 2014 19:18:18 +0200
Subject: [PATCH V3 3/3] CLK: EXYNOS: Add clk save/restore registers for
 5420
In-Reply-To: <1399546391-30571-1-git-send-email-vikas.sajjan@samsung.com>
References: <1399546391-30571-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <536BBC5A.4030707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

Please try to more or less follow subsystem subject conventions. It
should be:

clk: samsung: exynos5420: Add clk save/restore registers

By the way, this patch only adds writes to registers that should be set
up before suspending the system and both the subject and description
should reflect this. Please be more careful when describing patches.

On 08.05.2014 12:53, Vikas Sajjan wrote:
> Adds clk save/restore registers for 5420
> 
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 60b2681..01fd917 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -101,6 +101,18 @@
>  #define KPLL_CON0		0x28100
>  #define SRC_KFC			0x28200
>  #define DIV_KFC0		0x28500
> +#define SRC_MASK_CPERI		0x04300
> +#define SRC_MASK_TOP0		0x10300
> +#define SRC_MASK_TOP1		0x10304
> +#define SRC_MASK_TOP2		0x10308
> +#define SRC_MASK_TOP7		0x1031C
> +#define SRC_MASK_MAU		0x10334
> +#define SRC_MASK_FSYS		0x10340
> +#define SRC_MASK_PERIC0		0x10350
> +#define SRC_MASK_PERIC1		0x10354
> +#define SRC_MASK_ISP		0x10370
> +#define GATE_BUS_DISP1		0x10728
> +#define GATE_IP_PERIC		0x10950

Please sort the definitions according to addresses.

Best regards,
Tomasz
