From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 07 Jul 2011 08:59:59 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <alpine.LFD.2.02.1107041120190.2917@ionos> (Thomas Gleixner's
	message of "Mon, 4 Jul 2011 11:21:12 +0200 (CEST)")
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1106020100200.3078@ionos>
	<alpine.LFD.2.02.1107041120190.2917@ionos>
Message-ID: <m3oc16h8y8.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Thinking more about it we should add BE accessor functions to the mmio
> clocksource as this might be useful for other architectures as well.

Why not simply use a value-preserving accessors like readl/writel?
Aren't they value-preserving on all ARM CPUs?

IMHO the CPU/platform code should supply certain accessors (value- and
order-preserving), and the generic code should simply use the correct
one.

Perhaps we should have (for ARM only) another set of register_readl()
etc.? (PCI and register endianness may differ, a separate set would mean
no runtime overhead in such case).
-- 
Krzysztof Halasa
