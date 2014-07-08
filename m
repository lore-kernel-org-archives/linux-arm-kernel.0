From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 10:59:52 +0200
Subject: [PATCH 3/6] pinctrl: exynos: Consolidate irq_chips of GPIO and
 WKUP EINTs
In-Reply-To: <1404315664-3174-4-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
 <1404315664-3174-4-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdb2E+U8U2jvXP59sLdt4TAROOmfDZGhFnLahpP28JnUjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 5:41 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> Handling of irq_chip operations for GPIO and WKUP external interrupts
> is mostly the same, with the difference being offset of registers.
> However currently the driver has all the code duplicated for both EINT
> types, which is undesirable, because changes in irq_chip operations have
> to be done to both instances of the same code.
>
> This patch fixes this by creating exynos_irq_chip struct that has normal
> irq_chip struct embedded and contain differences between particular EINT
> types, which are three register offsets. One instance of code is removed
> and the new structure is used instead to fetch necessary data instead of
> samsung_pin_ctrl struct used previously.
>
> While at it, the patch removes Exynos-specific fields from
> aforementioned structure to improve layering of the driver.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

Patch applied.

Yours,
Linus Walleij
