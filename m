From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Oct 2010 20:43:06 +0100
Subject: New Kirkwood board support
In-Reply-To: <4CC9D0A3.70204@kernelconcepts.de>
References: <4CC9C245.3030906@kernelconcepts.de>
	<20101028190133.GC31158@pengutronix.de>
	<4CC9D0A3.70204@kernelconcepts.de>
Message-ID: <20101028194306.GL3122@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 28, 2010 at 09:36:03PM +0200, Nils Faerber wrote:
> +MACHINE_START(TK71, "TK71 Kirkwood based Q7 formfactor board")
> +	/* Maintainer: Nils Faerber <nils.faerber@kernelconcepts.de> */
> +	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
> +	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,

The reason you don't want this is because these have been removed
during this merge window already, so merging this code as-is into
current mainline won't build.
