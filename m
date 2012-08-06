From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 10:26:08 +0000
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <501F9799.5020400@compulab.co.il>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
 <501E5F5D.5070901@gmail.com> <501F9799.5020400@compulab.co.il>
Message-ID: <201208061026.08928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Igor Grinberg wrote:
> I see. Ok then. I'm not a huge fan of having the #ifdes inside
> the code (functions) and thinking of moving those outside of the function,
> I get pretty much the same solution it was before your patch.
> 
> I really think that PXA|MMP_GPIO_TO_IRQ should be moved to some common
> location (say arch/arm/plat-pxa/) so both are available regardless
> of CONFIG_ARCH_MMP|PXA. That will simplify the code even more.
> But probably it is too much to ask for that simple patch...
> So, I'm fine with the patch.

Right. I would also not try to spend too much work on making pxa and
mmp coexist better when the plan is to merge them eventually. At that
point, a couple of these hacks can just be removed.

	Arnd
