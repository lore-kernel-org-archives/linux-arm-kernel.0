From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 22:18:50 -0700
Subject: [PATCH] ARM: imx: fix error handling in ipu device registration
In-Reply-To: <1400483274-13680-1-git-send-email-shawn.guo@freescale.com>
References: <1400483274-13680-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140522051850.GC32618@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 03:07:54PM +0800, Shawn Guo wrote:
> From: Emil Goode <emilgoode@gmail.com>
> 
> If we fail to allocate struct platform_device pdev we
> dereference it after the goto label err.
> 
> This bug was found using coccinelle.
> 
> Fixes: afa77ef (ARM: mx3: dynamically allocate "ipu-core" devices)
> Signed-off-by: Emil Goode <emilgoode@gmail.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Arnd, Olof,
> 
> Please consider to apply this fix for 3.15.  Thanks.

Applied, thanks.

BTW, it was requested to use a 12-character SHA in the Fixes: tag, since in the
future there might be a collision on the shortest one.

You can update the default for your git repo by setting the core.abbrevlength
config variable to 12.


-Olof
