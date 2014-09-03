From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 3 Sep 2014 08:10:14 -0400
Subject: [PATCH 00/11] Fix arm64 issues highlighted by sparse and smatch
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140903121014.GL30467@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:19PM +0100, Will Deacon wrote:
> Hi all,
> 
> After the static checking talk at kernel summit, I felt empowered to go
> and run sparse and smatch over the arm64 defconfig. As I anticipated,
> this spotted a few issues in the arch code, so I've fixed up the ones
> that aren't just noise in this series. Most are simply incorrect
> address space annotations, but fixing these is useful for spotting real
> issues in the future.
> 
> I don't think any of these fix critical bugs, but they all deserve to be
> addressed. I tagged the compat watchpoint fix for stable, as that code
> has been broken since we merged the architecture port.
> 
> Cheers,
> 
> Will
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Jean Pihet <jean.pihet@linaro.org>
> 
> --->8
> 
> Will Deacon (11):
>   irqchip: gic: make gic_default_routable_irq_domain_ops static
>   irqchip: gic-v3: declare rdist as __percpu pointer to __iomem pointer

>  drivers/irqchip/irq-gic-v3.c           |  2 +-
>  drivers/irqchip/irq-gic.c              |  2 +-

Applied to irqchip/urgent (yes, not urgent, but intended for the -rc's)
with Marc's Ack's

thx,

Jason.
