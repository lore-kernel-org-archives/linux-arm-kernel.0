From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 May 2016 12:57:10 +0200
Subject: [PATCH] gpio: lpc32xx: disable broken to_irq support
In-Reply-To: <1462988400-21738-1-git-send-email-slemieux.tyco@gmail.com>
References: <1462988400-21738-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <CACRpkdZuT-NQJSQAK6RMdGUqiMTo3d31uGoXqgSS1cCyGzy5ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 7:40 PM, Sylvain Lemieux
<slemieux.tyco@gmail.com> wrote:

> From: Sylvain Lemieux <slemieux@tycoint.com>
>
> The "to_irq" functionality is broken inside this driver since commit
> 76ba59f8366f ("genirq: Add irq_domain-aware core IRQ handler").
>
> The addition of the new lpc32xx irqchip driver in 4.7, fixed the
> lpc32xx platform interrupt issue.
>
> When switching to the new lpc32xx irqchip driver, a warning appear
> in the lpc32xx gpio driver: warning: "NR_IRQS" redefined.
>
> To remove this warning (temporary solution), this patch
> disables the broken "to_irq" mapping functionality support.
>
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

Patch applied for fixes with Vladimir's ACK.

> * The final solution is to replace the existing lpc32xx gpio driver.
>   This work is currently in progress; refer to the following URL:
>   http://thread.gmane.org/gmane.linux.drivers.devicetree/144696

Hm, I see that the ambition was to merge the new irqchip
driver and the new GPIO driver in the same merge window.
Sorry if I was being too lazy/picky/whatever about the patch(es)
I guess I didn't quite get the scope of this change. :(

I should say that as long as we can agree that the new code
makes the kernel as a whole a better place, I am happy to
merge it. Sometimes also I need to zoom out from the GPIO
and pin control subsystem(s) and see the big picture.

Yours,
Linus Walleij
