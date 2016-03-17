From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 10:03:05 -0500
Subject: [PATCH 5/5] pwm: pwm-tiehrpwm: Update dt binding document to use
 generic node name
In-Reply-To: <1457380318-15452-6-git-send-email-fcooper@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
 <1457380318-15452-6-git-send-email-fcooper@ti.com>
Message-ID: <20160317150305.GA27356@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 01:51:58PM -0600, Franklin S Cooper Jr wrote:
> Now that the node name has been changed from ehrpwm to pwm the document
> should show this proper usage. Also change the unit address in the example
> from 0 to the proper physical address value that should be used.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> index 9c100b2..20211ed 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> @@ -15,14 +15,14 @@ Optional properties:
>  
>  Example:
>  
> -ehrpwm0: ehrpwm at 0 { /* EHRPWM on am33xx */
> +ehrpwm0: pwm at 48300200 { /* EHRPWM on am33xx */
>  	compatible = "ti,am33xx-ehrpwm";
>  	#pwm-cells = <3>;
>  	reg = <0x48300200 0x100>;
>  	ti,hwmods = "ehrpwm0";
>  };
>  
> -ehrpwm0: ehrpwm at 0 { /* EHRPWM on da850 */
> +ehrpwm0: pwm at 01f00000 { /* EHRPWM on da850 */

No leading 0s, but more importantly the address is wrong.

>  	compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
>  	#pwm-cells = <3>;
>  	reg = <0x300000 0x2000>;
> -- 
> 2.7.0
> 
