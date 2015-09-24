From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 24 Sep 2015 16:47:53 +0200
Subject: [PATCH] ARM: at91/dt: pullup dbgu rx instead of tx
In-Reply-To: <1443105855-15738-1-git-send-email-peda@lysator.liu.se>
References: <1443105855-15738-1-git-send-email-peda@lysator.liu.se>
Message-ID: <20150924144753.GY4287@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for the patch but you actually got beaten by Sylvain:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368426.html

On 24/09/2015 at 16:44:15 +0200, Peter Rosin wrote :
> From: Peter Rosin <peda@axentia.se>
> 
> It seems pointless to pullup the tx line, but there is value in pulling
> up the rx line.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/sama5d3.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 9e2444b07bce..304a40c5552a 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -545,8 +545,8 @@
>  				dbgu {
>  					pinctrl_dbgu: dbgu-0 {
>  						atmel,pins =
> -							<AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB30 periph A */
> -							 AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB31 periph A with pullup */
> +							<AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB30 periph A with pullup */
> +							 AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB31 periph A */
>  					};
>  				};
>  
> -- 
> 1.7.10.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
