From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 20 Aug 2013 23:57:26 +0000 (UTC)
Subject: [PATCH 3/3] ARM: OMAP4: dts: Add main and optional clock data
 into DT
In-Reply-To: <1374560679-14666-4-git-send-email-rnayak@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-4-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1308202352330.6426@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 23 Jul 2013, Rajendra Nayak wrote:

> With support to parse clock data from DT, move all main and optional
> clock information from hwmod to DT.
> 
> We still retain clocks in hwmod for devices which do not have a DT node.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  112 ----------------------------
>  2 files changed, 100 insertions(+), 112 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 8e142f9..4dddf64 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -106,6 +106,8 @@
>  			compatible = "ti,omap-counter32k";
>  			reg = <0x4a304000 0x20>;
>  			ti,hwmods = "counter_32k";
> +			clocks = <&sys_32k_ck>;
> +			clock-names = "fck";

Shouldn't these patches be using the official DT clock binding format?  
Either the 'clocks' property should be something like:

    clocks = <&prm 10>;

or a change to the bindings needs to be discussed and implemented.


- Paul
