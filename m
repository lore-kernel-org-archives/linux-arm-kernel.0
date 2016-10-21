From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 12:14:01 +0100
Subject: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
In-Reply-To: <20161020165747.GD27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
 <20161020165747.GD27598@leverpostej>
Message-ID: <20161021111352.GA16630@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
> On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei at linaro.org wrote:
> > +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
> > +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
> > +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
> > +	/* Always-on capability */
> > +	arch_timer_c3stop = acpi_gtdt_c3stop();
> 
> ... I think we should check the flag on the relevant interrupt, though
> that's worth clarifying.

I see I misread the spec; this is part of the common flags.

Please ignore this point; sorry for the noise.

Thanks,
Mark.
