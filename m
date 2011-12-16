From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 16 Dec 2011 09:51:24 +0100
Subject: [PATCHv8 3/5] OMAP: I2C: Reset support
In-Reply-To: <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <4EEB068C.3010501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhro,

On 12/13/2011 11:55 AM, Shubhrajyoti D wrote:
> Under some error conditions the i2c driver may do a reset.
> Adding a reset field and support in the device-specific code to aid
> error-recovery.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
>   arch/arm/plat-omap/i2c.c |    2 ++
>   include/linux/i2c-omap.h |    1 +
>   2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index db071bc..6cddde2 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -179,6 +179,8 @@ static inline int omap2_i2c_add_bus(int bus_id)
>   	 */
>   	if (cpu_is_omap34xx())
>   		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
> +
> +	pdata->device_reset = omap_device_reset;

We should avoid introducing any new pdata function pointers since we are 
in the process of removing them for DT support.

Regards,
Benoit
