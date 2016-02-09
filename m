From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 09:15:29 +0100
Subject: [PATCH 3/6] ARM: sunxi_defconfig: Enable MUSB HDRC driver with
 Allwinner glue
In-Reply-To: <1454774029-10469-4-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
 <1454774029-10469-4-git-send-email-wens@csie.org>
Message-ID: <20160209081529.GP31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 06, 2016 at 11:53:46PM +0800, Chen-Yu Tsai wrote:
> Allwinner SoCs typically have a Mentor Graphics Inventra MUSB dual role
> controller for USB OTG.
> 
> Now that the issue with MUSB and USB gadget registration order has been
> resolved, we can enable this driver in dual role mode. This requires the
> NOP USB transceiver driver, which is also enabled.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/configs/sunxi_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index efa12c88fe1c..e29b81694184 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -109,6 +109,11 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_HCD_PLATFORM=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
> +CONFIG_USB_MUSB_HDRC=y
> +CONFIG_USB_MUSB_SUNXI=y
> +CONFIG_NOP_USB_XCEIV=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_CDC_COMPOSITE=y

I'd prefer not to have any default gadget here, just like you did on
multi_v7.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/031ab3a0/attachment.sig>
