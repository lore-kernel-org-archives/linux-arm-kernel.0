From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 28 Mar 2013 08:59:45 +0800
Subject: [PATCH V2 4/6] arm: mmp: remove clock from usb pdata for aspenite
In-Reply-To: <1364195217-1226-5-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
 <1364195217-1226-5-git-send-email-chao.xie@marvell.com>
Message-ID: <CADApbegPiZQEGChmDehtCvrxDra5B04v-+MLkpyW6G3SfNtyJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Haojian
The patches correct the wrong usage of clock. It finally do not need
pass clock by pdata. Can you help to review the patches relates to
arch-mmp, and ack it?Thanks.

On Mon, Mar 25, 2013 at 3:06 PM, Chao Xie <chao.xie@marvell.com> wrote:
> The clock name will directly get by driver. Removing
> the name from pdata.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  arch/arm/mach-mmp/aspenite.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index 9f64d56..76901f4 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -223,13 +223,7 @@ static struct pxa27x_keypad_platform_data aspenite_keypad_info __initdata = {
>  };
>
>  #if defined(CONFIG_USB_EHCI_MV)
> -static char *pxa168_sph_clock_name[] = {
> -       [0] = "PXA168-USBCLK",
> -};
> -
>  static struct mv_usb_platform_data pxa168_sph_pdata = {
> -       .clknum         = 1,
> -       .clkname        = pxa168_sph_clock_name,
>         .mode           = MV_USB_MODE_HOST,
>         .phy_init       = pxa_usb_phy_init,
>         .phy_deinit     = pxa_usb_phy_deinit,
> --
> 1.7.4.1
>
