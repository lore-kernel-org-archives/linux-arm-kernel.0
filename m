From: robherring2@gmail.com (Rob Herring)
Date: Tue, 01 Oct 2013 14:23:05 -0500
Subject: [PATCH 1/2] arm: socfpga: Add clock for smp_twd timer
In-Reply-To: <1379435541-26338-1-git-send-email-dinguyen@altera.com>
References: <1379435541-26338-1-git-send-email-dinguyen@altera.com>
Message-ID: <524B2119.3020702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2013 11:32 AM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Assign a clock for the twd-timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/boot/dts/socfpga.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index acd6c3a..e28df94 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -480,11 +480,11 @@
>  			clock-names = "biu", "ciu";
>  		};
>  
> -		/* Local timer */
> -		timer at fffec600 {
> +		local-timer at fffec600 {

timer was the right name.

>  			compatible = "arm,cortex-a9-twd-timer";
>  			reg = <0xfffec600 0x100>;
>  			interrupts = <1 13 0xf04>;
> +			clocks = <&mpu_periph_clk>;

Otherwise, this looks fine and I wouldn't expect much input on a change
that doesn't add a new binding.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

>  		};
>  
>  		timer0: timer0 at ffc08000 {
> 
