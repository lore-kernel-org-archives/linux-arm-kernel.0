From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Oct 2016 11:33:44 +0100
Subject: master build: 2 failures 4 warnings (v4.8-11811-g35ff96d)
In-Reply-To: <20161011101630.xtlcpw76nwjwcbzg@sirena.org.uk>
References: <E1btqa6-0001tx-HV@optimist>
 <20161011101630.xtlcpw76nwjwcbzg@sirena.org.uk>
Message-ID: <20161014103344.GB3304@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Oct 2016, Mark Brown wrote:

> On Tue, Oct 11, 2016 at 07:30:35AM +0100, Build bot for Mark Brown wrote:
> 
> Linus' tree is currently failing to build arm and arm64 allmodconfigs
> with:
> 
> > 	arm64-allmodconfig
> > ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> 
> > 	arm-allmodconfig
> > ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> 
> due to 6556bdacf646fc (mfd: tps65217: Add support for IRQs) since
> irq_set_parent() isn't exported.  This has been present in -next
> for getting on for a month, a patch was proposed adding the relevant
> export but that isn't present in -next yet.
> 
> The function is being used in order to enable lazy IRQ disabling for
> threaded interrupts:
> 
> 	https://www.spinics.net/lists/arm-kernel/msg532864.html
> 
> What's the plan for getting this fixed in Linus' tree?

Here's the conversation:

  https://www.spinics.net/lists/arm-kernel/msg531850.html

I'm waiting on a firm answer from Arnd and Thomas before applying
anything.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
