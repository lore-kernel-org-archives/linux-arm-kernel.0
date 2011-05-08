From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 8 May 2011 11:23:21 -0400 (EDT)
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <20110508150530.GL27807@n2100.arm.linux.org.uk>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
	<20110413124149.GR18850@pengutronix.de>
	<BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
	<20110508104201.GH27807@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1105081027190.1001@xanadu.home>
	<20110508150530.GL27807@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1105081119160.1666@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 May 2011, Russell King - ARM Linux wrote:

> On Sun, May 08, 2011 at 11:00:30AM -0400, Nicolas Pitre wrote:
> > If CONFIG_AUTO_ZRELADDR is set, then zImage will automatically place the 
> > kernel Image correctly in memory, assuming that zImage is itself loaded 
> > within the first 128MB of memory.
> 
> I was only covering the requirements of the Image, rather than zImage which
> you covered in a subsequent message.

Sorry if I already covered that.  I'm jet-lagged at the moment and my 
memory is fuzzy.

> > > There is one thing to watch out for though - if you did place it 16MB
> > > above, but still tell the kernel via ATAGs that the physical memory
> > > starts where it really does, then I'd expect things to explode as
> > > the kernel direct mapped memory would likely extend below PAGE_OFFSET.
> > 
> > Yeah... We should probably add a warning and truncate the beginning of 
> > the memory bank in that case.  This would also prevent memory from being 
> > wrongly declared below PHYS_OFFSET even without the P2V feature enabled.
> 
> We don't encouter the situation today, so lets leave it until we actually
> have a problem.  There's no point bloating the kernel with such checks if
> they're never going to fire.

OK.


Nicolas
