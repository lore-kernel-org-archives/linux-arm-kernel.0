From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 14:55:27 -0600
Subject: [PATCH 2/4] pinctrl: Allow pinctrl to have multiple active states
In-Reply-To: <20130716090534.5541.60381.stgit@localhost>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090534.5541.60381.stgit@localhost>
Message-ID: <51E704BF.20508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 03:05 AM, Tony Lindgren wrote:
> It's quite common that we need to dynamically change some pins for a
> device for runtime PM, or toggle a pin between rx and tx. Changing all
> the pins for a device is not efficient way of doing it.
> 
> So let's allow setting up multiple active states for pinctrl. Currently
> we only need PINCTRL_STATIC and PINCTRL_DYNAMIC, where PINCTRL_STATIC
> covers the current default pins, and PINCTRL_DYNAMIC holds the dynamic
> pins that need to be toggled.

> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h

> +enum pinctr_states {

s/pinctr/pinctrl/
