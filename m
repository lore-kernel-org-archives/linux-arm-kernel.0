From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Jun 2012 20:01:21 +0200
Subject: [PATCH v3 1/2] mmc: mmci.c: Defer probe() in case of yet
 uninitialized GPIOs
In-Reply-To: <1339927893-8842-2-git-send-email-stigge@antcom.de>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
 <1339927893-8842-2-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdaVciTXZ0XY5RvWzHPwh5iXQ7DVSD48K7prgmY0WdyF9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 12:11 PM, Roland Stigge <stigge@antcom.de> wrote:

> If the GPIOs used by the MMCI driver are not registered yet when the driver is
> probe()d, they can't be used. This happens if the mmci driver is probed before
> the respective GPIO controller (e.g. on the LPC32xx EA3250 board, the PCA9532
> GPIO controller would be initialized via DT after mmci). Therefore, we defer
> mmci in this case.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls put this into Russell's patch tracker.

Yours,
Linus Walleij
