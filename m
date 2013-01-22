From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 22 Jan 2013 10:15:54 +0000
Subject: [PATCH] ARM: dts: specify all the per-cpu interrupts of arch
 timer for exynos5440
In-Reply-To: <1358818887-16870-1-git-send-email-kgene.kim@samsung.com>
References: <1358818887-16870-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20130122101554.GA18876@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 01:41:27AM +0000, Kukjin Kim wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Need to be changed requirements in the 'cpus' node for exynos5440
> to specify all the per-cpu interrupts of arch timer.

The node(s) for the arch timer should not be in the cpus/cpu at N nodes.
Instead, there should be one node (in the root of the tree).

If this works currently it's only because the driver picks up one of the nodes,
and luckily it's the same as the others. This is not guaranteed to work in
future, and will likely break.

> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5440.dtsi |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 5406689..c5bd8ed 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -28,7 +28,10 @@
>  			compatible = "arm,cortex-a15";
>  			timer {
>  				compatible = "arm,armv7-timer";
> -				interrupts = <1 13 0xf08>;
> +				interrupts = <1 13 0xf08>,
> +					     <1 14 0xf08>,
> +					     <1 11 0xf08>,
> +					     <1 10 0xf08>;

Also, this interrupts list is updated differently to all the other nodes. Typo?

>  				clock-frequency = <1000000>;
>  			};
>  		};
> @@ -36,7 +39,10 @@
>  			compatible = "arm,cortex-a15";
>  			timer {
>  				compatible = "arm,armv7-timer";
> -				interrupts = <1 14 0xf08>;
> +				interrupts = <1 13 0xf08>;
> +					     <1 14 0xf08>,
> +					     <1 11 0xf08>,
> +					     <1 10 0xf08>;
>  				clock-frequency = <1000000>;
>  			};
>  		};
> @@ -44,7 +50,10 @@
>  			compatible = "arm,cortex-a15";
>  			timer {
>  				compatible = "arm,armv7-timer";
> -				interrupts = <1 14 0xf08>;
> +				interrupts = <1 13 0xf08>;
> +					     <1 14 0xf08>,
> +					     <1 11 0xf08>,
> +					     <1 10 0xf08>;
>  				clock-frequency = <1000000>;
>  			};
>  		};
> @@ -52,7 +61,10 @@
>  			compatible = "arm,cortex-a15";
>  			timer {
>  				compatible = "arm,armv7-timer";
> -				interrupts = <1 14 0xf08>;
> +				interrupts = <1 13 0xf08>;
> +					     <1 14 0xf08>,
> +					     <1 11 0xf08>,
> +					     <1 10 0xf08>;
>  				clock-frequency = <1000000>;
>  			};
>  		};
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Please fix this up to only have one timer node, in the root of the tree.

Thanks,
Mark.
