From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 00:09:45 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <alpine.LFD.2.00.1107052308340.14596@xanadu.home>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<CAGsJ_4xfZvZcXCfRk==iVmc-_GsyavB+cmnKztEvmRx-VLbLPg@mail.gmail.com>
	<alpine.LFD.2.00.1107052308340.14596@xanadu.home>
Message-ID: <20110706230945.GA8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:12:16PM -0400, Nicolas Pitre wrote:
> On Wed, 6 Jul 2011, Barry Song wrote:
> 
> > 2011/7/6 Nicolas Pitre <nicolas.pitre@linaro.org>:
> > > Having this value defined at compile time prevents multiple machines with
> > > conflicting definitions to coexist. ?Move it to a variable in preparation
> > > for having a per machine value selected at run time. ?This is relevant
> > > only when CONFIG_ZONE_DMA is selected.
> > >
> > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > that is definitely good. i am not sure whether it will be better if
> > dma zone becomes a property in memory node of DT.
> 
> Certainly.  But one thing at a time.  This is the first step. Then, 
> those machines that are converted to DT could more easily provide the 
> information via this mechanism if they so desire.

Actually, putting that information into DT is probably not right -
you're describing something which is specific to Linux, not something
which is due to hardware.

What I mean is that the DMA zone is a Linux specific thing.  Another OS
could have a different way of dealing with the DMA restrictions (it
may be possible to allocate memory within a certain set of bounds.)

What is hardware specific is that the DMA devices can only address a
limited range of memory.  IMHO it's that which should be described in
DT, not that we'll have a DMA zone of X bytes in size.
