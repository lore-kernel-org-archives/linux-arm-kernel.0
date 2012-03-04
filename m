From: michael@walle.cc (Michael Walle)
Date: Sun, 4 Mar 2012 15:59:23 +0100
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
Message-ID: <201203041559.23810.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 01 M?rz 2012, 19:20:54 schrieb Jason Cooper:
> The comment at mach-kirkwood/common.c:469, says this device is in every
> kirkwood board.  So, it is placed in kirkwood.dtsi.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi   |    6 ++++++
>  arch/arm/mach-kirkwood/board-dt.c |    1 -
>  arch/arm/mach-kirkwood/common.c   |    2 +-
>  arch/arm/mach-kirkwood/common.h   |    1 -
>  drivers/rtc/rtc-mv.c              |   19 +++++++++++++++++++
>  5 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi
> b/arch/arm/boot/dts/kirkwood.dtsi index 771c6bb..5fb185c 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -2,5 +2,11 @@
> 
>  / {
>  	compatible = "marvell,kirkwood";
> +
> +	rtc at f1010300 {
> +		compatible = "marvell,rtc";
what about the names used here?

in my older patch series i flagged all converted devices with two 
compatibility names. Eg:

       { .compatible = "marvell,orion5x-rtc", },
       { .compatible = "marvell,kirkwood-rtc", },

IMHO marvell,rtc is i little too general, i guess marvell won't have only one 
rtc ;)

Other opinions?

-- 
Michael
