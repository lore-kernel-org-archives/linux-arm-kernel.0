From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 Jan 2013 10:10:44 +0800
Subject: [PATCH 2/6] ARM: dts: fix highbank cpu mpidr values
In-Reply-To: <1356884107-30991-3-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
 <1356884107-30991-3-git-send-email-robherring2@gmail.com>
Message-ID: <20130106021041.GA22517@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 30, 2012 at 10:15:03AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> With the addition of commit a0ae0240 (ARM: kernel: add device tree init
> map function), the cpu reg values must match the cpu mpidr register or we'll
> get warnings. For some reason, the CLUSTERID on highbank is 9, so the reg
> value needs to be 0x90n to quiet the warnings.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/boot/dts/highbank.dts |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
> index 81e0bfa..5927a8d 100644
> --- a/arch/arm/boot/dts/highbank.dts
> +++ b/arch/arm/boot/dts/highbank.dts
> @@ -30,37 +30,37 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		cpu at 900 {

Just a reminder - this change will break highbank cpufreq driver that
Mark is submitting.

Shawn

>  			compatible = "arm,cortex-a9";
>  			device_type = "cpu";
> -			reg = <0>;
> +			reg = <0x900>;
>  			next-level-cache = <&L2>;
>  			clocks = <&a9pll>;
>  			clock-names = "cpu";
>  		};
