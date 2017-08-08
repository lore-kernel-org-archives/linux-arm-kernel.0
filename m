From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 08 Aug 2017 21:43:58 +0800
Subject: [PATCH 0/4] constify thermal_zone_of_device_ops structures
In-Reply-To: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502199838.4296.64.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-08-05 at 22:37 +0200, Julia Lawall wrote:
> The thermal_zone_of_device_ops structures are only passed as the
> fourth
> argument to thermal_zone_of_sensor_register, which is declared as
> const.
> Thus the thermal_zone_of_device_ops structures themselves can be
> const.
> 
> Done with the help of Coccinelle.

I still see the same problem in other thermal drivers, which is not
covered by this patch set. Can we fix them all in one time?

thanks,
rui
> 
> ---
> 
> ?drivers/thermal/broadcom/bcm2835_thermal.c |????2 +-
> ?drivers/thermal/qoriq_thermal.c????????????|????2 +-
> ?drivers/thermal/samsung/exynos_tmu.c???????|????2 +-
> ?drivers/thermal/zx2967_thermal.c???????????|????2 +-
> ?4 files changed, 4 insertions(+), 4 deletions(-)
