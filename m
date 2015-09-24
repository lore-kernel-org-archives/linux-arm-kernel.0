From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 24 Sep 2015 17:36:58 +0100
Subject: [PATCH v4 5/5] arm64: dts: Add sensor node to Juno dt
In-Reply-To: <1442335861-7282-6-git-send-email-punit.agrawal@arm.com>
References: <1442335861-7282-1-git-send-email-punit.agrawal@arm.com>
 <1442335861-7282-6-git-send-email-punit.agrawal@arm.com>
Message-ID: <20150924163658.GH2368@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 05:51:01PM +0100, Punit Agrawal wrote:
> The SCP firmware on Juno provides access to SoC sensors via the
> SCPI. Add the sensor nodes to the device tree to enable this support.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index c624208..dd5158e 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -96,6 +96,11 @@
>  				clock-output-names = "pxlclk0", "pxlclk1";
>  			};
>  		};
> +
> +		scpi_sensors0: sensors {
> +			compatible = "arm,scpi-sensors";
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	/include/ "juno-clocks.dtsi"
> -- 
> 2.5.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
