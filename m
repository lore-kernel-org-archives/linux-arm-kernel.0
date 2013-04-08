From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 08 Apr 2013 18:45:20 +0900
Subject: [PATCH] ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
In-Reply-To: <201304072235.02218.heiko@sntech.de>
References: <1365366170-9682-1-git-send-email-s.nawrocki@samsung.com>
 <201304072235.02218.heiko@sntech.de>
Message-ID: <2cd501ce343d$c8efc810$5acf5830$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Sonntag, 7. April 2013, 22:22:50 schrieb Sylwester Nawrocki:
> > Due to NR_IRQS being incorrectly defined not all IRQ domains can
> > be registered for S3C2440. It causes following errors on a s3c2440
> > SoC based board:
> >
> > NR_IRQS:89
> > S3C2440: IRQ Support
> > irq: clearing pending status 00000002
> > ------------[ cut here ]------------
> > WARNING: at kernel/irq/irqdomain.c:234 0xc0056ed0()
> > ...
> > irq: could not create irq-domain
> > ...
> > s3c2410-wdt s3c2410-wdt: failed to install irq (-22)
> > s3c2410-wdt: probe of s3c2410-wdt failed with error -22
> > ...
> > samsung-uart s3c2440-uart.0: cannot get irq 74
> >
> > Fix this by increasing NR_IRQS to at least (IRQ_S3C2443_AC97 + 1)
> > if CPU_S3C2440 is selected, so the subintc IRQ domain gets properly
> > registered.
> >
> > Cc: Heiko St?bner <heiko@sntech.de>
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Thanks for testing the irq changes on another subarchitecture and fixing
> the
> glitch.
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> 
> 
Thanks for you guys' effort.

Applied.

- Kukjin
