From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 16:53:56 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
Message-ID: <20110124165356.GG24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 04:39:21PM -0000, Pawel Moll wrote:
> > Well, fixing MMCI because ISP1761 is buggy is not the way forward.
> > The answer is to fix the broken ISP1761 driver.
> 
> Totally agree. The thing is that you are the only person right now who
> doesn't have any problems.

That's not my problem.  A simple search of the linux-usb mailing list
will give you the patch:

	http://marc.info/?l=linux-usb&m=129469114904445&w=2

> The others can quickly benefit from the workaround.

Others _can_ quickly benefit from the ISP1761 fix by applying the above
patch, which not only fixes the MMCI overruns, but also allows USB to
serial devices to work with Versatile Express.  The above patch is
the correct solution.

For christ sake, that patch is a fix for a *known* errata issued by the
ISP1761 manufacturer.

> > Well as I see it, it's pointless enlarging the FIFO.  ARM Ltd isn't
> > going to give me updated FPGA images for the Integrator/CP, Versatile
> > PB926, Realview EB and Versatile Express.
> 
> If we succeed with this, you (and all other users) will get the
> "improved" FPGA image. But for VE only indeed.

That's utterly useless and completely pointless.

Look, stop jumping off a cliff with this and come back to reality.  The
ISP1761 is buggy.  We have a fix.  We have a tested fix.  We have a tested
fix out on mailing lists for everyone to use.  It fixes more than MMC
overruns and makes the ISP1761 usable.

The only problem is that it's taking *FAR* too long for it to get into
mainline for no apparant reason.  That doesn't stop anyone taking the
tested patch in the URL above and gaining proper USB functionality.

The right thing to do is to follow up on my reply on the ISP1761 thread
to find out why it's taking soo long for it to get into Linus' tree.

I repeat, with the proper set of patches in mainline THERE IS NO ISSUE
WITH MMCI.  THE HARDWARE DOES NOT NEED "FIXING".  Please listen to me.
