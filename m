From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 11 Aug 2017 16:24:49 +0000
Subject: [linux-devel] [PATCH 1/3] dts: usb3: Add configure-gfladj
 property	to USB3 nod
In-Reply-To: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
References: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <AM4PR0401MB1699817496EBA074245E96A28F890@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-devel-bounces at gforge.freescale.net [mailto:linux-devel-
> bounces at gforge.freescale.net] On Behalf Of yinbo.zhu at nxp.com
> Sent: Friday, August 11, 2017 4:30 AM
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
> Subject: [linux-devel] [PATCH 1/3] dts: usb3: Add configure-gfladj property to
> USB3 nod
> 
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 

There is no device tree binding for this property.  You need to add the binding first before you add it to the dts.  And normally you need to describe why the change is needed in the commit message.

> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index ffbf3cf..f525297 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -731,6 +731,8 @@
>  			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
> +			configure-gfladj;
> +			dma-coherent;

This change is not aligned with your patch title.

>  			snps,dis_rxdet_inp3_quirk;
>  		};
> 
> --
> 2.1.0.27.g96db324
> 
> _______________________________________________
> linux-devel mailing list
> linux-devel at gforge.freescale.net
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgforge.
> freescale.net%2Fmailman%2Flistinfo%2Flinux-
> devel&data=01%7C01%7Cleoyang.li%40nxp.com%7C015b054c76ad48399ea408
> d4e09de91d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=7ioU%2Bb
> QUP4X%2F8%2BFpcQZICVDHugioStScbrHc0XOqaQs%3D&reserved=0
