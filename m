From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Jul 2014 09:59:02 +0200
Subject: [PATCH 1/3] mfd: pm8921: Expose pm8xxx_read_irq_status
In-Reply-To: <1404782785-1824-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1404782785-1824-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1404782785-1824-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CACRpkdaYRwSb2cd88KEjKHKN_3sRv5BvJTvNMmF3CZszu8c2HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 3:26 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> Most status bits, e.g. for GPIO and MPP input, is retrieved by reading
> the interrupt status registers, so this needs to be exposed to clients.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Hm do you mean you read the input *values* from the interrupt status
registers?

What madness in that case.... :-)

Anyway, since the driver is based on regmap, can't the children just
get a regmap * somehow and then just go read the same register
instead of having to add a special function for it?

When I look at it it seems like it's doing regmap strangely or
something, like it's one write then one read operation to get
the register(s) and isn't that all supposed to be hidden behind
regmap so you don't need the local lock chip->pm_irq_lock?

Yours,
Linus Walleij
