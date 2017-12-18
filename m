From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 18 Dec 2017 17:12:46 +0100
Subject: [PATCH v4 11/12] thermal: armada: Give meaningful names to the
 thermal zones
In-Reply-To: <20171218143643.7714-12-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Mon, 18 Dec 2017 15:36:42 +0100")
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-12-miquel.raynal@free-electrons.com>
Message-ID: <87d13chv5t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On lun., d?c. 18 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> After registration to the thermal core, sysfs will make one entry
> per instance of the driver in /sys/class/thermal_zoneX and
> /sys/class/hwmon/hwmonX, X being the index of the instance, all of them
> having the type/name "armada_thermal".
>
> Until now there was only one thermal zone per SoC but SoCs like Armada
> A7K and Armada A8K have respectively two and three thermal zones (one
> per AP and one per CP) and this number is subject to grow in the future.
>
> Use dev_name() instead of the "armada_thermal" string to get a
> meaningful name and be able to identify the thermal zones from
> userspace.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Gregory


> ---
>  drivers/thermal/armada_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 4a5164ddffe7..42ef80b3b5f8 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -403,8 +403,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  
>  	priv->data->init_sensor(pdev, priv);
>  
> -	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> +	thermal = thermal_zone_device_register(dev_name(&pdev->dev), 0, 0, priv,
> +					       &ops, NULL, 0, 0);
>  	if (IS_ERR(thermal)) {
>  		dev_err(&pdev->dev,
>  			"Failed to register thermal zone device\n");
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
