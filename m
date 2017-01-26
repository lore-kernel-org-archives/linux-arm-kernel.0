From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 25 Jan 2017 16:27:55 -0800
Subject: [PATCH v3 4/4] ARM: dts: Enable Broadcom iProc mailbox controller
In-Reply-To: <1485390422-3984-5-git-send-email-jonathan.richardson@broadcom.com>
References: <1485390422-3984-1-git-send-email-jonathan.richardson@broadcom.com>
 <1485390422-3984-5-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <32cbeb0b-d27a-58ac-654d-4eadf0cceec7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 04:27 PM, Jonathan Richardson wrote:
> Add node for iProc mailbox controller and enable.
> 
> Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index cf02271..606e11a 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -121,6 +121,12 @@
>  			      <0x0301d24c 0x2c>;
>  		};
>  
> +		mailbox: mailbox at 03024024 {
> +			compatible = "brcm,iproc-mailbox";
> +			reg = <0x03024024 0x8>;
> +			#mbox-cells = <1>;
> +		};

Can you squash this change with the previous one? It seems to me like
you are just removing the interrupt properties, and updating the reg
property to be only 0x8 bytes.

Thank you
-- 
Florian
