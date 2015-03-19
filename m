From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Mar 2015 16:42:13 +0300
Subject: [PATCH] usb: ehci-orion: add more constants for register values
In-Reply-To: <1426761136-4118-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1426761136-4118-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <550AD235.4020305@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/19/2015 1:32 PM, Thomas Petazzoni wrote:

> This commit adds new register values for the USB_CMD and USB_MODE
> registers, which allows to avoid the usage of a number of magic values
> in orion_usb_phy_v1_setup().

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   drivers/usb/host/ehci-orion.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)

> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index f6eafec..0feca8a 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -29,7 +29,13 @@
>   #define wrl(off, val)	writel_relaxed((val), hcd->regs + (off))
>
>   #define USB_CMD			0x140
> +#define   USB_CMD_RUN           BIT(0)
> +#define   USB_CMD_RESET         BIT(1)

    Please use tabs to align the values, not spaces.

>   #define USB_MODE		0x1a8
> +#define   USB_MODE_MASK         GENMASK(1, 0)
> +#define   USB_MODE_DEVICE       0x2
> +#define   USB_MODE_HOST         0x3
> +#define   USB_MODE_SDIS         BIT(4)

    Here too.

>   #define USB_CAUSE		0x310
>   #define USB_MASK		0x314
>   #define USB_WINDOW_CTRL(i)	(0x320 + ((i) << 4))
[...]

WBR, Sergei
