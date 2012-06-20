From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 10:51:46 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: fix map setting problem if
 NO_PAD_CTL
In-Reply-To: <1340178101-21605-1-git-send-email-jason77.wang@gmail.com>
References: <1340178101-21605-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <CACRpkdZxCDvhRQ0d04V9BwGWrZ7CrPcug85kcHz7-eD19uU+ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 9:41 AM, Hui Wang <jason77.wang@gmail.com> wrote:

> new_map is allocated according to map_num instead of grp->npins,
> if a pin or some pins of a group has NO_PAD_CTL property, the map_num
> and the grp->npin are different definitely.
>
> When we set mapping information to the new_map[], we should skip those
> pins with NO_PAD_CTL from index, otherwise it is possible the driver
> will aceesss to a unallocated region.
>
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Song/Shawn: can you check this patch and ACK/NACK it?

Should it go into the -rc:s?

Yours,
Linus Walleij
