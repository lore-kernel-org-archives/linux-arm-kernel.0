From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 14:47:37 +0200
Subject: [PATCH] gpio: vf610: handle level IRQ's properly
In-Reply-To: <1440197802-29720-1-git-send-email-stefan@agner.ch>
References: <1440197802-29720-1-git-send-email-stefan@agner.ch>
Message-ID: <CACRpkdYqU_yvZE4WS2jBDOhemPy7dcHeOoj_dG61hCL8ugTMYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 22, 2015 at 12:56 AM, Stefan Agner <stefan@agner.ch> wrote:

> The GPIO IRQ controller is able to generate level triggered
> interrupts, however, these were handled by handle_simple_irq so far
> which did not take care of IRQ masking. This lead to "nobody cared
> (try booting with the "irqpoll" option)" stack traces.
>
> Use the generic interrupt handlers depending on the IRQ type.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Hm, this looks like a problem that could exist in a few more
GPIO drivers. Can you look around and see if there is something
immediately suspicious in drivers/gpio?

Yours,
Linus Walleij
