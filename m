From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 Jan 2014 10:16:33 -0200
Subject: Huge lockdep warning from sdhci/imx esdhc code
In-Reply-To: <20140116114654.GU15937@n2100.arm.linux.org.uk>
References: <20140116114654.GU15937@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5B6Z8oExL27gue5BL6kLdL=9opB7x0jXXu=FJ4zFCuabA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jan 16, 2014 at 9:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> ======================================================
> [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
> 3.13.0-rc7+ #401 Not tainted
> ------------------------------------------------------
> kworker/u8:1/44 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  (prepare_lock){+.+.+.}, at: [<c04d10d4>] clk_prepare_lock+0x80/0xf4
>
> and this task is already holding:
>  (&(&host->lock)->rlock){-.-...}, at: [<c04b0528>] sdhci_do_set_ios+0x20/0x740
> which would create a new lock dependency:
>  (&(&host->lock)->rlock){-.-...} -> (prepare_lock){+.+.+.}

Please apply this patch:
https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/commit/?h=mmc-next&id=a974862faee199cba3ff36b5a148df5fd34bd1e7

Regards,

Fabio Estevam
