From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Nov 2018 02:22:02 +0530
Subject: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate
 resources
In-Reply-To: <20181113135051.15308-2-brgl@bgdev.pl>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-2-brgl@bgdev.pl>
Message-ID: <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
> IRQ numbering") the davinci GPIO driver fails to probe if we boot
> in legacy mode from any of the board files. Since the driver now
> expects every interrupt to be defined as a separate resource, split
> the definition in devices-da8xx.c instead of having a single continuous
> interrupt range.
> 
> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
> Cc: stable at vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are a number of other boards that need such fixing too. And the
commit in question does not do a good job of explaining why it was
needed in the first place. The description  just repeats what can be
inferred by reading the patch.


    gpio: davinci: Do not assume continuous IRQ numbering

    Currently the driver assumes that the interrupts are continuous
    and does platform_get_irq only once and assumes the rest are continuous,
    instead call platform_get_irq for all the interrupts and store them
    in an array for later use.

    Signed-off-by: Keerthy <j-keerthy@ti.com>
    Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


Can we revert the offending commit instead?

Thanks,
Sekhar
