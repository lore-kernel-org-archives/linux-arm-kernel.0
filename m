From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Sep 2015 22:51:18 +0200
Subject: Regression by 01f779f4862b ("irqchip/GIC: Don't deactivate
 interrupts forwarded to a guest")
In-Reply-To: <20150917003202.498ff83c@xhacker>
References: <20150917003202.498ff83c@xhacker>
Message-ID: <CACRpkdaA0jNcYy-nkuNYe4q5nr==Wf3=6wzVrvd8NF+QnuE4hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 6:32 PM, Jisheng Zhang <jszhang@marvell.com> wrote:

> Hi Marc,
>
> Commit 01f779f4862b ("irqchip/GIC: Don't deactivate interrupts forwarded to a
> guest") causes a regression on Marvell BG4CT SoC. In this SoC, there's only one
> GIC, the secondary irq controller is Synopsys DW iCtl:
> drivers/irqchip/irq-dw-apb-ictl.c
>
> So cascading_gic_irq() should return true on Marvell BG4CT SoC, but it returns
> false. The logic in cascading_gic_irq() doesn't take cascaded irq controller
> which is provided by non-gic controllers.
>
> bisect log is as following:

I bisected a GPIO IRQ problem on the ARM Juno reference design
down to the same commit today, haven't had time to test the
patch and going on travels, but I'm hoping it is solving itself now then.

Yours,
Linus Walleij
