From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 14 Mar 2013 17:13:08 +0530
Subject: [PATCH 2/3] pwm: pwm-tiecap: Add device-tree binding support
 for da850 SOC
In-Reply-To: <1363257158-11615-3-git-send-email-avinashphilip@ti.com>
References: <1363257158-11615-1-git-send-email-avinashphilip@ti.com>
 <1363257158-11615-3-git-send-email-avinashphilip@ti.com>
Message-ID: <5141B7CC.7000700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/14/2013 4:02 PM, Philip Avinash wrote:
> ECAP IP is used in da850 SOC's also. Hence adds ECAP device tree binding
> support for da850.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> ---
> :100644 100644 131e8c1... fcbd3c1... M	Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> :100644 100644 22e96e2... e0d96c8... M	drivers/pwm/pwm-tiecap.c
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |    2 +-
>  drivers/pwm/pwm-tiecap.c                           |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> index 131e8c1..fcbd3c1 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> @@ -1,7 +1,7 @@
>  TI SOC ECAP based APWM controller
>  
>  Required properties:
> -- compatible: Must be "ti,am33xx-ecap"
> +- compatible: Must be "ti,am33xx-ecap" or "ti,da850-ecap"
>  - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
>    First cell specifies the per-chip index of the PWM to use, the second
>    cell is the period in nanoseconds and bit 0 in the third cell is used to
> diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> index 22e96e2..e0d96c8 100644
> --- a/drivers/pwm/pwm-tiecap.c
> +++ b/drivers/pwm/pwm-tiecap.c
> @@ -197,6 +197,7 @@ static const struct pwm_ops ecap_pwm_ops = {
>  
>  static const struct of_device_id ecap_of_match[] = {
>  	{ .compatible	= "ti,am33xx-ecap" },
> +	{ .compatible	= "ti,da850-ecap" },
>  	{},

You add a new compatible, but don't really show any changes in driver in
this series. So why can't we simply use ti,am33xx-ecap on DA850 too?

Thanks,
Sekhar
