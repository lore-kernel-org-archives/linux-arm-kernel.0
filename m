From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 10:34:28 +0100
Subject: [PATCH v2 6/7] gpio: brcmstb: consolidate interrupt domains
In-Reply-To: <20171024195451.30535-7-opendmb@gmail.com>
References: <20171024195451.30535-1-opendmb@gmail.com>
 <20171024195451.30535-7-opendmb@gmail.com>
Message-ID: <CACRpkdZq0x7_3DXAcg-bp5EQ-5xdb-xm0gUBKzV562ah2YR1jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 9:54 PM, Doug Berger <opendmb@gmail.com> wrote:

> The GPIOLIB IRQ chip helpers were very appealing, but badly broke
> the 1:1 mapping between a GPIO controller's device_node and its
> interrupt domain.
>
> When another device-tree node references a GPIO device as its
> interrupt parent, the irq_create_of_mapping() function looks for
> the irq domain of the GPIO device and since all bank irq domains
> reference the same GPIO device node it always resolves to the irq
> domain of the first bank regardless of which bank the number of
> the GPIO should resolve. This domain can only map hwirq numbers
> 0-31 so interrupts on GPIO above that can't be mapped by the
> device-tree.
>
> This commit effectively reverts the patch from Gregory Fong [1]
> that was accepted upstream and replaces it with a consolidated
> irq domain implementation with one larger interrupt domain per
> GPIO controller instance spanning multiple GPIO banks based on
> an earlier patch [2] also submitted by Gregory Fong.
>
> [1] https://patchwork.kernel.org/patch/6921561/
> [2] https://patchwork.kernel.org/patch/6347811/
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Patch applied with the tags.

This needs to be revisited when we have Thierry's block/bank
infrastructure merged.

Yours,
Linus Walleij
