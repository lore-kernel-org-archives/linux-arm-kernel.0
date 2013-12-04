From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Dec 2013 11:19:07 +0000
Subject: [PATCH 3/3] ARM: dts: bcm281xx: define real clocks
In-Reply-To: <529EA813.2070208@linaro.org>
References: <529EA78E.7060904@linaro.org>
 <529EA813.2070208@linaro.org>
Message-ID: <20131204111906.GG16025@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:57:07AM +0000, Alex Elder wrote:
> Replace the "fake" clocks defined in the "bcm11351.dtsi" device tree
> file with real definitions backed by the new BCM281xx clock driver..
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi |  222
> ++++++++++++++++++++++++++++-----------
>  1 file changed, 161 insertions(+), 61 deletions(-)

[...]

> +		/*
> +		    * This is a place-holder clock for peripheral
> +		    * clocks that set their parent clock to an
> +		    * out-of-range value to explicitly select
> +		    * "no clock" as a parent.
> +		    */
> +		not_selected_clk: not_selected {
>  			#clock-cells = <0>;
> -		};

Huh? This doesn't seem to be used at all in this series. Why is this
here?

Thanks,
Mark.
