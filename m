From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 25 Feb 2015 19:17:53 +0100
Subject: [PATCH v2] mmc: dw_mmc: fix bug that cause mmc_test failture
In-Reply-To: <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
 <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <54EE11D1.7050608@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Addy,

On 02/20/2015 03:55 AM, Addy Ke wrote:
> The STOP command can terminate a data transfer between a memory card and
> mmc controller.
> 
> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:

s/Stroage/Storage but maybe Ulf can amend the typo when applying?

> Data timeout and Data end-bit error will terminate further data transfer
> by mmc controller. So we should not send abort command to terminate a
> data transfer again if we got DRTO and EBE interrupt.
> 
> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
> 
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

I did not run all the tests listed in /sys/kernel/debug/mmc*/*/testlist
because some of them will overwrite the data in my card but at least
the read ones completed successfully and $subject does not cause a
regression in the Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800
Peach Pi Chromebooks where I tested it.

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
