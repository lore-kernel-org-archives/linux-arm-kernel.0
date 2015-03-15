From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 15 Mar 2015 01:51:19 +0000
Subject: [PATCH/RESEND] irqchip: gic: Don't complain in gic_get_cpumask()
 if UP system
In-Reply-To: <1426141291-21641-1-git-send-email-sboyd@codeaurora.org>
References: <1426141291-21641-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150315015119.GE4463@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:21:31PM -0700, Stephen Boyd wrote:
> In a uniprocessor implementation the interrupt processor targets
> registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
> gic_get_cpumask() will print a critical message saying
> 
>  GIC CPU mask not found - kernel will fail to boot.
> 
> if these registers all read as zero, but there won't actually be
> a problem on uniprocessor systems and the kernel will boot just
> fine. Skip this check if we're running a UP kernel or if we
> detect that the hardware only supports a single processor.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> Acked-by: Stefan Agner <stefan@agner.ch>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Picked up acks from the list
> 
>  drivers/irqchip/irq-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to irqchip/core

thx,

Jason.
