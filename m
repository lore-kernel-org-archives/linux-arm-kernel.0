From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 28 Mar 2013 09:42:55 +0800
Subject: [PATCH V2 5/6] arm: mmp: remove clock name from usb pdata for ttc
In-Reply-To: <1364195217-1226-6-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
 <1364195217-1226-6-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZxBAHkE+NatuzTotSGyt2n8rMVn6TY5YV0xtU5AiJ2LoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 3:06 PM, Chao Xie <chao.xie@marvell.com> wrote:
> The clock name will directly get by driver. Removing
> the name from pdata.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  arch/arm/mach-mmp/ttc_dkb.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index 22a9058..6528a5f 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -162,13 +162,7 @@ static struct i2c_board_info ttc_dkb_i2c_info[] = {
>  #ifdef CONFIG_USB_SUPPORT
>  #if defined(CONFIG_USB_MV_UDC) || defined(CONFIG_USB_EHCI_MV_U2O)
>
> -static char *pxa910_usb_clock_name[] = {
> -       [0] = "U2OCLK",
> -};
> -
>  static struct mv_usb_platform_data ttc_usb_pdata = {
> -       .clknum         = 1,
> -       .clkname        = pxa910_usb_clock_name,
>         .vbus           = NULL,
>         .mode           = MV_USB_MODE_OTG,
>         .otg_force_a_bus_req = 1,
> --
> 1.7.4.1
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
