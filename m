From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 22 Jun 2016 10:31:26 -0700
Subject: [PATCH v4 2/3] pwm: iproc: Add support for Broadcom iproc pwm
 controller
In-Reply-To: <1466594987-26537-3-git-send-email-yendapally.reddy@broadcom.com>
References: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
 <1466594987-26537-3-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <20160622173126.GA74558@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 07:29:46AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> Add support for the PWM controller present in Broadcom's iProc
> family of SoCs. This driver is derived from the pwm-bcm-kona
> driver, with changes to the register offsets and bit positions.
> It has been tested on the  Northstar+ bcm958625HR board.
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  drivers/pwm/Kconfig         |  10 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-bcm-iproc.c | 327 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
> 
[...]
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> new file mode 100644
> index 0000000..952c457
> --- /dev/null
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -0,0 +1,327 @@
[...]
> +static const struct pwm_ops iproc_pwm_ops = {
> +	.config = iproc_pwmc_config_check,
> +	.set_polarity = iproc_pwmc_set_polarity,
> +	.enable = iproc_pwmc_enable,
> +	.disable = iproc_pwmc_disable,
> +	.owner = THIS_MODULE,
> +};

Have you considered trying the new apply() callback instead of
config()/set_polarity()/enable()/disable()?

[...]

Brian
