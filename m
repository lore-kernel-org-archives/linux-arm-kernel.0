From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 1 Dec 2010 12:45:31 +0100
Subject: [PATCH 1/3] ARM: SAMSUNG: Convert s3c_irqext_wake() to new irq_
	interrupt methods
In-Reply-To: <20101201110827.GB24176@rakim.wolfsonmicro.main>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101201101902.GA22683@mail.wantstofly.org>
	<20101201110827.GB24176@rakim.wolfsonmicro.main>
Message-ID: <20101201114531.GK15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 11:08:27AM +0000, Mark Brown wrote:

> > It would seem that this patch breaks s3c:
> 
> > ./mach-s3c64xx/irq-eint.c:	.irq_set_wake	= s3c_irqext_wake,
> > ./plat-s3c24xx/irq.c:	.irq_set_wake	= s3c_irqext_wake
> 
> Could you please elaborate on what you mean by "s3c" and why you think
> it has been broken?

My mistake, sorry -- I thought you had missed the two uses of
s3c_irqext_wake in ./mach-s3c64xx/irq-eint.c and ./plat-s3c24xx/irq.c,
but your patch does actually fix those up as well.
