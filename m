From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 9 Jul 2012 09:26:09 +0800
Subject: [PATCH] ARM: ttc_dkb: add nand support
In-Reply-To: <CALZhoSRZKi+PHpj1tBBBFX2rcGb_6yyMowthH0uyA=vRoTNq8w@mail.gmail.com>
References: <1341793703-18510-1-git-send-email-leiwen@marvell.com>
 <CALZhoSRZKi+PHpj1tBBBFX2rcGb_6yyMowthH0uyA=vRoTNq8w@mail.gmail.com>
Message-ID: <CAN1soZwo5N2drSwRt8FbFPiSkFYYiar0zyVQxhzbObgmow7bMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 8:47 AM, Lei Wen <adrian.wenl@gmail.com> wrote:
> Add NAND support for dkb platform.
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
>  arch/arm/mach-mmp/ttc_dkb.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index 7a7de2b..5a6a1ad 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -177,6 +177,13 @@ static struct mv_usb_platform_data ttc_usb_pdata = {
>  #endif
>  #endif
>
> +#ifdef CONFIG_MTD_NAND_PXA3xx
> +static struct pxa3xx_nand_platform_data dkb_nand_info = {
> +       .enable_arbiter = 1,
> +       .num_cs = 1,
> +};
> +#endif
> +
>  static void __init ttc_dkb_init(void)
>  {
>         mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
> @@ -184,6 +191,10 @@ static void __init ttc_dkb_init(void)
>         /* on-chip devices */
>         pxa910_add_uart(1);
>
> +#ifdef CONFIG_MTD_NAND_PXA3xx
> +       pxa910_add_nand(&dkb_nand_info);
> +#endif
> +
>         /* off-chip devices */
>         pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
>         platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
> --
> 1.7.5.4
>

There're two different TTC DKB boards. One is with onenand support,
and the other is nand support. Now mosts of TTC DKB boards are only
with nand support. So you can replace onenand code with nand in
ttc_dkb.c

Regards
Haojian
