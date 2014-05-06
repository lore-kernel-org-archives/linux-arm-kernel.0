From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 May 2014 08:20:08 -0700
Subject: [PATCH 10/19] arm: dts: add cooling properties on omap4430 cpu
 node
In-Reply-To: <1395744572-20014-11-git-send-email-alex.shi@linaro.org>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
 <1395744572-20014-11-git-send-email-alex.shi@linaro.org>
Message-ID: <20140506152007.GC18474@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alex Shi <alex.shi@linaro.org> [140325 03:54]:
> From: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> OMAP4430 devices can reach high temperatures and thus
> needs to have cpufreq-cooling on systems running on it.
> 
> This patch adds the required cooling device properties
> so that cpufreq-cpu0 driver loads the cooling device.

Alex, what's the status of this series? I could not find
the complete thread, so wondering what to do with patches
09 - 13?

Regards,

Tony
 
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> (cherry picked from commit 72af5e6d0c3e01655c1c1fc7c7ca94a2b663611e)
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> ---
>  arch/arm/boot/dts/omap443x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
> index cccf39a..d2deba0 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -22,6 +22,11 @@
>  				1008000 1375000
>  			>;
>  			clock-latency = <300000>; /* From legacy driver */
> +
> +			/* cooling options */
> +			cooling-min-level = <0>;
> +			cooling-max-level = <3>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  	};
>  };
> -- 
> 1.8.1.2
> 
