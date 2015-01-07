From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Jan 2015 21:36:19 -0500
Subject: [PATCH] irqchip: gicv3-its: fix use of max with decimal constant
In-Reply-To: <1418825469-30529-1-git-send-email-will.deacon@arm.com>
References: <1418825469-30529-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150107023619.GC24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 02:11:09PM +0000, Will Deacon wrote:
> arm64 defconfig spits out the following compiler warning from the ITS
> driver:
> 
> In file included from include/linux/bitmap.h:9:0,
>                  from drivers/irqchip/irq-gic-v3-its.c:18:
> drivers/irqchip/irq-gic-v3-its.c: In function ?its_create_device?:
> include/linux/kernel.h:716:17: warning: comparison of distinct pointer types lacks a cast
>   (void) (&_max1 == &_max2);  \
>                  ^
> drivers/irqchip/irq-gic-v3-its.c:1056:12: note: in expansion of macro ?max?
>   nr_ites = max(2, roundup_pow_of_two(nvecs));
> 
> Fix the warning by specifying the decimal constant `2' explicitly as an
> unsigned long type.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to irqchip/urgent with Marc's Ack.

thx,

Jason.
