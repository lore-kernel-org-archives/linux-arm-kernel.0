From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 25 Mar 2013 08:09:17 +0100
Subject: [PATCH 2/2] pwm: pwm-tiehrpwm: Update device-tree binding document
In-Reply-To: <1364195093-1357-3-git-send-email-avinashphilip@ti.com> (Philip
 Avinash's message of "Mon, 25 Mar 2013 12:34:53 +0530")
References: <1364195093-1357-1-git-send-email-avinashphilip@ti.com>
 <1364195093-1357-3-git-send-email-avinashphilip@ti.com>
Message-ID: <87ehf4ez1e.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Philip" == Philip Avinash <avinashphilip@ti.com> writes:

 Philip> Update binding document of pwm-tiehrpwm to reflect the usage of similar
 Philip> modules in da850 and am3xx SOCs.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 Philip> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
 Philip> Cc: Grant Likely <grant.likely@secretlab.ca>
 Philip> Cc: Rob Herring <rob.herring@calxeda.com>
 Philip> Cc: Rob Landley <rob@landley.net>
 Philip> ---
 Philip>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   12 ++++++++++--
 Philip>  1 file changed, 10 insertions(+), 2 deletions(-)

 Philip> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 Philip> index 4fc7079..9a71369 100644
 Philip> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 Philip> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 Philip> @@ -1,7 +1,9 @@
 Philip>  TI SOC EHRPWM based PWM controller
 
 Philip>  Required properties:
 Philip> -- compatible : Must be "ti,am33xx-ehrpwm"
 Philip> +- compatible: Must be "ti,<soc>-ehrpwm".
 Philip> +  for am33xx - compatible = "ti,am33xx-ehrpwm";
 Philip> +  for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 Philip>  - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
 Philip>    First cell specifies the per-chip index of the PWM to use, the second
 Philip>    cell is the period in nanoseconds and bit 0 in the third cell is used to
 Philip> @@ -15,9 +17,15 @@ Optional properties:
 
 Philip>  Example:
 
 Philip> -ehrpwm0: ehrpwm at 0 {
 Philip> +ehrpwm0: ehrpwm at 0 { /* EHRPWM on am33xx */
 Philip>  	compatible = "ti,am33xx-ehrpwm";
 Philip>  	#pwm-cells = <3>;
 Philip>  	reg = <0x48300200 0x100>;
 Philip>  	ti,hwmods = "ehrpwm0";
 Philip>  };
 Philip> +
 Philip> +ehrpwm0: ehrpwm at 0 { /* EHRPWM on da850 */
 Philip> +	compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 Philip> +	#pwm-cells = <3>;
 Philip> +	reg = <0x300000 0x2000>;
 Philip> +};
 Philip> -- 
 Philip> 1.7.9.5



-- 
Bye, Peter Korsgaard
