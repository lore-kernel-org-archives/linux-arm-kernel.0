From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 16:30:30 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124162400.GC24104@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
Message-ID: <20110124163030.GD24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 04:24:00PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 04:13:14PM +0000, Pawel Moll wrote:
> > > The real answer is to avoid PIO mode, and use DMA support.
> > > However,
> > > I've had problems using DMA on the ARM development boards.  You can
> > 
> > Well, using DMA won't be easy on VE, will it? ;-) Besides even with
> > this, in some extreme situation, the bus could be potentially stalled
> > long enough to cause an underrun. Yes, very unlikely, but not impossible.
> 
> I'm running SD rootfs alongside NFS/ssh/NTP and the buggy ISP1761.  With the
> pile of 'fixes' patches I have here (which are currently stuck with various
> maintainers) I have a completely stable system.
> 
> I've also had it running gstreamer on CLCD with AACI too, again with SD
> rootfs.  Provided the video is already loaded off the SD card (because
> the transfer rate is too slow) it's fine.
> 
> The only remaining problem I have with it is !"?$%% busybox shell which
> doesn't like readonly rootfs with command history.  The last command is
> /sbin/reboot - I'm sure you can imagine what keeps on happening,
> particularly at the most annoying points in time.

I should also point out that my Versatile Express has been on continuously
for the last two to three weeks, running off SD rootfs, and since fixing
the ISP1761 driver and MMC block driver error handling there's been zero
issues with MMC or ISP1761.

So, MMCI overruns is now a complete non-issue for me.
