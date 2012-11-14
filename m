From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Nov 2012 09:46:40 +0000
Subject: [PATCH V2 2/5] arm: mvebu: Added initial support for power
 managmement service unit
In-Reply-To: <20121114000736.GE3290@n2100.arm.linux.org.uk>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-3-git-send-email-gregory.clement@free-electrons.com>
 <20121105140558.GP3351@mudshark.cambridge.arm.com>
 <20121114000736.GE3290@n2100.arm.linux.org.uk>
Message-ID: <20121114094640.GA10142@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 12:07:36AM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 02:05:58PM +0000, Will Deacon wrote:
> > On Mon, Oct 29, 2012 at 09:11:45PM +0000, Gregory CLEMENT wrote:
> > > +	/* Make sure value hits memory before reset */
> > > +	dsb();
> > 
> > writel has barrier semantics -- you shouldn't need this dsb.
> 
> writel has a barrier before the write (to ensure that DMA agents see data
> that was written to memory when they are enabled by the write).  There
> isn't a barrier after the write.

Indeed, but there's a following write to actually do the reset, so the dsb
should come from there.

Will
