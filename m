From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 3 Mar 2015 19:19:45 +0100
Subject: [PATCH 1/1] ARM: at91sam9263/dt: Fixup sram1 device tree node
In-Reply-To: <1424853304-32197-1-git-send-email-alexanders83@web.de>
References: <1424853304-32197-1-git-send-email-alexanders83@web.de>
Message-ID: <54F5FB41.3000506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/02/2015 09:35, Alexander Stein a ?crit :
> Commit ff04660e48b20 ("ARM: at91/dt: add SRAM nodes") used the same base
> address for sram0 and sram1 leading to the following warning:
> WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x50/0x70()
> sysfs: cannot create duplicate filename '/devices/platform/300000.sram'
> Fix the base address for sram1.
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Added to at91-4.0-fixes. Thanks.

> ---
>  arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index cdb7d03..76bb849 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -69,7 +69,7 @@
>  
>  	sram1: sram at 00500000 {
>  		compatible = "mmio-sram";
> -		reg = <0x00300000 0x4000>;
> +		reg = <0x00500000 0x4000>;
>  	};
>  
>  	ahb {
> 


-- 
Nicolas Ferre
