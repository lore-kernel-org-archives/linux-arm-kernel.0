From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun, 18 Nov 2012 19:46:00 -0800
Subject: [PATCH 0/4] Implement device tree support for ab8500 BM Devices
In-Reply-To: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
References: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
Message-ID: <20121119034600.GP29066@lizard.sbx05977.paloaca.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 03:40:29PM +0000, Rajanikanth H.V wrote:
> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> 
> This patch-set adds device tree binding for ab8500 battery-managed
> devices. Removes the redundant platform structure maintained
> across bm devices and implements common DT probe routine across all the
> modules.

Thanks for the patches, Rajanikanth.

The mfd changes seemed very minor, so I impudently applied the patches to
the battery tree. :)

(But I'm bouncing the patches to Samuel and Mark anyway, jfyi.)

p.s.

FWIW, I fixed these warnings.

  CHECK   drivers/power/ab8500_bmdata.c
drivers/power/ab8500_bmdata.c:146:23: warning: symbol 'temp_to_batres_tbl_thermistor' was not declared. Should it be static?
drivers/power/ab8500_bmdata.c:160:23: warning: symbol 'temp_to_batres_tbl_ext_thermistor' was not declared. Should it be static?
drivers/power/ab8500_bmdata.c:171:23: warning: symbol 'temp_to_batres_tbl_9100' was not declared. Should it be static?
drivers/power/ab8500_bmdata.c:181:28: warning: symbol 'bat_type_thermistor' was not declared. Should it be static?
drivers/power/ab8500_bmdata.c:267:28: warning: symbol 'bat_type_ext_thermistor' was not declared. Should it be static?

Plus fixed a few stylistic issues.

Thanks,
Anton.
