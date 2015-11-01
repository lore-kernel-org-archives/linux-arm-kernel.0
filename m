From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 2 Nov 2015 00:45:20 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: Add support for DENX MA5D4 SoM
 and EVK
In-Reply-To: <1446420425-5491-1-git-send-email-marex@denx.de>
References: <1446420425-5491-1-git-send-email-marex@denx.de>
Message-ID: <20151101234520.GH22331@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 02/11/2015 at 00:27:05 +0100, Marek Vasut wrote :
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +

You probably don't need those three properties

> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <12000000>;
> +		};
> +

likewise, if you don't need to boot on older kernels, I'd suggest
removing clock at 0.

> +/ {
> +	model = "DENX MA5D4EVK";
> +	compatible = "denx,ma5d4evk", "atmel,sama5d4", "atmel,sama5";
> +
> +	chosen {
> +		bootargs = "ignore_loglevel earlyprintk";

I think you don't really want to enforce those options, especially
earlyprintk as it can lead to a crash if UART_PHYS is not set properly
(for example, I usually boot the same kernel on sama5d3 and sama5d4).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
