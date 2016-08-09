From: davem@davemloft.net (David Miller)
Date: Tue, 09 Aug 2016 16:19:56 -0700 (PDT)
Subject: [PATCH v2] net: phy: micrel: Add specific suspend
In-Reply-To: <1470378941-12387-1-git-send-email-wenyou.yang@atmel.com>
References: <1470378941-12387-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160809.161956.2187735118267449721.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>
Date: Fri, 5 Aug 2016 14:35:41 +0800

> Disable all interrupts when suspend, they will be enabled
> when resume. Otherwise, the suspend/resume process will be
> blocked occasionally.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> 
> Changes in v2:
>  - Use fairly generic phydrv->config_intr() with
>    PHY_INTERRUPT_DISABLED, then call genphy_suspend().
>  - Modify kszphy_resume() with PHY_INTERRUPT_ENABLED accordingly.
>  - Add static attribute for kszphy_suspend().

Applied, thanks.
