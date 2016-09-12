From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Sep 2016 23:12:17 +0200
Subject: [PATCH 4/8] arm: orion5x: Alias uart0 to serial0 for all orion5x
In-Reply-To: <1472203264-21089-5-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-5-git-send-email-jm@lentin.co.uk>
Message-ID: <3268478.o1X7VU1Eq9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 26, 2016 10:21:00 AM CEST Jamie Lentin wrote:
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index fbccfbb..001613d 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -17,6 +17,7 @@
>  
>         aliases {
>                 gpio0 = &gpio0;
> +               serial0 = &uart0;
>         };
>  
> 

Please put the alias for the serial port in the board specific .dts file,
it's possible that some boards have more than one uart in use,
and that they don't label them the same way as the SoC internal numbering.

	Arnd
