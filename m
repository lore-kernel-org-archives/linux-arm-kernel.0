From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 4 Nov 2012 19:12:07 +0100
Subject: [PATCH 2/2] Input: nomadik-ske-keypad - start using the apb_pclk
In-Reply-To: <1351779602-13818-3-git-send-email-ulf.hansson@stericsson.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
 <1351779602-13818-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbZB4nhFQtLH-GxBSK99RFk7yhSYMhO5keVjyugrqr7JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2012 at 3:20 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Previously this clock was handled internally by the clockdriver,
> but now this is separate clk. So we need take care of it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

So this is a silicon block clock and falls into the category of things
we've been discussing...

If I understand correctly, the only "real" solution is to
implement the PM domains and have these enable the clocks.

An alternative may be to move this driver over to the AMBA bus,
because I think this device actually has primecell registers.
Then the bus will take care of the pclk for starters.

Yours,
Linus Walleij
