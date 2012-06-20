From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 18:28:39 +0800
Subject: [PATCH v2] pinctrl: pinctrl-imx: fix map setting problem if
 NO_PAD_CTL is set
In-Reply-To: <1340187227-25343-1-git-send-email-jason77.wang@gmail.com>
References: <1340187227-25343-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20120620102838.GJ10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 06:13:47PM +0800, Hui Wang wrote:
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
> ---
> In the v2, according to dong.aisheng's suggestion, change to use j as index.
> 

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Thanks

Regards
Dong Aisheng
