From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 14 Nov 2014 21:22:00 +0100
Subject: [PATCH] ARM: mvebu: fix ordering in Armada 370 .dtsi
In-Reply-To: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20141114202200.GI2001@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 08:36:16PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

It is normal to have something in the changelog, even if it is the
same as the subject said differently.

Here you could say something like:

Commit a095b1c78a35f05755 "ARM: mvebu: sort DT nodes by address"
missed placing the system-controller in the correct order.

> ---
>  arch/arm/boot/dts/armada-370.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 6b3c23b1e138..7513410f7b89 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -106,11 +106,6 @@
>  				reg = <0x11100 0x20>;
>  			};
>  
> -			system-controller at 18200 {
> -				compatible = "marvell,armada-370-xp-system-controller";
> -				reg = <0x18200 0x100>;
> -			};
> -
>  			pinctrl {
>  				compatible = "marvell,mv88f6710-pinctrl";
>  				reg = <0x18000 0x38>;
> @@ -205,6 +200,11 @@
>  				interrupts = <91>;
>  			};
>  
> +			system-controller at 18200 {
> +				compatible = "marvell,armada-370-xp-system-controller";
> +				reg = <0x18200 0x100>;
> +			};
> +
>  			gateclk: clock-gating-control at 18220 {
>  				compatible = "marvell,armada-370-gating-clock";
>  				reg = <0x18220 0x4>;

Humm.

Now we have things in the right order, we see that the
system-controller and the clock-gating-controller overlap.

I know the HW engineers have gone a bit crazy around here, so maybe we
have no choice?

     Andrew
