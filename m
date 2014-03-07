From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 07 Mar 2014 22:01:01 +0300
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <531A176D.6090409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/07/2014 08:04 PM, Denis Carikli wrote:

> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>   drivers/usb/chipidea/usbmisc_imx.c |   59 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)

> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index cd061ab..d956ad0 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -21,6 +21,26 @@
>   #define MX25_USB_PHY_CTRL_OFFSET	0x08
>   #define MX25_BM_EXTERNAL_VBUS_DIVIDER	BIT(23)
>
> +#define MXC_EHCI_INTERFACE_SINGLE_UNI	(2 << 0)
> +#define MXC_EHCI_INTERFACE_DIFF_UNI	(0 << 0)
> +#define MXC_EHCI_INTERFACE_MASK		(0xf)
> +
> +#define MX25_OTG_SIC_SHIFT		29
> +#define MX25_OTG_SIC_MASK		(0x3 << MX25_OTG_SIC_SHIFT)
> +#define MX25_OTG_PM_BIT			BIT(24)
> +#define MX25_OTG_PP_BIT			BIT(11)
> +#define MX25_OTG_OCPOL_BIT		(1 << 3)

    Hm, why not BIT(3). Though frankly speaking, I don't think (x << n) macros 
go together well with BIT() ones.

> +
> +#define MX25_H1_SIC_SHIFT		21
> +#define MX25_H1_SIC_MASK		(0x3 << MX25_H1_SIC_SHIFT)
> +#define MX25_H1_PP_BIT			BIT(18)
> +#define MX25_H1_PM_BIT			BIT(16)
> +#define MX25_H1_IPPUE_UP_BIT		BIT(7)
> +#define MX25_H1_IPPUE_DOWN_BIT		BIT(6)
> +#define MX25_H1_TLL_BIT			BIT(5)
> +#define MX25_H1_USBTE_BIT		BIT(4)
> +#define MX25_H1_OCPOL_BIT		(1 << 2)

    BIT(2)?

WBR, Sergei
