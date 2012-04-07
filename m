From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 7 Apr 2012 16:14:03 +0800
Subject: [PATCH] mxs-dma : assign the dma cookie before we enable the dma
 channel
In-Reply-To: <1333776575-3462-1-git-send-email-shijie8@gmail.com>
References: <1333776575-3462-1-git-send-email-shijie8@gmail.com>
Message-ID: <20120407081359.GT7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 07, 2012 at 01:29:35AM -0400, Huang Shijie wrote:
> The dma chain may finished very fast, so an interrupt may arises before
> we assign the dma cookie. In this case, the mxs_dma_int_handler() may
> hit the BUG_ON() in dma_cookie_complete().
> 
> So assign the dma cookie before we enable the dma channel.
> 
> Acked-by: Sam Gandhi <samgandhi9@gmail.com>
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaor.org>

The mxs mmc and audio still works with the change.

-- 
Regards,
Shawn
