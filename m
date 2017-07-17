From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Jul 2017 10:07:32 +0200
Subject: [PATCH] irqchip/gic: Use GIC_SPI symbolic constant
In-Reply-To: <86h8ycytse.fsf@arm.com>
References: <e25e0ac5-abe2-6024-f669-c5352183114e@free.fr>
 <86shhwywas.fsf@arm.com>
 <d0701807-74fb-f54e-ccff-378c15da076e@free.fr>
 <86h8ycytse.fsf@arm.com>
Message-ID: <20170717100732.435116c8@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, 16 Jul 2017 22:08:01 +0100, Marc Zyngier wrote:

> > Are you saying that changing the code at this point is
> > not worth the trouble?  
> 
> You're assuming that this GIC_SPI macro has anything to do with the GIC
> driver. It doesn't. That's just a convenience macro for people writing
> DT, and definitely not something I'd ever want to rely on in the Linux
> driver. The binding defines the raw value, and not this macro.
> 
> So to sum it up, thank you, but no thank out.

FWIW, a few drivers are already using GIC_SPI:

irq-mvebu-gicp.c:       fwspec.param[0] = GIC_SPI;
irq-mvebu-odmi.c:       fwspec.param[0] = GIC_SPI;
irq-tegra.c:    if (fwspec->param[0] != GIC_SPI)
irq-vf610-mscm-ir.c:            parent_fwspec.param[0] = GIC_SPI;

For pretty much exactly the situation being patched by Mason.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
