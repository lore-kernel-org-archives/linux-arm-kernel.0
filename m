From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:18:10 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <1341493572-29735-8-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZmb+4ypnDb3Xw-N5svSBfQ-6oWNy3=iXizZwSio+jHAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Before we can use any domain allocated IRQ, we need to first create a
> map between the Hardware IRQ (hwirq) and the Linux Virtual IRQ (virq).
> We do this with a helper function provided by the AB8500 IRQ domain
> controller called ab8500_irq_get_virq(). We need to do this for both
> IRQs which the Power-On-Key driver uses; one for button press, the other
> for button depress.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Lee I think the in-kernel charging drivers in drivers/power/ab8500_* are
also using the IRQs, have you checked that these also do the right
thing? (I realize they may be hard to test, but atleast make an effort).

Please coordinate with Rajanikanth who is working on DT:ing
these drivers.

Yours,
Linus Walleij
