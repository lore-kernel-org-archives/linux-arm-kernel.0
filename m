From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 14 Mar 2017 13:26:50 +0100
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Specify serial console parameters
In-Reply-To: <20170314075830.2247-1-zajec5@gmail.com>
References: <20170314075830.2247-1-zajec5@gmail.com>
Message-ID: <20170314122650.GV15842@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 08:58:29AM +0100, Rafa?? Mi??ecki wrote:
> From: Rafa?? Mi??ecki <rafal@milecki.pl>
> 
> This adds baud rate, parity & number of data bits. It's required to get
> serial working correctly.
> 
> Signed-off-by: Rafa?? Mi??ecki <rafal@milecki.pl>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 8fd1ef9f0c2d..468107166a6f 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -18,8 +18,12 @@
>  / {
>  	interrupt-parent = <&gic>;
>  
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
>  	chosen {
> -		stdout-path = &uart0;
> +		stdout-path = "serial0:115200n8";
>  	};

Hi Rafal

The alias is fine. But putting the stdout-path here is unusual. Which
serial port is used for console is board specific, where as
bcm5301x.dtsi is very generic, it describes the SoC, not a board.  If
you look at other .dtsi files, those that specify stdout-path contain
properties which are common to a range of similar boards.

	   Andrew
