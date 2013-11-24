From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 12:04:46 -0500
Subject: [PATCH 1/3] irqchip: orion: reverse irq handling priority
In-Reply-To: <1384525354-901-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384525354-901-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1384525354-901-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131124170446.GH29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 03:22:32PM +0100, Sebastian Hesselbarth wrote:
> Non-DT irq handlers were working through irq causes from most-significant
> to least-significant bit, while DT irqchip driver does it the other way
> round. This revealed some more HW issues on Kirkwood peripheral IP, where
> spurious sdio irqs can happen although IP's irq enable registers are all
> zero. Although, not directly related with the described issue, reverse
> irq bit handling back to original order by replacing ffs() with fls().
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/irqchip/irq-orion.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
