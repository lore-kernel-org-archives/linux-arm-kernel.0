From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 16:04:45 +0100
Subject: [PATCH V2 1/7] arm64: dts: Add APM X-Gene USB DTS node
In-Reply-To: <1415924401-3013-2-git-send-email-fkan@apm.com>
References: <1415924401-3013-1-git-send-email-fkan@apm.com>
 <1415924401-3013-2-git-send-email-fkan@apm.com>
Message-ID: <2126031.OOHBs2pzVu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 16:19:55 Feng Kan wrote:
> 
> +               usb0: dwusb at 19000000 {
> +                       status = "disabled";
> +                       compatible = "xhci-platform";
> +                       reg =  <0x0 0x19000000 0x0 0x100000>;
> +                       interrupts = <0x0 0x89 0x4>;
> +                       dma-coherent;
> +               };
> +
> +               usb1: dwusb at 19800000 {
> +                       status = "disabled";
> +                       compatible = "xhci-platform";
> +                       reg =  <0x0 0x19800000 0x0 0x100000>;
> +                       interrupts = <0x0 0x8a 0x4>;
> +                       dma-coherent;
> +               };
> 

Call the nodes 'usb', not 'dwusb'. Should these be 'status="disabled"', or
do you expect every machine to have both connected?

	Arnd
