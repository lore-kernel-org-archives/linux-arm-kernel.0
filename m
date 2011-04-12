From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Apr 2011 18:54:30 -0400 (EDT)
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <20110412212050.GF18850@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
	<20110412095446.GB18850@pengutronix.de>
	<20110412202734.GB7806@n2100.arm.linux.org.uk>
	<20110412203730.GE18850@pengutronix.de>
	<20110412205344.GE7806@n2100.arm.linux.org.uk>
	<20110412212050.GF18850@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1104121850160.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2011, Uwe Kleine-K?nig wrote:

> Apart from defining PLAT_PHYS_OFFSET these symbols are used in the
> machine files to define .boot_params. This is better than repeating the
> bare numbers, isn't it?

Sure.

> The current arch/arm/plat-mxc/include/mach/memory.h looks ok for me. I 
> assume you concur?

Maybe you should replace CONFIG_RUNTIME_PHYS_OFFSET with 
CONFIG_ARM_PATCH_PHYS_VIRT in that file.


Nicolas
