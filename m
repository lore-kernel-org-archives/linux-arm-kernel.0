From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Dec 2011 13:24:07 -0800
Subject: [PATCH v3 02/11] i2c: OMAP: Add DT support for i2c controller
In-Reply-To: <1324398444-23296-3-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
 <1324398444-23296-3-git-send-email-b-cousson@ti.com>
Message-ID: <CAOesGMiwg9gVDDwCjuCcAPX6hc2E6OgH-c_nAqhCHmj7y5oCeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 20, 2011 at 8:27 AM, Benoit Cousson <b-cousson@ti.com> wrote:


> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a43d002..dcbc1ec 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -37,6 +37,8 @@
> ?#include <linux/platform_device.h>
> ?#include <linux/clk.h>
> ?#include <linux/io.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_device.h>
> ?#include <linux/slab.h>
> ?#include <linux/i2c-omap.h>
> ?#include <linux/pm_runtime.h>
[...]
> @@ -1165,6 +1195,7 @@ static struct platform_driver omap_i2c_driver = {
> ? ? ? ? ? ? ? ?.name ? = "omap_i2c",
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> ? ? ? ? ? ? ? ?.pm ? ? = OMAP_I2C_PM_OPS,
> + ? ? ? ? ? ? ? .of_match_table = of_match_ptr(omap_i2c_of_match),
> ? ? ? ?},
> ?};

of_match_ptr() comes from <linux/of.h>, so you need to include that to
not break !CONFIG_OF builds.


-Olof
