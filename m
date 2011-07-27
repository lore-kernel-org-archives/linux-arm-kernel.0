From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Jul 2011 11:27:42 -0400 (EDT)
Subject: [PATCH v2] ARM: alignment: Prevent ignoring of faults with ARMv6
	unaligned access model
In-Reply-To: <20110727143233.GC2171@arm.com>
References: <1311689651-7372-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1107261723040.12766@xanadu.home>
	<20110727094359.GA2171@arm.com>
	<alpine.LFD.2.00.1107271009580.12766@xanadu.home>
	<20110727143233.GC2171@arm.com>
Message-ID: <alpine.LFD.2.00.1107271106360.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jul 2011, Dave Martin wrote:

> On Wed, Jul 27, 2011 at 10:10:46AM -0400, Nicolas Pitre wrote:
> > On Wed, 27 Jul 2011, Dave Martin wrote:
> > 
> > > On Tue, Jul 26, 2011 at 05:28:57PM -0400, Nicolas Pitre wrote:
> > > > Why not clearing the U bit as well as the A bit to preserve consistency 
> > > > with the pre ARMv6 behavior?
> > > 
> > > The old unaligned access behaviour is deprecated in ARMv6 (I believe)
> > > and is not supported at all in ARMv7 -- i.e., you can't turn the U bit
> > > off.  So this would be an additional special behaviour for ARMv6 only.
> > > 
> > > I'm not sure that introducing yet another behaviour is useful here;
> > > anyone with legacy userspace software relying on the old unaligned
> > > access model presumably fixed it years ago.
> > > 
> > > Really, the patch was just intended resolve the inconsistency where
> > > the policy the kernel enforces for the alignment fixup mode on bootup
> > > is not enforced at run-time.
> > 
> > OK, that makes sense then.
> 
> Can I take that as an Ack?

/me looks at the patch again.

OK, looks fine, ACK.


Nicolas



> 
> Cheers
> ---Dave
> 
