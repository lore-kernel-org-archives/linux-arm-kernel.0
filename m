From: dev@lynxeye.de (Lucas Stach)
Date: Tue, 11 Aug 2015 19:05:01 +0200
Subject: [PATCH] arm: rpi: Device tree modifications for U-Boot
In-Reply-To: <1439303153-12171-1-git-send-email-sjg@chromium.org>
References: <1439303153-12171-1-git-send-email-sjg@chromium.org>
Message-ID: <1439312701.2451.3.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

why did you send this to the Tegra ML?

Am Dienstag, den 11.08.2015, 08:25 -0600 schrieb Simon Glass:
> This updates the device tree from the kernel version to something suitable
> for U-Boot:
> 
> - Add stdout-path alias for console
> - Mark the /soc node to be available pre-relocation so that the early
> serial console works (we need the 'ranges' property to be available)
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/boot/dts/bcm2835.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index 301c73f..bd6bff6 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -8,6 +8,7 @@
>  
>  	chosen {
>  		bootargs = "earlyprintk console=ttyAMA0";
> +		stdout-path = &uart;
>  	};
>  
>  	soc {
> @@ -16,6 +17,7 @@
>  		#size-cells = <1>;
>  		ranges = <0x7e000000 0x20000000 0x02000000>;
>  		dma-ranges = <0x40000000 0x00000000 0x20000000>;
> +		u-boot,dm-pre-reloc;

Why do you need this and why should upstream carry your favourite
bootloaders configuration? This is in no way hardware description.

Regards,
Lucas
