From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Oct 2014 21:19:33 -0700
Subject: [PATCH v4 1/6] pinctrl: rockchip: add suspend/resume functions
In-Reply-To: <1413933557-25684-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933557-25684-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=WZtcOcAQDyMDNPFdMz6P9ZSqkUPZ52UgecZbSXU92mzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Oct 21, 2014 at 4:19 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> From: Chris <zyw@rock-chips.com>

I think your git is misconfigured.  The above "From" line will make
the author end up without your last name.  Heiko mentioned this in v4.

> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 016f457..c4a988d 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1770,6 +1770,25 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
>         return ctrl;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int rockchip_pinctrl_suspend(struct device *dev)

Why didn't you take Dmitry's suggestion from v3?  I think you can get
rid of the #ifdef and add the "__maybe_unused" annotation to avoid
errors when PM_SLEEP isn't defined.

This does work, though, so:

Tested-by: Doug Anderson <dianders@chromium.org>
