From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Oct 2014 21:57:35 +0200
Subject: [PATCH] ARM: dts: DRA7: Add aliases for all serial ports
In-Reply-To: <1413908295-699-1-git-send-email-nm@ti.com>
References: <1413908295-699-1-git-send-email-nm@ti.com>
Message-ID: <3461773.MMIsJQMVIu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 11:18:15 Nishanth Menon wrote:
> Add serial port aliases for consoles > 6.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 9cc9843..208dd83 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -34,6 +34,10 @@
>                 serial3 = &uart4;
>                 serial4 = &uart5;
>                 serial5 = &uart6;
> +               serial6 = &uart7;
> +               serial7 = &uart8;
> +               serial8 = &uart9;
> +               serial9 = &uart10;
> 

I think this was wrong to start with: The aliases should be in the per-board
.dts file and only list the ones that are actually connected to the outside.

Otherwise the numbering won't match what's written on the board.

	Arnd
