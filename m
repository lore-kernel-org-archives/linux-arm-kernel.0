From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 5 Jun 2013 10:07:03 -0400 (EDT)
Subject: [RFC PATCH v2 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <1370432767-6620-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370432767-6620-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370432767-6620-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1306050956081.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Jun 2013, Lorenzo Pieralisi wrote:

> The TC2 versatile express core tile integrates a logic block that provides the
> interface between the dual cluster test-chip and the M3 microcontroller that
> carries out power management. The logic block, called Serial Power Controller
> (SPC), contains several memory mapped registers to control among other things
> low-power states, operating points and reset control.
> 
> This patch provides a driver that enables run-time control of features
> implemented by the SPC control logic.
> 
> The driver also provides a bridge interface through the vexpress config
> infrastructure. Operations allowing to read/write operating points are
> made to go via the same interface as configuration transactions so that
> all requests to M3 are serialized.
> 
> Device tree bindings documentation for the SPC component is provided with
> the patchset.
> 

[...]

> +/*
> + * Versatile Express Serial Power Controller (SPC) support
> + *
> + * Copyright (C) 2013 ARM Ltd.
> + *
> + * Author(s): Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> + *            Achin Gupta           <achin.gupta@arm.com>
> + *            Lorenzo Pieralisi     <lorenzo.pieralisi@arm.com>

I imagine "author(s)" can be written as "authors" without a doubt.  :-)

> +EXPORT_SYMBOL_GPL(vexpress_spc_write_resume_reg);
> +EXPORT_SYMBOL_GPL(vexpress_spc_set_global_wakeup_intr);
> +EXPORT_SYMBOL_GPL(vexpress_spc_set_cpu_wakeup_irq);
> +EXPORT_SYMBOL_GPL(vexpress_spc_powerdown_enable);

I don't think anything that could possibly be made into modules should 
ever have a need for those particular calls.  So I'd suggest not 
exporting them.

Other than that, you may add...

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
