From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jul 2015 11:00:04 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: Use correct dts properties for
 tsadc node
In-Reply-To: <1437543846-19897-2-git-send-email-romain.perier@gmail.com>
References: <1437543846-19897-1-git-send-email-romain.perier@gmail.com>
 <1437543846-19897-2-git-send-email-romain.perier@gmail.com>
Message-ID: <22118807.OAheiiLXpf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 22. Juli 2015, 07:44:06 schrieb Romain Perier:
> tsadc-tshut-mode and tsadc-tshut-polarity properties don't exist. The
> rockchip thermal driver looks for rockchip,hw-tshut-mode and
> rockchip,hw-tshut-polarity instead, otherwise it might freeze or hang the
> device according to the default mode or polarity used.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi
> b/arch/arm/boot/dts/rk3288-veyron.dtsi index 627d113..cc76cf7 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -367,8 +367,8 @@
>  &tsadc {
>  	status = "okay";
> 
> -	tsadc-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
> -	tsadc-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> +	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
> +	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
>  };
> 
>  &uart0 {

applied this one to my dts branch for 4.3 (after adding a veyron to the 
subject).


Thanks for the catch
Heiko
