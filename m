From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Mar 2012 11:03:23 +0100
Subject: [PATCH V2 2/3] pinctrl: allow concurrent gpio and mux function
 ownership of pins
In-Reply-To: <1330993336-9538-2-git-send-email-swarren@nvidia.com>
References: <1330993336-9538-1-git-send-email-swarren@nvidia.com>
 <1330993336-9538-2-git-send-email-swarren@nvidia.com>
Message-ID: <CACRpkdYdSaNsrr34o2Cc4vS12ee9oY7FG0pxB92mefHZKwdEpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 1:22 AM, Stephen Warren <swarren@nvidia.com> wrote:

> Per recent updates to Documentation/gpio.txt, gpiolib drivers should
> inform pinctrl when a GPIO is requested. pinctrl then marks that pin as
> in-use for that GPIO function.
>
> When an SoC muxes pins in a group, it's quite possible for the group to
> contain e.g. 6 pins, but only 4 of them actually be needed by the HW
> module that's mux'd to them. In this case, the other 2 pins could be
> used as GPIOs. However, pinctrl marks all the pins within the group as
> in-use by the selected mux function. To allow the expected gpiolib
> interaction, separate the concepts of pin ownership into two parts: One
> for the mux function and one for GPIO usage. Finally, allow those two
> ownerships to exist in parallel.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Good, and 100% in accordance with earlier discussions.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
