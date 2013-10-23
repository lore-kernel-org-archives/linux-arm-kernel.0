From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 11:02:29 +0200
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
Message-ID: <20131023090228.GB11954@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 04:41:23PM -0400, Nicolas Pitre wrote:
[...]
> I think it is best to establish any process around DT assuming no strong 
> binding stability.  Eventually the DT binding update frequency will 
> converge to zero while the kernel will continue to be developed.  But 
> the DTB for a particular hardware might have to change from time to 
> time.

A stable ABI certainly has its advantages in my opinion. That's why I'm
convinced that we should try and accomodate for both options. We should
try to come up with a good binding to begin with, as much is clear. But
there's little point in reviewing it to death because any number of
reviewers are unlikely to consider every single possible use-case.

So I propose that we mark such bindings unstable to allow us to put them
through some real world testing in mainline to find out if they work in
practice or not. If they do work reasonably well for a large number of
use-cases, we can decide to mark them stable, at which point they can
only be modified in a backwards-compatible way. That still gives us the
freedom to supersede it by a better binding if that ever becomes
necessary.

The reason why I propose to explicitly mark bindings unstable rather
than the other way around is that I still have hope that we'll reach
some level of stability eventually. It will probably still need some
time because most of us are learning as we go and just don't have the
experience to get things right from the start.

Having some visual marker, such as the exclamation mark I proposed, in
the compatible value is irritating enough to make it clear that it's not
"good". That's an incentive for people to actively work on making it
good or giving it the necessary testing to be able to declare it good.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/4cbee42b/attachment.sig>
