From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Nov 2016 20:53:38 -0600
Subject: [RFC 1/6] drm/etnaviv: add binding for the gc320 found in ti socs
In-Reply-To: <20161118024436.13447-1-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Message-ID: <0bf288ee-33bc-c3b5-389f-08d9bb89ccb5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 08:44 PM, Robert Nelson wrote:

Could we write at least a oneline commit message? :)

Might want to state that since the TI gpu systems are a mixed bunch 
and  certain SoCs may have more than 1 GPU integrated, we indicate 
clearly the rev here?
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Julien <jboulnois@gmail.com>
> CC: Christian Gmeiner <christian.gmeiner@gmail.com>
> CC: Russell King <rmk+kernel@arm.linux.org.uk>
> CC: Lucas Stach <l.stach@pengutronix.de>
> CC: Nishanth Menon <nm@ti.com>
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt | 1 +
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c                             | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> index ed5e0a7..9fa259d 100644
> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> +++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible: Should be one of
>      "fsl,imx-gpu-subsystem"
>      "marvell,dove-gpu-subsystem"
> +    "ti,gc320-gpu-subsystem"
>  - cores: Should contain a list of phandles pointing to Vivante GPU devices
>
>  example:
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index a6799b0..ce51270 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -653,6 +653,7 @@ static int etnaviv_pdev_remove(struct platform_device *pdev)
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "fsl,imx-gpu-subsystem" },
>  	{ .compatible = "marvell,dove-gpu-subsystem" },
> +	{ .compatible = "ti,gc320-gpu-subsystem" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
>


-- 
Regards,
Nishanth Menon
