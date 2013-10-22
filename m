From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Oct 2013 16:41:23 -0400 (EDT)
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022201228.GB8037@mithrandir>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk> <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>
 <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
 <20131022201228.GB8037@mithrandir>
Message-ID: <alpine.LFD.2.03.1310221624390.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Oct 2013, Thierry Reding wrote:

> On Tue, Oct 22, 2013 at 01:42:48PM -0400, Nicolas Pitre wrote:
> > On Tue, 22 Oct 2013, Matt Porter wrote:
> > 
> > > DT has many benefits. It would be great to leverage them as long as it
> > > doesn't interfere with the rate of change and willingness to evolve code
> > > that's always been the strength of the kernel process. That strength is
> > > too valuable to trade away for the "DT as ABI" vision.
> > 
> > Amen.  This is the best statement I've read about DT so far.
> > 
> > Having "stable" DT bindings is just a dream.  Experience so far is 
> > showing that this is neither practical nor realistic.
> > 
> > The unstructured free-for-all approach isn't good either.  Some 
> > compromise between the two extremes needs to be found.
> 
> I agree. I think we need an easy way to mark bindings as unstable.

No, that's not a solution.

It is fairly easy to qualify a small set of bindings as "stable" for 
interoperability purpose (e.g. for qemu/kvm).

But for the vast majority it is very hard to decide when a particular 
binding has reached stability.  By definition, a binding may be 
considered "stable" only after seeing no change for a reasonable period 
of time being tested and used.  So stability may simply not be a 
criterion for upstream merging.

I think it is best to establish any process around DT assuming no strong 
binding stability.  Eventually the DT binding update frequency will 
converge to zero while the kernel will continue to be developed.  But 
the DTB for a particular hardware might have to change from time to 
time.


Nicolas
