From: mporter@konsulko.com (Matt Porter)
Date: Mon, 27 Jul 2015 10:09:11 -0400
Subject: [PATCH-v5 1/5] Documentation: binding: add new property
 'disable_after_xfer' to i2c-pxa
In-Reply-To: <1437482466-16126-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437482466-16126-2-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150727140911.GB15004@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 06:11:02PM +0530, Vaibhav Hiremath wrote:
> Driver will now supports enable/disable across msg xfer, which user
> can control it by new DT property -
> 
> i2c-disable-after-xfer : If set, driver will disable I2C module after msg
>  xfer and enable it back before xfer.

If this is a new property specific to this Marvell part, it needs
the vendor prefix as in mrvl,i2c-disable-after-xfer

Or, it couldn't hurt to start an i2c.txt for generic i2c bindings
and store it there as this and others later in this series would
reasonably apply to other controllers.

-Matt

> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> index 12b78ac..9657db5 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> @@ -18,6 +18,11 @@ Recommended properties :
>     status register of i2c controller instead.
>   - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
>  
> +Optional properties :
> +
> + - i2c-disable-after-xfer : If set, driver will disable I2C module
> +   after msg xfer and enable it again before xfer.
> +
>  Examples:
>  	twsi1: i2c at d4011000 {
>  		compatible = "mrvl,mmp-twsi";
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
