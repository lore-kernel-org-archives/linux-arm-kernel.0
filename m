From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Mar 2014 11:58:18 +0000
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20140310104558.GB8830@mudshark.cambridge.arm.com>
References: <20140309115514.GY28112@sirena.org.uk>
 <20140310104558.GB8830@mudshark.cambridge.arm.com>
Message-ID: <20140310115817.GA10240@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 10:45:58AM +0000, Will Deacon wrote:
> On Sun, Mar 09, 2014 at 11:55:14AM +0000, Mark Brown wrote:
> > Hi all,
> 
> Hi Mark,
> 
> > After merging the arm-soc tree, today's linux-next build (20140309)
> > failed for arm64 defconfig like this:
> > 
> > /home/broonie/next/next/drivers/irqchip/irq-gic.c: In function 'gic_raise_softirq':
> > /home/broonie/next/next/drivers/irqchip/irq-gic.c:666:2: error: implicit declaration of function 'dmb' [-Werror=implicit-function-declaration]
> >   dmb(ishst);
> >   ^
> 
> Damnit, that's because we ended up going with dmb instead of dsb after it
> (surprisingly) turned out to be sufficient. The simple patch below fixes the
> problem -- Catalin, can we get this into -next please?

Done.

-- 
Catalin
