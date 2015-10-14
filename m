From: rogerq@ti.com (Roger Quadros)
Date: Wed, 14 Oct 2015 11:46:19 +0300
Subject: [PATCH] ARM: dts: am437x-gp-evm: Add wakeup interrupt source for
 pixcir_i2c_ts
In-Reply-To: <1444801956-17817-1-git-send-email-vigneshr@ti.com>
References: <1444801956-17817-1-git-send-email-vigneshr@ti.com>
Message-ID: <561E165B.3000907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Dave

On 14/10/15 08:52, Vignesh R wrote:
> On am437x-gp-evm, pixcir_i2c_ts can wakeup the system from lower power
> state via pinctrl and IO daisy chain using generic wakeirq framework.
> With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
> interrupt in device tree") i2c core allows optional wakeirq to be
> specified via device tree. Add wakeup irq entry to enable pixcir_i2c_ts
> to wake the system from low power state.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 22038f21f228..69e93af7df0d 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -581,8 +581,13 @@
>  
>  		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>  
> +		interrupts-extended = <&gpio3 22 GPIO_ACTIVE_HIGH>,
> +				      <&am43xx_pinmux 0x264>;

How does this work?

interrupts-extended property must have
1) interrupt parent
2) interrupt number
3) interrupt flags

Your change doesn't seem to comply with those requirements.

> +		interrupt-names = "tsc", "wakeup";
> +
>  		touchscreen-size-x = <1024>;
>  		touchscreen-size-y = <600>;
> +		wakeup-source;
>  	};
>  
>  	ov2659 at 30 {
> 

cheers,
-roger
