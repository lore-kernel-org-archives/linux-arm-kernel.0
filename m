From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Feb 2013 14:52:27 -0800
Subject: [PATCH] ARM: exynos: move exynos4210-combiner to drivers/irqchip
In-Reply-To: <1360706692-13622-1-git-send-email-robherring2@gmail.com>
References: <1360706692-13622-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130212225227.GA24096@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 04:04:52PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Exynos boot is broken with commit 0529e315 (ARM: use common irqchip_init
> for GIC init). This commit split the irqchip initialization into 2 calls
> to of_irq_init. This does not work because of_irq_init requires interrupt
> parents to be in the match list.
> 
> Rather than reverting exynos changes, make it do the proper thing by using
> IRQCHIP_DECLARE. This requires moving the combiner code to drivers/irqchip.
> 
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
> 
> I thought there may be other platforms broken in the same way, but I
> checked and exynos is the only one.
> 
> This is based on my gic/vic irqchip branch in arm-soc.

Applied to next/cleanup.

I guess this answers whether anyone boots linux-next regularly on Exynos
hardware. :(


-Olof
