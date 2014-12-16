From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 16 Dec 2014 15:52:23 +0100 (CET)
Subject: [PATCH 0/5] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <20141216152041.56ff9b2e@bbrezillon>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
 <2662748.NJbkr6jW7r@vostro.rjw.lan> <3542278.8lcJeXLMFm@vostro.rjw.lan>
 <20141216100715.57baeb65@bbrezillon>
 <alpine.DEB.2.11.1412161013570.17382@nanos>
 <20141216122503.77c5632f@bbrezillon>
 <alpine.DEB.2.11.1412161349420.17382@nanos>
 <20141216152041.56ff9b2e@bbrezillon>
Message-ID: <alpine.DEB.2.11.1412161551290.17382@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Dec 2014, Boris Brezillon wrote:
> On Tue, 16 Dec 2014 13:56:26 +0100 (CET)
> Okay, that's what I had in mind, thanks for clarifying this aspect.
> 
> Regarding the DT representation, it should look like this, right ?
> 
> aic: interrupt-controller at fffff000 {
> 	#interrupt-cells = <3>;
> 	compatible = "atmel,at91rm9200-aic";
> 	interrupt-controller;
> 	reg = <0xfffff000 0x200>;
> 	atmel,external-irqs = <29 30 31>;
> 
> 	irq1_demux: irq1-demux {
> 		#interrupt-cells = <1>;
> 		interrupt-controller;
> 	}
> };
> 
> pit: timer at fffffd30 {
> 	compatible = "atmel,at91sam9260-pit";
> 	reg = <0xfffffd30 0xf>;
> 	/* 0 is the id reserved for the PIT */
> 	interrupts-extended = <&irq1_demux 0>;
> 	clocks = <&mck>;
> };
> 
> pmc: pmc at fffffc00 {
> 	compatible = "atmel,at91sam9260-pmc";
> 	reg = <0xfffffc00 0x100>;
> 	/* 1 is the id reserved for the PMC */
> 	interrupts-extended = <&irq1_demux 1>;

Not that I'm a DT expert, but that looks about right.

Thanks,

	tglx
