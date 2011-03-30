From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Mar 2011 16:48:43 -0400 (EDT)
Subject: [PATCH] Reject kprobes when Rn==15 and writeback is set
In-Reply-To: <1301513949.2488.229.camel@computer2.home>
References: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
	<1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301500340.2488.127.camel@computer2.home>
	<alpine.LFD.2.00.1103301328280.28032@xanadu.home>
	<1301513949.2488.229.camel@computer2.home>
Message-ID: <alpine.LFD.2.00.1103301643030.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2011, Tixy wrote:

> On Wed, 2011-03-30 at 13:59 -0400, Nicolas Pitre wrote:
> > We can safely ignore the second case, but the first case clearly has the 
> > potential for trouble if mis-emulated.  And trying to correctly emulate 
> > any of those cases is worthless.
> 
> I don't think it's quite as black and white. In both cases the kernel
> was executing an illegal instruction before we inserted the probe, so we
> are probably already in the territorial of "affects the running thread"
> and security issues.

Sure.  If the code was there in the first place then that's not our 
problem (kprobes hat on).  But we should never provide an opportunity 
for making it even less secure through emulation discrepancies that can 
be exploited.

> However, if the simple rule we need to follow is "avoid ambiguous writes
> to PC" then I won't put up any more fight :-) (Expecially as I just
> checked normal execution of one writeback to PC instruction an found
> that PC was unaffected ;-)

Right.  I think this rule should be carefully implemented.  We probably 
are OK being lax with other types of undefined behaviors.


Nicolas
