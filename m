From: matt.porter@linaro.org (Matt Porter)
Date: Tue, 22 Oct 2013 11:04:26 -0400
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022093923.GC15640@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
Message-ID: <20131022150426.GF29341@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 11:39:24AM +0200, Thierry Reding wrote:
> On Mon, Oct 21, 2013 at 04:40:15PM -0400, Nicolas Pitre wrote:
> > On Mon, 21 Oct 2013, Stephen Warren wrote:
> > > I
> > > think we can still have a hack-free, churn-free, multi-platform kernel
> > > without requiring DT, but by using board files.
> > 
> > I kinda agree with you, but this is too late for that now.
> > 
> > We have DT, and the best way forward is to fix the process which is, 
> > arguably, somewhat obstructive and broken at the moment.
> 
> I agree that the process could use some enhancements. But I also think
> that we should be open to move away from DT again if it turns out to not
> be a good enough solution. "It's too late" doesn't sound like a very
> good argument to me.
> 
> Essentially DT is just a different way to represent what we used to have
> in platform data, so we haven't fundamentally changed anything at that
> level. Well, we've made things worse to some degree.

DT started that way. However, the direction set by binding reviews have
essentially limited DT to only external hardware configuration. So, yes,
we've made things worse. DT, as defined and maintained today, does not
replace platform data since it's been de facto limited to a tiny subset
of system configuration info. Further, the current approach to "breaking
compatibility" with old DTBs that has resulted from the claims of "DT as
ABI" is completely tied to the vision of moving DT independent of the
kernel. Platform data in code never had this compatibility issue.

DT has many benefits. It would be great to leverage them as long as it
doesn't interfere with the rate of change and willingness to evolve code
that's always been the strength of the kernel process. That strength is
too valuable to trade away for the "DT as ABI" vision.

All these failings can start to be fixed by addressing the process and
what DT *is*.

-Matt
