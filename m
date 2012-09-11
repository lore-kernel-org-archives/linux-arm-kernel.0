From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 11 Sep 2012 16:40:43 +0200
Subject: [PATCH 5/7] pwm: i.MX: add devicetree support
In-Reply-To: <1347267577-3296-6-git-send-email-s.hauer@pengutronix.de>
References: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
 <1347267577-3296-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120911144043.GA3824@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 10:59:35AM +0200, Sascha Hauer wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> At the same time remove platform based support. No user for
> this driver has made it into mainline so far, so all we break
> is out of tree stuff.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
[...]

I was just doing some build tests on the series and noticed that it
fails with this:

	  CC [M]  drivers/pwm/pwm-imx.o
	/home/thierry.reding/src/kernel/linux-pwm.git/drivers/pwm/pwm-imx.c: In function 'imx_pwm_config_v2':
	/home/thierry.reding/src/kernel/linux-pwm.git/drivers/pwm/pwm-imx.c:140:2: error: implicit declaration of function 'cpu_is_mx25' [-Werror=implicit-function-declaration]

This breaks bisection in the middle of the series. It seems to be
related to this change.

> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index a1e799e..b4e0ad3 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -16,8 +16,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
> -#include <mach/hardware.h>

This probably needs to be postponed to the next patch, until the final
reference to cpu_is_mx25() is removed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/305a4e50/attachment.sig>
