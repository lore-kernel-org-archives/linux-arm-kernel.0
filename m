From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:19:08 +0200
Subject: [PATCH 2/8] irqdomain: Take interrupt-parent property into
 account if specified
In-Reply-To: <1344527635-6163-3-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZMoisfUD_NSkVy2w-jZVUDGn0E8LmvKSWnJ0YRGZO-tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> irq_find_host() currently ignores the 'interrupt-parent' property
> even if it's specified in the Device Tree. Meaning that a node can
> match to a domain in its hierarchy even if it doesn't belong to it.
> By searching for the parent first using of_irq_find_parent() we
> insist that the 'interrupt-parent' property is taken into account
> ensuring a greater chance of returning the correct domain.
>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This (with 1/8) is the right solution. Thanks, and I think
Mark may want to look at this too since I recognize he asked
you to work in this direction.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
