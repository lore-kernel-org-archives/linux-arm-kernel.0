From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 26 Jan 2010 18:28:50 +0800
Subject: [PATCH 2/4] mmp2: add mfpr setting
In-Reply-To: <771cded01001250303vbb38c7dp62e61b64abab89ea@mail.gmail.com>
References: <771cded01001250303vbb38c7dp62e61b64abab89ea@mail.gmail.com>
Message-ID: <f17812d71001260228jadc2157n63c5283cbd63eb61@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 7:03 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 3c6535a752748cf7e17683d7c37ccf66f245e714 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 25 Jan 2010 05:18:37 -0500
> Subject: [PATCH] mmp2: add mfpr setting
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/mfp-mmp2.h | ? ?4 ++++
> ?arch/arm/mach-mmp/mmp2.c ? ? ? ? ? ? ? ? ?| ? ?7 +++++++
> ?2 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> b/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> index 9371510..9f9f814 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> @@ -231,6 +231,10 @@
> ?/* Codec*/
> ?#define GPIO23_GPIO23 ? ? ? ? ?MFP_CFG(GPIO23, AF0)
>
> +#define GPIO101_GPIO101 ? ? ? ? ? ? ? ?MFP_CFG(GPIO101, AF0)
> +
> +/* PMIC */
> +#define PMIC_PMIC_INT ? ? ? ? ?MFP_CFG(PMIC_INT, AF0)
>
> ?#endif /* __ASM_MACH_MFP_MMP2_H */
>
> diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
> index a9ca93d..561194d 100644
> --- a/arch/arm/mach-mmp/mmp2.c
> +++ b/arch/arm/mach-mmp/mmp2.c
> @@ -28,6 +28,12 @@
>
> ?#define MFPR_VIRT_BASE (APB_VIRT_BASE + 0x1e000)
>
> +static struct mfp_addr_map mmp2_addr_map[] __initdata = {
> + ? ? ? MFP_ADDR(PMIC_INT, 0x2c4),
> +

Mmm... I'm wondering where're the MFPR addresses for other pins?

> + ? ? ? MFP_ADDR_END,
> +};
> +
> ?/* APB peripheral clocks */
> ?static APBC_CLK(uart1, MMP2_UART1, 1, 26000000);
> ?static APBC_CLK(uart2, MMP2_UART2, 1, 26000000);
> @@ -61,6 +67,7 @@ static int __init mmp2_init(void)
> ?{
> ? ? ? ?if (cpu_is_mmp2()) {
> ? ? ? ? ? ? ? ?mfp_init_base(MFPR_VIRT_BASE);
> + ? ? ? ? ? ? ? mfp_init_addr(mmp2_addr_map);
> ? ? ? ? ? ? ? ?clks_register(ARRAY_AND_SIZE(mmp2_clkregs));
> ? ? ? ?}
>
> --
> 1.5.6.5
>
