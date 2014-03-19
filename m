From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Wed, 19 Mar 2014 13:47:38 -0300
Subject: stmmac-socfpga breakage in arm-soc
In-Reply-To: <29079107.ja9Hu9mMY0@wuerfel>
References: <201403191333.01095.arnd@arndb.de> <4337501.shzGE38xmF@wuerfel>
 <5329AAE1.7030705@gmail.com> <29079107.ja9Hu9mMY0@wuerfel>
Message-ID: <5329CA2A.8030309@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

El 19/03/14 11:58, Arnd Bergmann escribi?:
(snip)
> diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
> index 5748351..19d5648 100644
> --- a/Documentation/devicetree/bindings/net/stmmac.txt
> +++ b/Documentation/devicetree/bindings/net/stmmac.txt
> @@ -31,6 +31,10 @@ Optional properties:
>   - reset-names: Should contain the reset signal name "stmmaceth", if a
>   	reset phandle is given
>   - max-frame-size: See ethernet.txt file in the same directory
> +- clocks: If present, the first clock should be the GMAC main clock,
> +  further clocks may be specified in derived bindings
> +- clock-names: One name for each entry in the clocks property, the
> +  first one should be "stmmaceth".
>
>   Examples:
>
> @@ -43,4 +47,6 @@ Examples:
>   		mac-address = [000000000000]; /* Filled in by U-Boot */
>   		max-frame-size = <3800>;
>   		phy-mode = "gmii";
> +		clocks = <&clock>;
> +		clock-names = "stmmaceth">

There's a small typo there on the ;

Cheers,

Emilio
