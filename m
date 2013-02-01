From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 1 Feb 2013 20:30:21 +0800
Subject: [PATCH 5/9] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <1359704911-8275-6-git-send-email-s.hauer@pengutronix.de>
References: <1359704911-8275-1-git-send-email-s.hauer@pengutronix.de>
 <1359704911-8275-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130201123020.GB22173@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 08:48:26AM +0100, Sascha Hauer wrote:
> Even if a chipidea core is otg capable the board may not. This allows
> to explicitly set the core to host/peripheral mode. Without these
> flags the driver falls back to the old behaviour.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/usb/chipidea/core.c  |   21 +++++++++++++++------
>  include/linux/usb/chipidea.h |    2 +-
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index a3ec29d..b2dbf55 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -435,6 +435,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	struct resource	*res;
>  	void __iomem	*base;
>  	int		ret;
> +	int		dr_mode;
why not using enum usb_dr_mode;
-- 

Best Regards,
Peter Chen
