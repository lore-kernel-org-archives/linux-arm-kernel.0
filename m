From: timur.tabi@gmail.com (Timur Tabi)
Date: Mon, 19 Apr 2010 15:40:26 -0500
Subject: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
In-Reply-To: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
References: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
Message-ID: <k2med82fe3e1004191340j5ff359d1q7a3470084b2d3ad2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 2:35 PM, Rob Herring <r.herring@freescale.com> wrote:

> +/* Serial ports */
> +#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
> +static struct imxuart_platform_data uart_pdata = {
> +// ? ? .flags = IMXUART_HAVE_RTSCTS,

You forgot to run checkpatch.pl.  C++ comments are not allowed.

> +#else /* !SERIAL_IMX */
> +static inline void mxc_init_imx_uart(void)
> +{
> +}
> +#endif /* SERIAL_IMX */

How about:

#define mxc_init_imx_uart() do { } while (0)

-- 
Timur Tabi
Linux kernel developer at Freescale
