From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 31 Dec 2016 19:41:46 +0000
Subject: [PATCH] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
In-Reply-To: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
References: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20161231194146.GH30137@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Dec 27, 2016 at 06:29:57PM +0000, Stefan Wahren wrote:
> The ICOLL controller doesn't provide any facility to configure the
> wakeup sources. That's the reason why this implementation lacks
> the irq_set_wake implementation. But this prevent us from properly
> entering power management states like "suspend to idle".
> 
> So enable the flags IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND to let the irqchip core allows and handles
> the power management.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/irqchip/irq-mxs.c |    4 ++++
>  1 file changed, 4 insertions(+)

Applied to irqchip/urgent with Fabio's Reviewed-by.

thx,

Jason.
