From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Dec 2012 14:11:48 -0700
Subject: [PATCH 1/2] pinctrl: add sleep mode management for hogs
In-Reply-To: <1355234393-17368-1-git-send-email-linus.walleij@stericsson.com>
References: <1355234393-17368-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50C7A194.7070102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2012 06:59 AM, Linus Walleij wrote:
> From: Julien Delacou <julien.delacou@stericsson.com>
> 
> This fix allows handling sleep mode for hogged
> pins in pinctrl. It provides functions to set pins
> to sleep/default configurations according to their
> current state from the individual pinctrl drivers.

> diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h

> +extern int pinctrl_force_sleep(struct pinctrl_dev *pctldev);
> +extern int pinctrl_force_default(struct pinctrl_dev *pctldev);

Since I assume those function are only supposed to be used by pinctrl
drivers themselves, should the prototypes go into drivers/pinctrl/core.h
or similar, rather than something in include/linux/pinctrl?

Oh, and don't you need EXPORT_SYMBOL in case the pinctrl driver is a module?

Aside from that,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
