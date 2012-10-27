From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 27 Oct 2012 18:23:57 +0200
Subject: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
In-Reply-To: <5089C2B6.5020606@ti.com>
References: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com>
 <5089C2B6.5020606@ti.com>
Message-ID: <CACRpkdawKqmBjETy05EiFfOg3D=PxGVz=ZKi_GdCFK1jLR_Afw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 12:52 AM, Jon Hunter <jon-hunter@ti.com> wrote:

> Subject: [PATCH] gpio/omap: fix clearing of debounce settings on gpio
>  free/reset
>
> When a GPIO is freed or shutdown, we need to ensure that any debounce settings
> are cleared and if the GPIO is the only GPIO in the bank that is currently
> using debounce, then disable the debounce clock as well to save power.
>
> Therefore, introduce a new function called _clear_gpio_debounce() to clear
> any debounce settings when the GPIO is freed or shutdown.
>
> Please note that we cannot use _gpio_dbck_disable() to disable the debounce
> clock because this has been specifically created for the gpio suspend path
> and is intended to shutdown the debounce clock while debounce is enabled.
>
> This has been unit tested on an OMAP3430 Beagle board, by requesting a gpio,
> enabling debounce and then freeing the gpio and checking the register contents,
> the saved register context and the debounce clock state.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

I have come to the conclusion that there is consensus to merge this
patch.

However it does *not* apply to my GPIO tree, which for the OMAP
driver is just a clean v3.7-rc1 and nothing else.

I previously reverted Kevin's patch, is this meant to be applied
on top of that one or what?

Jon, can you please submit a patch made against my GPIO
tree or linux-next or v3.7-rc2 or whatever and include the ACKs
you've recieved?

Thanks!
Linus Walleij
