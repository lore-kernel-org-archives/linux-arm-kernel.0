From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 13:51:17 +0100
Subject: [PATCH] pinctrl: bcm2835: Fix memory leak in error path
In-Reply-To: <1450658644-20858-1-git-send-email-stefan.wahren@i2se.com>
References: <1450658644-20858-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CACRpkdYNEgUuF6VAa6pTs6tijYstzVghzOLQVhfCmxL_=pVqVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 1:44 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> In case of an invalid pin value bcm2835_pctl_dt_node_to_map()
> would leak the pull configs of already assigned pins.
> So avoid this by calling the free map function in error case.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")

Patch applied with Eric's Review tag.

Yours,
Linus Walleij
