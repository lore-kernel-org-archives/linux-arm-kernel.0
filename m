From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Oct 2013 15:39:30 -0600
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
Message-ID: <20131022213930.GA14529@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 04:41:23PM -0400, Nicolas Pitre wrote:

> I think it is best to establish any process around DT assuming no strong 
> binding stability.  Eventually the DT binding update frequency will 
> converge to zero while the kernel will continue to be developed.  But 
> the DTB for a particular hardware might have to change from time to 
> time.

This is exactly what happened on our PPC platforms, the bindings
churned for a bit and have been stable now since 2.6.2x something.

I'm hopefully seeing something similar on kirkwood. 3.7 bindings look
nothing like 3.12 bindings, but the 3.12 bindings will run lightly
patched 3.10 and onwards just fine, and there are no pending patches
I've seen that would change that for 3.13..

To me, it is an advantage to DT that it does converge on something
stable, while .c code always gets light churn, no matter where it is.

Jason
