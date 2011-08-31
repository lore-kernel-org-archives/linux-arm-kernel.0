From: will.deacon@arm.com (Will Deacon)
Date: Wed, 31 Aug 2011 16:21:37 +0100
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <1314798215.2344.76.camel@deneb.redhat.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>
	<1314798215.2344.76.camel@deneb.redhat.com>
Message-ID: <20110831152137.GG8777@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 02:43:33PM +0100, Mark Salter wrote:
> On Wed, 2011-08-31 at 09:49 +0100, Will Deacon wrote:
> > On Wed, Aug 31, 2011 at 01:23:47AM +0100, Chen Peter-B29397 wrote:
> > > One question: why this write buffer issue did not happen at UP ARM V7 platform, whose dma buffer
> > > also uncache, but bufferable?
> > 
> > Which CPU was on this platform?
> 
> Using a 3.1.0-rc4+ kernel on a Pandaboard, and running 'hdparm -t' on a
> usb disk drive, I see ~5.8MB/s read speed. Same kernel, but passing
> nosmp on the commandline, I see 20.3MB/s.
> 
> Can someone explain why nosmp would make such a difference?

Oh gawd, that's horrible. I have a feeling it's probably a separate issue
though, caused by:

omap_modify_auxcoreboot0(0x200, 0xfffffdff);

in boot_secondary for OMAP. Unfortunately I have no idea what that line is
doing because it ends up talking to the secure monitor.

Will
