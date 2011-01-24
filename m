From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 16:39:21 -0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124162400.GC24104@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
Message-ID: <000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Given that the problem is already fixed via a set of patches, I see
> no reason to mess about with the hardware, thereby making the driver
> more complicated for *no* benefit.

There will be virtually no change in the driver - all required stuff is already there. See the STE UX500 variant - they did exactly the same, enlarged the FIFO. One of the main reason I've immediately abandoned the idea of using FIQ was the need of changing the driver for no good reason.

> Well, fixing MMCI because ISP1761 is buggy is not the way forward.
> The answer is to fix the broken ISP1761 driver.

Totally agree. The thing is that you are the only person right now who doesn't have any problems. The others can quickly benefit from the workaround. I think I made the status of this patch clear enough - let me quote myself: "HACK HACK HACK" ;-)

> Well as I see it, it's pointless enlarging the FIFO.  ARM Ltd isn't
> going to give me updated FPGA images for the Integrator/CP, Versatile
> PB926, Realview EB and Versatile Express.

If we succeed with this, you (and all other users) will get the "improved" FPGA image. But for VE only indeed.

Pawe?
