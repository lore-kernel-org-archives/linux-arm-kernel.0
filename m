From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2016 14:26:27 +0200
Subject: [PATCH v2 1/3] pinctrl: imx: accept gpio request/free from pinctrl
In-Reply-To: <1473299296-22458-2-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1473299296-22458-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1473299296-22458-2-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <CACRpkdZwi_7OZ1_Ng44O10GqmLG3xgp3REyZPhJBs9goMLVU3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 3:48 AM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:

> While only Freescale Vybrid SoC has settings of GPIO capabilities done
> by iomux controller, it is only a matter of GPIO controller driver
> implementation for the rest of Freescale/NXP SoCs from iMX series.
>
> As a practical example on GPIO request a pad function should be
> switched to GPIO, but because this requires updates to all particular
> iMX pinctrl drivers, for simplicity at the moment add only a proper
> connection between shared pinctrl-imx and pinctrl/pinmux core, namely
> .gpio_request_enable/.gpio_disable_free/.gpio_set_direction callbacks
> should return success to a caller. This change allows to progress by
> adding request/free callbacks into gpio-mxc.c driver.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> Changes from v1 to v2:
> * none

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
