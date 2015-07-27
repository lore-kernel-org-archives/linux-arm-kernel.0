From: mporter@konsulko.com (Matt Porter)
Date: Mon, 27 Jul 2015 10:11:52 -0400
Subject: [PATCH-v5 4/5] Documentation: binding: add sclk adjustment
 properties to i2c-pxa
In-Reply-To: <1437482466-16126-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437482466-16126-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150727141152.GC15004@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 06:11:05PM +0530, Vaibhav Hiremath wrote:
> With addition of PXA910 family of devices, the TWSI module supports
> new feature which allows us to adjust SCLK. i2c-pxa driver takes input
> configuration in nsec and converts it to respective bit-fields,
> 
>  - i2c-sclk-low-time-ns : SCLK low time (tlow)
>    This property is used along with mode selection.
>  - i2c-sclk-high-time-ns : SCLK high time (thigh)
>  - i2c-start-hold-time-ns : Used in case of high speed mode for start bit
>    hold/setup wait counter.
>  - i2c-stop-hold-time-ns : Used in case of high speed mode for stop bit
>    hold/setup wait counter.
>  - i2c-sda-hold-time-ns : Used to calculate hold/setup wait counter for
>    standard and fast mode.

Again, these should have a mrvl prefix..very specific to this PXA
controller.

-Matt

> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> index 9657db5..bb4df60 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> @@ -23,12 +23,25 @@ Optional properties :
>   - i2c-disable-after-xfer : If set, driver will disable I2C module
>     after msg xfer and enable it again before xfer.
>  
> +   (Applicable to PXA910 family):
> +
> + - i2c-sclk-low-time-ns : SCLK low time (tlow), for standard/fast/high
> +   speed mode.
> +   This property is used along with mode selection. Driver uses this property
> +   to set low/high time for standard and fast speed mode, as HW counter
> +   bit-field is same for both.
> + - i2c-sclk-high-time-ns : SCLK high time (thigh), Used in case of high speed
> +   mode only.
> +
>  Examples:
>  	twsi1: i2c at d4011000 {
>  		compatible = "mrvl,mmp-twsi";
>  		reg = <0xd4011000 0x1000>;
>  		interrupts = <7>;
>  		mrvl,i2c-fast-mode;
> +
> +		i2c-sclk-low-time-ns = <988>;
> +		i2c-sclk-high-time-ns = <988>;
>  	};
>  	
>  	twsi2: i2c at d4025000 {
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
