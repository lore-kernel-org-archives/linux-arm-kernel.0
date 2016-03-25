From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 25 Mar 2016 20:22:59 +0300
Subject: [PATCH v3 02/16] mfd: da8xx-cfgchip: New header file for CFGCHIP
 registers.
In-Reply-To: <1458863503-31121-3-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-3-git-send-email-david@lechnology.com>
Message-ID: <56F573F3.90500@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2016 02:51 AM, David Lechner wrote:

> We will be using a generic syscon device for the TI DA8XX SoC CFGCHIPx
> retisters. This will be used by a number of planned drivers including a
> new USB PHY driver and common clock framework drivers.
>
> The same defines are removed from the platform_data header file since they
> are now redundant and they didn't really belong there anyway.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v3 changes: This is a new patch. It replaces the previous patch that just added
> some missing CFGCHIP2 registers to the platform_data/usb-davinci.h file.
> I took David Laight's advice and included all of the possible registers.
>
> Many of these registers will be used for clocks - hopefully in the near future.
>
>
> include/linux/mfd/da8xx-cfgchip.h         | 160 ++++++++++++++++++++++++++++++
>   include/linux/platform_data/usb-davinci.h |  23 -----
>   2 files changed, 160 insertions(+), 23 deletions(-)
>   create mode 100644 include/linux/mfd/da8xx-cfgchip.h
>
> diff --git a/include/linux/mfd/da8xx-cfgchip.h b/include/linux/mfd/da8xx-cfgchip.h
> new file mode 100644
> index 0000000..6940cf9
> --- /dev/null
> +++ b/include/linux/mfd/da8xx-cfgchip.h
> @@ -0,0 +1,160 @@
[...]
> +/* register offsets */
> +#define CFGCHIP_REG(n)				(n * 4)
> +#define CFGCHIP0_REG				CFGCHIP_REG(0)
> +#define CFGCHIP1_REG				CFGCHIP_REG(1)
> +#define CFGCHIP2_REG				CFGCHIP_REG(2)
> +#define CFGCHIP3_REG				CFGCHIP_REG(3)
> +#define CFGCHIP4_REG				CFGCHIP_REG(4)

    Why not just use CFGCHIP_REG(n) directly?

[...]
> diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
> index e0bc4ab..7c6ce24 100644
> --- a/include/linux/platform_data/usb-davinci.h
> +++ b/include/linux/platform_data/usb-davinci.h
[...]
> @@ -53,7 +31,6 @@ struct	da8xx_ohci_root_hub {
>   	/* Time from power on to power good (in 2 ms units) */
>   	u8	potpgt;
>   };
> -

    Why?

>   void davinci_setup_usb(unsigned mA, unsigned potpgt_ms);
>
>   #endif	/* ifndef __ASM_ARCH_USB_H */

MBR, Sergei
