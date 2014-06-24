From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 24 Jun 2014 19:51:01 +0900
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <000001cf8f9a$3045f3a0$90d1dae0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 24, 2014 7:35 PM, Antoine Tenart wrote:
> 
> Add a generic ChipIdea driver, with optional PHY and clock, to support
> ChipIdea controllers that doesn't need specific functions.

s/doesn't/don't

> 
> Needed for the Marvell Berlin SoCs SUB controllers.

s/SUB/USB

> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  drivers/usb/chipidea/Makefile          |   1 +
>  drivers/usb/chipidea/ci_hdrc_generic.c | 108 +++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 drivers/usb/chipidea/ci_hdrc_generic.c
> 
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index 2f099c7df7b5..c705f0fe7a00 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -20,4 +20,5 @@ endif
> 
>  ifneq ($(CONFIG_OF),)
>  	obj-$(CONFIG_USB_CHIPIDEA)	+= usbmisc_imx.o ci_hdrc_imx.o
> +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_generic.o
>  endif
> diff --git a/drivers/usb/chipidea/ci_hdrc_generic.c b/drivers/usb/chipidea/ci_hdrc_generic.c
> new file mode 100644
> index 000000000000..27520710a1f7
> --- /dev/null
> +++ b/drivers/usb/chipidea/ci_hdrc_generic.c

[...]

> +
> +MODULE_DESCRIPTION("Generic ChipIdea HDRC USB binding");
> +MODULE_AUTHOR("Antoine T?nart <antoine.tenart@free-electrons.com>");
> +MODULE_LICENSE("GPL");

How about "GPL v2"?

Best regards,
Jingoo Han

> --
> 1.9.1
