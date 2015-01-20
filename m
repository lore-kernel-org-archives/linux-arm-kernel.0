From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 20 Jan 2015 09:51:26 +0200
Subject: [PATCH v4 02/21] irqchip: tegra: add DT-based support for legacy
 interrupt controller
In-Reply-To: <1421660655-21394-3-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150120075126.GA31060@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 09:43:56AM +0000, Marc Zyngier wrote:
> Tegra's LIC (Legacy Interrupt Controller) has been so far only
> supported as a weird extension of the GIC, which is not exactly
> pretty.
> 
> The stacked IRQ domain framework fits this pretty well, and allows
> the LIC code to be turned into a standalone irqchip. In the process,
> make the driver DT aware, something that was sorely missing from
> the mach-tegra implementation.
> 

Note that the GIC isn't really stacked on top of the LIC. Each IRQ is
presented to both the LIC and the GIC (as an SPI). The LIC is only used
to wakeup the CPU in case the GIC is not powered. The LIC can also
generate interrupts towards the AVP/ARM7, but that's outside the scope
of Linux ofcourse. The LIC can also be used to force an IRQ and that
forced IRQ will be propagated to the GIC. (see also figure 2, page 36
of the Tegra K1 TRM)

Cheers,

Peter.
