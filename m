From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2018 14:22:22 +0200
Subject: [PATCH 1/6] pinctrl: imx: fix unsigned check if nfuncs with less
 than or equal zero
In-Reply-To: <1524855713-15527-2-git-send-email-aisheng.dong@nxp.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
 <1524855713-15527-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdbSxGE57vCHkViKTx920LgDb+MJLuxXUXN1pBtdBFCMrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 9:01 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> The unsigned integer nfuncs is being error checked with a value less
> or equal to zero; this is always false if of_get_child_count returns a
> -ve for an error condition since nfuncs is not signed. Fix this by
> making variables nfuncs and i signed integers.
>
> Detected with Coccinelle:
> drivers/pinctrl/freescale/pinctrl-imx.c:620:6-12: WARNING: Unsigned
> expression compared with zero: nfuncs <= 0
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
