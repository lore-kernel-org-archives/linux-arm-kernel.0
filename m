From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Feb 2016 13:58:21 -0800
Subject: [GIT PULL] omap device tree changes for v4.6 merge window, part 1
In-Reply-To: <6026634.ihuvqopRan@wuerfel>
References: <20160222215612.GV13417@atomide.com> <6026634.ihuvqopRan@wuerfel>
Message-ID: <20160226215820.GK13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [160226 13:35]:
> On Monday 22 February 2016 13:56:12 Tony Lindgren wrote:
> > Device tree changes for omaps for v4.6 merge window. Mostly just
> > adding board specific devices and few new boards:
> 
> Pulled into next/dt, with a trivial conflict resolution:
> 
> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> @@@ -110,6 -110,19 +110,11 @@@
>   
>   &i2c3 {
>   	clock-frequency = <400000>;
>  -};
>  -
>  -&i2c2 {
>  -	clock-frequency = <400000>;
>  -};
>  -
>  -&i2c3 {
>  -	clock-frequency = <400000>;
> + 	at24 at 50 {
> + 		compatible = "at24,24c02";
> + 		readonly;
> + 		reg = <0x50>;
> + 	};
>   };
>   
>   /*

OK looks god to me thanks.

Tony
