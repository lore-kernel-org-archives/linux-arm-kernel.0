From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Oct 2012 18:13:16 +0530
Subject: [PATCH v2 3/7] i2c: omap: also complete() when stat becomes zero
In-Reply-To: <1351167915-15079-4-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-4-git-send-email-balbi@ti.com>
Message-ID: <508933E4.7070608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> In case we loop on IRQ handler until stat is
> finally zero, we would end up in a situation
> where all I2C transfers would misteriously
> timeout because we were not calling complete()
> in that situation.
>
> Fix the issue by moving omap_i2c_complete_cmd()
> call inside the 'out' label.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Looks fine. Have you hit this issue in any corner case ?

Regards
santosh
