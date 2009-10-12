From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 12 Oct 2009 18:25:27 -0400
Subject: [RFC PATCH v1] EP93XX: Add ADC support
In-Reply-To: <20091012142413.30881.62391.stgit@archeopterix.techworks.local>
References: <20091012142413.30881.62391.stgit@archeopterix.techworks.local>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7F74@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 12, 2009 7:24 AM, Christian Gagneraud wrote:
> This patch add support for the ADC found in the EP93XX.
> 
> This work is based on S3C platform ADC, apart from hardware related
> stuff, the following modifications have been done:
> - Remove touchscreen support:
>   On S3C the TS is a "normal" ADC client, but it has priority over all
>   other clients. On EP93XX the TS controller is built-in and offer
>   advanced features.
> - Remove convert and select callbacks:
>   This was done for the shake of simplicity, it can be added easily.
> - Channel definition:
>   On S3c, channel is just an index (unsigned char). On EP93xx channel
>   is the analog switch configuration (unsigned long), it gives the
>   client full freedom on how to make the analog conversion (including
>   routing VRef+ and VRef-, activationg PU/PD resistors, connecting
>   pins to VDD/GND, ...)
> 
> 
> This is a first draft. Comments and criticism welcome.
> 
> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
> ---

[snip]

> diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
> index eae6199..e3c62fe 100644
> --- a/arch/arm/mach-ep93xx/Makefile
> +++ b/arch/arm/mach-ep93xx/Makefile
> @@ -6,6 +6,8 @@ obj-m			:=
>  obj-n			:=
>  obj-			:=
>  
> +obj-$(CONFIG_EP93XX_ADC)	+= adc.o

This Kconfig option is not defined in the patch.

Regards,
Hartley
