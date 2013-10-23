From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 10:50:27 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <alpine.LFD.2.03.1310221624390.1951@syhkavp.arg>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
 <20131022201228.GB8037@mithrandir>
 <alpine.LFD.2.03.1310221624390.1951@syhkavp.arg>
Message-ID: <20131023085027.GA11954@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 04:41:23PM -0400, Nicolas Pitre wrote:
> On Tue, 22 Oct 2013, Thierry Reding wrote:
> 
> > On Tue, Oct 22, 2013 at 01:42:48PM -0400, Nicolas Pitre wrote:
> > > On Tue, 22 Oct 2013, Matt Porter wrote:
> > > 
> > > > DT has many benefits. It would be great to leverage them as long as it
> > > > doesn't interfere with the rate of change and willingness to evolve code
> > > > that's always been the strength of the kernel process. That strength is
> > > > too valuable to trade away for the "DT as ABI" vision.
> > > 
> > > Amen.  This is the best statement I've read about DT so far.
> > > 
> > > Having "stable" DT bindings is just a dream.  Experience so far is 
> > > showing that this is neither practical nor realistic.
> > > 
> > > The unstructured free-for-all approach isn't good either.  Some 
> > > compromise between the two extremes needs to be found.
> > 
> > I agree. I think we need an easy way to mark bindings as unstable.
> 
> No, that's not a solution.
> 
> It is fairly easy to qualify a small set of bindings as "stable" for 
> interoperability purpose (e.g. for qemu/kvm).
> 
> But for the vast majority it is very hard to decide when a particular 
> binding has reached stability.  By definition, a binding may be 
> considered "stable" only after seeing no change for a reasonable period 
> of time being tested and used.  So stability may simply not be a 
> criterion for upstream merging.

That's not what I was suggesting. I've been arguing all along that it
should be possible to upstream code that relies on unstable bindings
precisely so that we could get some reasonable amount of testing.

Perhaps I should also restate that stable doesn't actually mean "can
never change". If we're only concerned about stable ABI, then the
bindings can still change, *if* they do so in a backwards-compatible
way.

Furthermore, it's also been stated in this thread and elsewhere, that
it's entirely possible to pull something like that off even without
unstable bindings. The only additional requirement is that if a change
is introduced that causes backwards-incompatibility, then we cannot
change the binding, but instead have to add a new one. That's the same
thing we do with syscalls as Russell has said.

It is true that this requires additional code will have to be written.
At the same time it's likely that most of the driver code will still be
possible to be shared between two differing bindings, so perhaps the
result won't even be as catastrophic as people like to make it sound.
We're currently lacking functionality, even trivial things, because of
what? Because we're afraid of making mistakes.

I'm beginning to think that we need to grow a pair.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/e60b9347/attachment.sig>
