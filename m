From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 22:48:00 +0800
Subject: [PATCH] ARM: imx6: fix bogus use of irq_get_irq_data
In-Reply-To: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
References: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141202144759.GO2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:04:03PM +0000, Marc Zyngier wrote:
> The imx6 PM code seems to be quite creative in its use of irq_data,
> using something something that is very much a hardware interrupt
> number where we expect a virtual one.  Yes, it worked so far, but
> that's only cheer luck, and it will definitely explode in 3.19.
> 
> Fix it by using a pair of helper functions that deal with the
> actual hardware.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Arnd, Olof,

To avoid a non-booting 3.19-rc1 on i.MX6, please apply it for 3.19-rc1.
Thanks.

Shawn
