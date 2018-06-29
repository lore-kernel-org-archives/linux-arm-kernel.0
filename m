From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jun 2018 14:41:59 +0200
Subject: [PATCH v2] pinctrl: armada-37xx: add suspend/resume support
In-Reply-To: <20180626140613.13908-1-miquel.raynal@bootlin.com>
References: <20180626140613.13908-1-miquel.raynal@bootlin.com>
Message-ID: <CACRpkdYjp53wi+-KxL5fgpijq-1Eoix4g91jLLVVaznvJKQezQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 4:06 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Add suspend/resume hooks in pinctrl driver to handle S2RAM operations.
>
> Beyond the traditional register save/restore operations, these hooks
> also keep the GPIOs used for both-edge IRQ synchronized between their
> level (low/high) and expected IRQ polarity (falling/rising edge).
>
> Since pinctrl is an infrastructure module, its resume should be issued
> prior to other IO drivers. The pinctrl PM operations are requested at
> early/late stages for this reason.
>
> Suggested-by: Ken Ma <make@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Patch applied with Gregory's review tag.

Yours,
Linus Walleij
