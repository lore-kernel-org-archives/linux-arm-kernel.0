From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 23 Jul 2015 19:37:03 +0200
Subject: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable wdt
 if enabled
In-Reply-To: <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
 <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1488521.5eJqASov2O@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 23, 2015 01:49:11 PM Eddie Huang wrote:
> From: Greta Zhang <greta.zhang@mediatek.com>
> 
> Without .shutdown(), watchdog might reset the system during power off.
> For example, if watchdog's timeout is set to 30s, then it is reset to
> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
> but watchdog is still running and may trigger reset.
> 
> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/watchdog/mtk_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
