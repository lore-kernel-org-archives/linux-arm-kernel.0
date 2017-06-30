From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Jun 2017 14:12:12 +0200
Subject: [patch 1/5] pinctrl: samsung: Remove bogus irq_[un]mask from
 resource management
In-Reply-To: <20170629214343.882576048@linutronix.de>
References: <20170629213334.375848050@linutronix.de>
 <20170629214343.882576048@linutronix.de>
Message-ID: <CACRpkdYO2bRT8104AbT_w9-=eXDNAr=csYUtmkYKE7bM+BsV9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 11:33 PM, Thomas Gleixner <tglx@linutronix.de> wrote:

> The irq chip callbacks irq_request/release_resources() have absolutely no
> business with masking and unmasking the irq.
>
> The core code unmasks the interrupt after complete setup and masks it
> before invoking irq_release_resources().
>
> The unmask is actually harmful as it happens before the interrupt is
> completely initialized in __setup_irq().
>
> Remove it.
>
> Fixes: f6a8249f9e55 ("pinctrl: exynos: Lock GPIOs as interrupts when used as EINTs")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-gpio at vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Does this patch have a dependency on the rest of the series or should
I just apply it as-is?

Yours,
Linus Walleij
