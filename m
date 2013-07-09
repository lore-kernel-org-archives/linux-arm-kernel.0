From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 9 Jul 2013 18:41:46 +0800
Subject: [V3 2/7] ARM: mmp: remove the legacy rbswap setting for ttc_dkb
 platform
In-Reply-To: <1372332524-6772-1-git-send-email-jtzhou@marvell.com>
References: <1372332524-6772-1-git-send-email-jtzhou@marvell.com>
Message-ID: <CAN1soZyfnPd4VBjhYUt8Lm=S+CKey2YVU8ZQRgO7KYsj=_J90A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 7:28 PM, Jett.Zhou <jtzhou@marvell.com> wrote:
> According to new rbswap scheme of mmp_display, it support appropriate
> rbswap setting based specific pix_fmt, then we can remove the legacy
> rbswap setting for ttc_dkb platform.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>  arch/arm/mach-mmp/ttc_dkb.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index 8483906..cb08485 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -191,7 +191,6 @@ static struct pxa3xx_nand_platform_data dkb_nand_info = {
>  #define SCLK_SOURCE_SELECT(x)  (x << 30) /* 0x0 ~ 0x3 */
>  /* link config */
>  #define CFG_DUMBMODE(mode)     (mode << 28) /* 0x0 ~ 0x6*/
> -#define CFG_GRA_SWAPRB(x)      (x << 0) /* 1: rbswap enabled */
>  static struct mmp_mach_path_config dkb_disp_config[] = {
>         [0] = {
>                 .name = "mmp-parallel",
> @@ -199,8 +198,7 @@ static struct mmp_mach_path_config dkb_disp_config[] = {
>                 .output_type = PATH_OUT_PARALLEL,
>                 .path_config = CFG_IOPADMODE(0x1)
>                         | SCLK_SOURCE_SELECT(0x1),
> -               .link_config = CFG_DUMBMODE(0x2)
> -                       | CFG_GRA_SWAPRB(0x1),
> +               .link_config = CFG_DUMBMODE(0x2),
>         },
>  };
>
> --
> 1.7.0.4
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
