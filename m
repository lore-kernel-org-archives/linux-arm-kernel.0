From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 24 Feb 2014 17:07:20 +0200
Subject: [PATCH] remoteproc/davinci: drop needless devm_clk_put
In-Reply-To: <1379952020-5941-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952020-5941-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAK=WgbZnzNkkvuObn5BfkeG3x7L3d8UZKU+98PDk0JC=77toRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 7:00 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> The comment above disable_irq says that it is needed to ensure that the
> "devm subsystem might end up releasing things before freeing the irq,
> thus allowing an interrupt to sneak in while the device is being
> removed." disable_irq is enough for this purpose and there is no need to
> manually free the reference to the clock.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied and pushed to remoteproc-next, thanks!
