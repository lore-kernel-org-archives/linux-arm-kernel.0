From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 6 Nov 2014 21:34:07 -0400
Subject: [PATCH 01/21] thermal: of: Extend of-thermal.c to provide number
 of trip points
In-Reply-To: <1412872737-624-2-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-2-git-send-email-l.majewski@samsung.com>
Message-ID: <20141107013405.GB10180@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lukasz,

On Thu, Oct 09, 2014 at 06:38:37PM +0200, Lukasz Majewski wrote:
> This patch extends the of-thermal.c to provide information about number of
> available trip points.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/of-thermal.c   | 6 ++++++
>  drivers/thermal/thermal_core.h | 5 +++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index f8eb625..b2390d9 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -113,6 +113,12 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
>  	return data->get_temp(data->sensor_data, temp);
>  }
>  
> +int of_thermal_get_ntrips(struct thermal_zone_device *tz)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +	return data->ntrips;
> +}

I am not against this addition. I just request you to document it
accordingly.

> +
>  static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 3db339f..587ca5c 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -81,9 +81,14 @@ static inline void thermal_gov_user_space_unregister(void) {}
>  #ifdef CONFIG_THERMAL_OF
>  int of_parse_thermal_zones(void);
>  void of_thermal_destroy_zones(void);
> +int of_thermal_get_ntrips(struct thermal_zone_device *);
>  #else
>  static inline int of_parse_thermal_zones(void) { return 0; }
>  static inline void of_thermal_destroy_zones(void) { }
> +static inline int of_thermal_get_ntrips(struct thermal_zone_device *)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif /* __THERMAL_CORE_H__ */
> -- 
> 2.0.0.rc2
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/41acfa02/attachment.sig>
