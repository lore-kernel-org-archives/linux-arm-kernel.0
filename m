From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 9 Oct 2018 13:08:26 -0500
Subject: [PATCH] ARM: dts: socfgpa: remove ethernet aliases from dtsi
In-Reply-To: <20181008105641.11505-1-s.trumtrar@pengutronix.de>
References: <20181008105641.11505-1-s.trumtrar@pengutronix.de>
Message-ID: <1a9a28a4-1fb0-9c0e-9722-3b9e51cccde6@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/2018 05:56 AM, Steffen Trumtrar wrote:
> Not all boards use two ethernet devices and/or use them in different
> order. As almost all in-tree boards already define their own ethernet
> aliases, remove them from the dtsi and add the aliases to the two boards,
> that are missing their own definition.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi                    | 2 --
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 4 ++++
>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts   | 4 ++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index b38f8c240558..068aefa15391 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -22,8 +22,6 @@
>  	#size-cells = <1>;
>  
>  	aliases {
> -		ethernet0 = &gmac0;
> -		ethernet1 = &gmac1;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		timer0 = &timer0;
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> index b280e6494193..48821bcd3eb0 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts

This file was renamed to socfpga_cyclone5_de0_nano_soc.dts.

error: arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts: No such file
or directory
error: patch failed: arch/arm/boot/dts/socfpga_cyclone5_socrates.dts:21
error: arch/arm/boot/dts/socfpga_cyclone5_socrates.dts: patch does not apply


Do you mind if I rebase this patch based on the updated arm-soc tree?

Thanks,
Dinh
