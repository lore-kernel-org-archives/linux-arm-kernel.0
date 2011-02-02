From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Feb 2011 19:50:52 +0000
Subject: [PATCH] ARM: bitops: Fix low-level code to be Thumb-2 compatible
In-Reply-To: <alpine.LFD.2.00.1102021421160.8580@xanadu.home>
References: <1296672824-22743-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102021421160.8580@xanadu.home>
Message-ID: <20110202195052.GB31043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 02:33:55PM -0500, Nicolas Pitre wrote:
> On Wed, 2 Feb 2011, Dave Martin wrote:
> 
> > The new bitops code cunningly str <Rt>, [r1, -r1] to trigger
> > a fault by attempting to store to address zero.
> > 
> > This code doesn't assemble in Thumb-2, since Thumb-2 doesn't
> > allow negative register offsets at all for loads and stores.
> > 
> > The patch loads 0 into r2 and uses that as a base register
> > instead for the Thumb-2 case: r2 seems non-live at every
> > instance of this problem.
> > 
> > The ARM case is unaffected.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Russell proposed a better solution already:
> 
> http://mid.gmane.org/alpine.LFD.2.00.1101181312360.8580 at xanadu.home
> 
> No idea why this wasn't folded in his series yet though.

Because I haven't got a round tuit.

http://www.quantumenterprises.co.uk/roundtuit/traditional_round_tuits.htm
