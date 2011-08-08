From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 8 Aug 2011 17:15:52 +0900
Subject: [PATCH] GPIOLIB: add generic gpio_set_pull API
In-Reply-To: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
References: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110808081552.GI32513@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 07, 2011 at 10:19:33PM -0700, Barry Song wrote:
> Now there are many different implementations for GPIO pull configuration, for
> example:
> s3c_gpio_setpull()
> tegra_pinmux_set_pullupdown()
> chipcHw_setPinPullup()
> gpio_pullup()
> s3c2410_gpio_pullup()
> 
> This patch adds a new generic gpio_set_pull API so that all SoCs can have unified
> codes.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

For arch/arm/mach-shmobile we also have gpio_pull_up() for board-g4evm.c
and gpio_pull_down() for board-mackerel.c. Both of these would benefit
from this sort of an API addition.
