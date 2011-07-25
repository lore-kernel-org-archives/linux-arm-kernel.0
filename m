From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 25 Jul 2011 09:21:24 +0200
Subject: [PATCH v2 4/6] ARM: mxs: make ehci-mxc more flexible to be used on
	different platforms
In-Reply-To: <1311577284-11506-5-git-send-email-tony.lin@freescale.com>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
	<1311577284-11506-5-git-send-email-tony.lin@freescale.com>
Message-ID: <20013.6516.543849.414777@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tony Lin writes:
> change ehci_irq to mxc_ehci_irq to give chance do some platform specific
> actions in irq handler for different platforms.
> add void pointer in the last of mxc_usbh_platform_data structure so that
> additional information could be added to that field if needed.
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/hardware.h |    2 ++
>  arch/arm/mach-mxs/include/mach/mxs.h      |   12 +++++++++++-
>  drivers/usb/host/Kconfig                  |    2 +-
>  drivers/usb/host/ehci-mxc.c               |   17 +++++++++++++++--
>  include/linux/fsl_devices.h               |    4 +++-
>  5 files changed, 32 insertions(+), 5 deletions(-)
> 
[...]
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index bc2c1bf..cf441e8 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -118,8 +118,10 @@ struct mxc_usbh_platform_data {
>  	int (*init)(struct platform_device *pdev);
>  	int (*exit)(struct platform_device *pdev);
>  
> -	unsigned int		 portsc;
> +	unsigned int		portsc;
>  	struct otg_transceiver	*otg;
> +	void (*plt_irq_handler)(struct mxc_usbh_platform_data *pdata);
> +	void		*ppriv;
>  };
>  
You just added this structure in patch 1/6. Then modify it in this
patch. The indentation change should be incorporated into the first
patch.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
