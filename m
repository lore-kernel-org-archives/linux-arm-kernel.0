From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Jul 2013 23:15:52 +0200
Subject: [PATCH 1/4] pinctrl: single: Prepare for supporting SoC specific
 features
In-Reply-To: <20130608152732.GR3331@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205037.16513.84242.stgit@localhost>
 <CAN1soZzLYpiakcgPR7mBOC7_mLFW=mZwOG98Dq6JpO+JHUW=cw@mail.gmail.com>
 <20130608152732.GR3331@atomide.com>
Message-ID: <CACRpkdapXZO003xhRCVg5sfQCfJUPMzunui5u6npmht-2hP7Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 5:27 PM, Tony Lindgren <tony@atomide.com> wrote:

> Subject: [PATCH] pinctrl: single: Prepare for supporting SoC specific features
>
> Let's replace is_pinconf with flags and add struct pcs_soc so we
> can support also other features like pin wake-up events. Let's
> export the probe so the SoC specific modules can pass their
> SoC specific data to pinctrl-single if needed.

I don't quite understand this motivation. Can this be more verbose and
include a bit about the mechanics?

- Why is this necessary? For example, pinctrl-single already supports
 generic pinconf, and we can surely add a PIN_CONFIG_WAKEUP
 to include/linux/pinctrl/pinconf-generic.h.

- Also: how does this cooperate with irq_set_wake()? If a pin is
 set to GPIO it is often backed by a GPIO driver (which is calling
 pinctrl_request_gpio() etc), maybe we should just add a
 pinctrl_set_wake() then that the irqchip portions of the GPIO drivers
 can call down to so the pinctrl driver sets this bit if need be?

I think this needs some more thought, especially the latter
concern.

Yours,
Linus Walleij
