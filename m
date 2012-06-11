From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jun 2012 12:44:34 -0400 (EDT)
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <20120611155716.GA18267@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:

> On Mon, Jun 11, 2012 at 11:54:03AM -0400, Nicolas Pitre wrote:
> > 
> > Many CPUs are implementing power saving states via the WFI mode.
> > In some cases, WFI must be entered in order to suspend, or even reset,
> > a CPU.
> > 
> > Whether a CPU needs to be awaken, brought out of WFI during secondary
> > boot, or to cancel a reset state before it is effective, the CPU must
> > receive an interrupt to exit its WFI state.
> > 
> > Let's formalize an IPI number for this purpose, and move over existing
> > users over to a convenience function for it.
> > 
> > This also has the side effect of removing the spurious "Unknown IPI
> > message 1" each time a CPU is awaken.
> 
> I want people to move over to using IPI 0 for wakeup.
> 
> The problem is, as ever, no one bloody well listens and they all continue
> on copying Realview.

No problem -- with this patch the actual IPI number is abstracted away 
and we can modify it as we see fit in a single location.

I can provide a follow-up patch doing just that.  What do you think?


Nicolas
