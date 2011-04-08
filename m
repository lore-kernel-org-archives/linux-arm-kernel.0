From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Apr 2011 09:00:07 -0400 (EDT)
Subject: [PATCH 2/2] ARM: fix personality flag propagation across an exec
In-Reply-To: <20110408072931.GB27450@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1104072251390.28032@xanadu.home>
	<20110408072931.GB27450@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104080856000.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Russell King - ARM Linux wrote:

> On Thu, Apr 07, 2011 at 10:52:53PM -0400, Nicolas Pitre wrote:
> >  	/*
> > +	 * Inherit most personality flags from parent, except for those
> > +	 * we're about to choose.  Beware: PER_LINUX_32BIT carries flag bits
> > +	 * outside of PER_MASK.
> > +	 */
> > +	personality &= ~(PER_MASK | PER_LINUX | PER_LINUX_32BIT);
> 
> PER_LINUX and PER_LINUX_32BIT aren't bitflags - the LSB is a numeric
> personality ID.  So this looks wrong.
