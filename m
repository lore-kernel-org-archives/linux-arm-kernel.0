From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2016 14:17:46 +0200
Subject: [PATCH] pinctrl/at91: Don't provide a default trigger type
In-Reply-To: <1473170295-16712-1-git-send-email-marc.zyngier@arm.com>
References: <1473170295-16712-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdZZ96kKLRGtZdY3rpa6SgqzrQwEO=96FyMzV1KBkHBjgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 3:58 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> at91 used to set a default trigger type for GPIO interrupts in
> order to cope with the old board files. These days are long gone,
> and it all gets probed through DT.
>
> Andras Szemzo reported that the Ethernet device on his board was
> bailing to be probed, due to a conflict in interrupt trigger.
> Surely enough, this is due to this default trigger still being
> present, and turning this into a IRQ_TYPE_NONE fixes the issue.
>
> Reported-by: Andras Szemzo <szemzo.andras@gmail.com>
> Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Patch applied with Nico's ACK.

Yours,
Linus Walleij
