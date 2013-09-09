From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Sep 2013 22:41:43 +0800
Subject: [patch 1/1] imx51.dtsi: fix PATA device clock
In-Reply-To: <20130907132507.353801753@rtp-net.org>
References: <20130907132507.353801753@rtp-net.org>
Message-ID: <20130909144140.GF4624@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 07, 2013 at 03:23:14PM +0200, Arnaud Patard wrote:
> Commit 718a35006f3fa48540d69bd649ff76ea4cdc1ef2 adds pata support to the
> imx51.dtsi file and is using clock 161. The problem is that the right clock
> is 172, according to 5d530bb0ad84d403d1aac79a8a8acf2c2b0a8dd7.
> Using the clock 172 makes things work again (and kills a nasty system freeze)
> 
> 
> Tested-by: Steve Klimaszewski <steev@gentoo.org>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Applied with the commit log as below.

ARM: imx51.dtsi: fix PATA device clock

Commit 718a350 (ARM: i.MX51: Add PATA support) adds pata support to the
imx51.dtsi file and is using clock 161. The problem is that the right
clock is 172, according to commit 5d530bb (ARM: i.MX5: Add PATA and SRTC
clocks).  Using the clock 172 makes things work again (and kills a nasty
system freeze).

Tested-by: Steev Klimaszewski <steev@gentoo.org>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Shawn

> 
> Index: linux-next/arch/arm/boot/dts/imx51.dtsi
> ===================================================================
> --- linux-next.orig/arch/arm/boot/dts/imx51.dtsi	2013-09-07 15:08:05.042280170 +0200
> +++ linux-next/arch/arm/boot/dts/imx51.dtsi	2013-09-07 15:08:37.338278750 +0200
> @@ -490,7 +490,7 @@
>  				compatible = "fsl,imx51-pata", "fsl,imx27-pata";
>  				reg = <0x83fe0000 0x4000>;
>  				interrupts = <70>;
> -				clocks = <&clks 161>;
> +				clocks = <&clks 172>;
>  				status = "disabled";
>  			};
>  
> 
> 
