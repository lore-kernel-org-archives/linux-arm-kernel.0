From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 11 Aug 2017 16:38:14 +0000
Subject: [linux-devel] [PATCH 3/3] core-arm: add a member about
 dma_map_ops	in dev_archdata struct
In-Reply-To: <1502445633-33772-1-git-send-email-yinbo.zhu@nxp.com>
References: <1502445633-33772-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <AM4PR0401MB1699052B428E871569697F988F890@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-devel-bounces at gforge.freescale.net [mailto:linux-devel-
> bounces at gforge.freescale.net] On Behalf Of yinbo.zhu at nxp.com
> Sent: Friday, August 11, 2017 5:01 AM
> To: linux-devel at gforge.freescale.net; Yinbo Zhu <yinbo.zhu@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King <linux@armlinux.org.uk>; Felipe Balbi <balbi@kernel.org>
> Cc: open list <devicetree@vger.kernel.org>; Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com>; Catalin Marinas
> <catalin.marinas@arm.com>; open list <linux-usb@vger.kernel.org>; open list
> <linux-kernel@vger.kernel.org>; Doug Ledford <dledford@redhat.com>;
> Stefano Stabellini <sstabellini@kernel.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Bart Van Assche
> <bart.vanassche@sandisk.com>; moderated list <linux-arm-
> kernel at lists.infradead.org>
> Subject: [linux-devel] [PATCH 3/3] core-arm: add a member about
> dma_map_ops in dev_archdata struct
> 
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>

The dma_ops was just moved from struct dev_archdata to struct device with commit 5657933dbb6e25feaf5d8df8c88f96cdade693a3.  Don't duplicate the dma_ops in both places if you don't have a good reason.

> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm/include/asm/device.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index 220ba20..c93d3df 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -7,6 +7,7 @@
>  #define ASMARM_DEVICE_H
> 
>  struct dev_archdata {
> +const struct dma_map_ops        *dma_ops;
>  #ifdef CONFIG_DMABOUNCE
>  	struct dmabounce_device_info *dmabounce;  #endif
> --
> 2.1.0.27.g96db324
> 
> _______________________________________________
> linux-devel mailing list
> linux-devel at gforge.freescale.net
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgforge.
> freescale.net%2Fmailman%2Flistinfo%2Flinux-
> devel&data=01%7C01%7Cleoyang.li%40nxp.com%7Cc83542988dac448bd8b908
> d4e0a230af%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=1pbSjxG781
> yjcCF%2BuXbRCkV6ytbfTTgQkHNWmm0e9nk%3D&reserved=0
