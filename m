From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 09 Dec 2013 17:56:05 +0000
Subject: [PATCH] ARM64: dts: Add clock-frequency to model cpu nodes
In-Reply-To: <1386335683-11405-1-git-send-email-broonie@kernel.org>
References: <1386335683-11405-1-git-send-email-broonie@kernel.org>
Message-ID: <1386611765.3380.70.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-12-06 at 13:14 +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The clock-frequency property is meaningless for the models but it's a
> mandatory property so claim that all the cores run at 1MHz.

Is it a mandatory property? I know we seem to get ugly warnings if it's
missing but I see no mention of it at all in
Documentation/devicetree/bindings/arm/cpus.txt (am I looking in the
wrong place?)

I think this attribute got merged into the kernel with the early power
related scheduling efforts, but given the state of all that at the
moment I was guessing it might be obsolete.

-- Tixy

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/boot/dts/foundation-v8.dts  | 4 ++++
>  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/foundation-v8.dts b/arch/arm64/boot/dts/foundation-v8.dts
> index 4a060906809d..f91b2fa41fb3 100644
> --- a/arch/arm64/boot/dts/foundation-v8.dts
> +++ b/arch/arm64/boot/dts/foundation-v8.dts
> @@ -34,6 +34,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
> @@ -41,6 +42,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  		cpu at 2 {
>  			device_type = "cpu";
> @@ -48,6 +50,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  		cpu at 3 {
>  			device_type = "cpu";
> @@ -55,6 +58,7 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> index 572005ea2217..d7debfe79d9f 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> @@ -37,6 +37,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
> @@ -44,6 +45,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  		cpu at 2 {
>  			device_type = "cpu";
> @@ -51,6 +53,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  		cpu at 3 {
>  			device_type = "cpu";
> @@ -58,6 +61,7 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			clock-frequency = <1000000>;
>  		};
>  	};
>  
