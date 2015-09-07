From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 7 Sep 2015 18:38:59 +0200
Subject: [PATCH] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <1441639328-2615-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1441639328-2615-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150907163859.GB3237@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/09/2015 at 17:22:08 +0200, Sylvain Rochet wrote :
> Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
> pullup only increase power consumption while transmitting with no value
> added.
> 
> Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
> floating and so consuming a useless extra amount of power if nothing is
> externally connected to dbgu.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>  arch/arm/boot/dts/at91rm9200.dtsi  | 4 ++--
>  arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9263.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
>  arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9rl.dtsi  | 4 ++--
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
>  arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
>  arch/arm/boot/dts/sama5d4.dtsi     | 4 ++--
>  10 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
> index 60edd8b..12815f6d 100644
> --- a/arch/arm/boot/dts/at91rm9200.dtsi
> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> @@ -481,8 +481,8 @@
>  				dbgu {
>  					pinctrl_dbgu: dbgu-0 {
>  						atmel,pins =
> -							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA30 periph A */
> -							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA31 periph with pullup */
> +							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA30 periph A with pullup */
> +							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA31 periph */

I would prefer dropping those useless (and sometimes wrong) comments
when reworking the pinctrl. This is also valid for 2/2

Else, the change makes sense.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
