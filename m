From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 05:45:49 +0800
Subject: i.MX pwm patches
In-Reply-To: <1346154504-5623-1-git-send-email-s.hauer@pengutronix.de>
References: <1346154504-5623-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120830214547.GC3613@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 01:48:15PM +0200, Sascha Hauer wrote:
> Hi All,
> 
> The following patches are an overdue work on the i.MX pwm driver.
> 
> - introduce SoC specific functions to make the driver easier to maintain
> - use peripheral clock for pwm output unconditionally
> - separate the two clocks this module has
> - enable ipg clock for register accesses, peripheral clock for enabling
>   the pwm
> - make the driver safe for calling pwm_config before pwm_enable
> - Add devicetree support for i.MX53
> 
> The platform device support is still implemented using cpu_is_*, I think
> this can be dropped completely soon

Anything stops us from doing this right now?  The bonus point of
cleaning this is that we can remove the #include <mach/hardware.h>
from the driver, which is helpful for single-kernel project.

Regards,
Shawn

> as this driver has no in kernel users
> currently, so there should be no need to keep compatibility for platform
> based boards.
> 
> Hopefully this series fixes the issues mentioned by Beno?t. It has been
> tested on an i.MX53 only.
> 
> Sascha
> 
> ----------------------------------------------------------------
> Philipp Zabel (3):
>       pwm i.MX: add devicetree support
>       pwm i.MX: fix clock lookup
>       pwm i.MX: add devicetree support
> 
> Sascha Hauer (6):
>       pwm i.MX: factor out SoC specific functions
>       pwm i.MX: remove unnecessary if in pwm_[en|dis]able
>       pwm i.MX: add functions to enable/disable pwm.
>       pwm i.MX: Use module_platform_driver
>       pwm i.MX: use per clock unconditionally
>       ARM i.MX53: Add pwms to dtsi
> 
>  arch/arm/boot/dts/imx53.dtsi        |   14 ++
>  arch/arm/mach-imx/clk-imx51-imx53.c |    4 +
>  drivers/pwm/pwm-imx.c               |  278 +++++++++++++++++++++++------------
>  3 files changed, 202 insertions(+), 94 deletions(-)
