From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 21:09:04 +0200
Subject: [PATCH 2/9] ARM: dts: rockchip: rk3288-vyasa: Use fixed voltage
 range for vccio_sd
In-Reply-To: <1508156187-27519-3-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
 <1508156187-27519-3-git-send-email-jagan@amarulasolutions.com>
Message-ID: <3394467.76otEihhKb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 16. Oktober 2017, 17:46:20 CEST schrieb Jagan Teki:
> vccio_sd has supplied to vqmmc-supply for sdmmc, use fixed voltage
> range of 3.3v for better IO lines supply voltage.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

not sure I understand this one.

I.e. the regulator should be at 3.3V anyway and only when it
reaches UHS speeds should the mmc core reduce the voltage
to 1.8V, so having this variable here, shouldn't pose a problem?

So maybe you could explain a bit more what the problem is?


Thanks
Heiko

> ---
>  arch/arm/boot/dts/rk3288-vyasa.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
> index 7a0f945..915b4a3 100644
> --- a/arch/arm/boot/dts/rk3288-vyasa.dts
> +++ b/arch/arm/boot/dts/rk3288-vyasa.dts
> @@ -214,7 +214,7 @@
>  
>  			vccio_sd: LDO_REG5 {
>  				regulator-name = "vccio_sd";
> -				regulator-min-microvolt = <1800000>;
> +				regulator-min-microvolt = <3300000>;
>  				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  				regulator-boot-on;
> 
