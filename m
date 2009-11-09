From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 9 Nov 2009 03:08:50 -0800 (PST)
Subject: [REPOST PATCH 3/3] MXC: add platform resources for i.MX21 USB
	host controller.
In-Reply-To: <20091108185231.14742.23365.stgit@srv002.fuzzey.net>
Message-ID: <444518.41234.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin,

--- On Sun, 11/8/09, Martin Fuzzey <mfuzzey@gmail.com> wrote:

> From: Martin Fuzzey <mfuzzey@gmail.com>
> Subject: [REPOST PATCH 3/3] MXC: add platform resources for i.MX21 USB host controller.
> To: "Greg KH" <greg@kroah.com>, "Sascha Hauer" <s.hauer@pengutronix.de>
> Cc: linux-usb at vger.kernel.org, linux-arm-kernel at lists.infradead.org
> Date: Sunday, November 8, 2009, 4:52 PM
> 
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>
> 
> ---
> 
>  arch/arm/mach-mx2/devices.c |???27
> +++++++++++++++++++++++++++
>  arch/arm/mach-mx2/devices.h |? ? 1 +
>  2 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/devices.c
> b/arch/arm/mach-mx2/devices.c
> index 3522397..4e6f5a0 100644
> --- a/arch/arm/mach-mx2/devices.c
> +++ b/arch/arm/mach-mx2/devices.c
> @@ -565,3 +565,30 @@ int __init mxc_register_gpios(void)
>  {
>  ??? return mxc_gpio_init(imx_gpio_ports,
> ARRAY_SIZE(imx_gpio_ports));
>  }
> +
> +#ifdef CONFIG_MACH_MX21
> +static struct resource mx21_usbhc_resources[] = {
> +??? [0] = {
> +??? ???
> .start??? = USBOTG_BASE_ADDR,
> +??? ???
> .end??? = USBOTG_BASE_ADDR + 0x1FFF,
> +??? ???
> .flags??? = IORESOURCE_MEM,
> +??? },
> +??? [1] = {
> +??? ???
> .start??? ??? =
> MXC_INT_USBHOST,
> +??? ???
> .end??? ??? =
> MXC_INT_USBHOST,
> +??? ???
> .flags??? ??? =
> IORESOURCE_IRQ,
> +??? },
> +};

Shouldn't you let the compiler count the array?

Regards,

Fabio Estevam


      
