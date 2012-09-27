From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Sep 2012 14:48:11 +0200
Subject: [PATCH] pinctrl/nomadik: allocate IRQ descriptors dynamically
In-Reply-To: <5064487A.5040105@gmail.com>
References: <1348679887-2135-1-git-send-email-linus.walleij@stericsson.com>
 <5064487A.5040105@gmail.com>
Message-ID: <CACRpkdZ3vQ_9ZF3t=syhCx5Y_G_rrjd-3=HrJKo6xLYWAP0wPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 2:37 PM, Rob Herring <robherring2@gmail.com> wrote:

>>       nmk_chip->domain = irq_domain_add_legacy(np, NMK_GPIO_PER_CHIP,
>
> You might as well change to irq_domain_add_simple here.

True. I'll fix.

> Perhaps we should just add irq_alloc_descs call into
> irq_domain_add_simple in the legacy case. It may need to be conditioned
> on SPARSE_IRQ. There's currently no callers, so it wouldn't break anything.

OK get ready to ACK, I'll fix.

Yours,
Linus Walleij
