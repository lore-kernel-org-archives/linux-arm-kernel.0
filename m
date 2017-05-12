From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 12 May 2017 06:42:21 +0200
Subject: [PATCH] ARM: remove duplicate 'const' annotations'
In-Reply-To: <20170511115059.2997141-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Thu, 11 May 2017 13:50:16 +0200")
References: <20170511115059.2997141-1-arnd@arndb.de>
Message-ID: <m3vap6hej6.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> gcc-7 warns about some declarations that are more 'const' than necessary:

> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -346,7 +346,7 @@ static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
>  	.power_off	= csn3xxx_usb_power_off,
>  };
>  
> -static const struct of_dev_auxdata const cns3xxx_auxdata[] __initconst = {
> +static const struct of_dev_auxdata cns3xxx_auxdata[] __initconst = {
>  	{ "intel,usb-ehci", CNS3XXX_USB_BASE, "ehci-platform", &cns3xxx_usb_ehci_pdata },
>  	{ "intel,usb-ohci", CNS3XXX_USB_OHCI_BASE, "ohci-platform", &cns3xxx_usb_ohci_pdata },
>  	{ "cavium,cns3420-ahci", CNS3XXX_SATA2_BASE, "ahci", NULL },

Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
