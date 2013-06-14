From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 14 Jun 2013 14:45:23 +0300
Subject: [PATCH 1/3] usb: chipidea: add CSR SiRFSoC ci13xxx usb driver
In-Reply-To: <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
 <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <87sj0khq5o.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Barry Song <21cnbao@gmail.com> writes:

> +if USB_CHIPIDEA_UDC && USB_CHIPIDEA_HOST
> +
> +config USB_CHIPIDEA_SIRF
> +	depends on ARCH_SIRF
> +	bool "SiRF USB controller ChipIdea driver binding"
> +	default y
> +	help
> +	  Say Y here to enable sirf usb ChipIdea driver binding.
> +
> +config USB_CHIPIDEA_MSM
> +	depends on ARCH_MSM
> +	bool "MSM USB controller ChipIdea driver binding"
> +	default y
> +	help
> +	  Say Y here to enable msm usb ChipIdea driver binding.
> +
> +config USB_CHIPIDEA_IMX
> +	depends on ARCH_MXC || ARCH_MXS
> +	bool "i.MX USB controller ChipIdea driver binding"
> +	default y
> +	help
> +	  Say Y here to enable imx usb ChipIdea driver binding.
> +
> +endif

No. This is wrong on at least 3 different levels.

> +
>  endif
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index 4ab83e9..7004fde 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -9,7 +9,7 @@ ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
>  
>  # Glue/Bridge layers go here
>  
> -obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
> +obj-$(CONFIG_USB_CHIPIDEA_MSM)	+= ci13xxx_msm.o

No.

>  # PCI doesn't provide stubs, need to check
>  ifneq ($(CONFIG_PCI),)
> @@ -17,5 +17,6 @@ ifneq ($(CONFIG_PCI),)
>  endif
>  
>  ifneq ($(CONFIG_OF_DEVICE),)
> -	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx.o
> +	obj-$(CONFIG_USB_CHIPIDEA_IMX)	+= ci13xxx_imx.o usbmisc_imx.o
> +	obj-$(CONFIG_USB_CHIPIDEA_SIRF)	+= ci13xxx_sirf.o
>  endif

No.

Regards,
--
Alex
