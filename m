From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 07 Oct 2010 15:22:21 +0400
Subject: [PATCH 2/3] mx51: efikamx: add otg support
In-Reply-To: <34d3df3c6ce621e58c17b38ffc23eb180b64a781.1286412080.git.amit.kucheria@linaro.org>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<34d3df3c6ce621e58c17b38ffc23eb180b64a781.1286412080.git.amit.kucheria@linaro.org>
Message-ID: <4CADAD6D.4000008@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-10-2010 4:58, Amit Kucheria wrote:

> Ethernet hangs off OTG

    Hm, what?

> Signed-off-by: Amit Kucheria<amit.kucheria@linaro.org>
[...]

> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
> index 4c921fc..b00502a 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
> @@ -37,6 +37,8 @@
>   #include "devices-imx51.h"
>   #include "devices.h"
>
> +#define	MX51_USB_PLL_DIV_24_MHZ	0x01
> +
>   static struct pad_desc mx51efikamx_pads[] = {
>   	/* UART1 */
>   	MX51_PAD_UART1_RXD__UART1_RXD,
> @@ -63,10 +65,38 @@ static inline void mxc_init_imx_uart(void)
>   }
>   #endif /* SERIAL_IMX */
>
> +/* This function is board specific as the bit mask for the plldiv will also
> + * be different for other Freescale SoCs, thus a common bitmask is not
> + * possible and cannot get place in /plat-mxc/ehci.c.
> + */
> +static int initialize_otg_port(struct platform_device *pdev)
> +{
> +	u32 v;
> +	void __iomem *usb_base;
> +	void __iomem *usbother_base;

    Insert an empty line here please.

> +	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> +	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);

WBR, Sergei
