From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 07 Jul 2018 11:47:07 +1000
Subject: [PATCH] [RESEND] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE
 dependency
In-Reply-To: <20180706135840.908258-1-arnd@arndb.de>
References: <20180706135840.908258-1-arnd@arndb.de>
Message-ID: <05d4a75389d4143bcb53a730ad2e9ceddc99ceb3.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-07-06 at 15:58 +0200, Arnd Bergmann wrote:
> Without that option, we run into a link failure:
> 
> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
> 
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Greg, as discussed in https://patchwork.kernel.org/patch/10427921/,
> please apply this as a bugfix for 4.18.

Which I acked too though on second thoughts, shouldn't the driver
select USB_LIBCOMPOSITE ? No biggie, either way and that patch
can/should go in, we can change things later if we change our mind.

Cheers,
Ben.

>      Arnd
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> index f0cdf89b8503..83ba8a2eb6af 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> @@ -2,6 +2,7 @@
>  config USB_ASPEED_VHUB
>  	tristate "Aspeed vHub UDC driver"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on USB_LIBCOMPOSITE
>  	help
>  	  USB peripheral controller for the Aspeed AST2500 family
>  	  SoCs supporting the "vHub" functionality and USB2.0
