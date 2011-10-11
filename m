From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Oct 2011 16:09:15 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <201110111533.50768.arnd@arndb.de>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<201110101320.24457.arnd@arndb.de>
	<20111010133246.GG2451@mudshark.cambridge.arm.com>
	<201110111533.50768.arnd@arndb.de>
Message-ID: <20111011150915.GE23188@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 02:33:50PM +0100, Arnd Bergmann wrote:
> On Monday 10 October 2011, Will Deacon wrote:
> > I don't think asking Russell to maintain a stable branch for each series
> > scales very well if multiple people are doing cross-platform work at the
> > same time. If he's happy merging platform code via his tree, then I'd prefer
> > to go down that route. In this case, it might make sense to try and catch
> > conflicts between his tree and arm-soc before they hit Linus (I guess -next
> > will take care of this?).
> 
> Yes, we can definitely spot the conflicts in linux-next, and it gives us
> the chance to fix them up, e.g. I can wait with sending the arm-soc
> branches upstream until Russell's branches are merged, at which point
> I just pull in the branch that was merged into Linus' tree and resolve
> all conflicts I get.

Ok, that sounds good to me.

> > > Can you check if the devel-stable branch in his tree already contains the
> > > dependencies?
> > 
> > I just had a quick look and I can't seem them outside of the unstable for-next
> > branch.
> 
> Ok. I think I'll drop the cpu-mapping branch from arm-soc as well then.

Sure, I'll resubmit it to Russell via the patch system with your ack. I'll
do the same for the DEBUG_LL platform updates too.

> Are the patches in Russell's tree true dependencies for your work, or just
> patches touching the same files? If you can send me a branch that contains
> only your work without any of the patches that are in an unstable branch
> on Russell's side, I could also take them into arm-soc and take care
> of the conflicts together with Stephen.

For the cpu-mapping, I depend on:

ARM: 7011/1: Add ARM cpu topology definition
ARM: 7060/1: smp: populate logical CPU mapping during boot
ARM: 7061/1: gic: convert logical CPU numbers into physical numbers

which I can only see in Russell's for-next branch.

For the debug-ll stuff, I depend on:

ARM: 7072/1: debug: use kconfig choice for selecting DEBUG_LL UART

and conflict with:

ARM: 7097/1: debug: Move DEBUG_ICEDCC into the DEBUG_LL choice
ARM: 7096/1: debug: Add UART1 config choices
ARM: 7116/1: debug: provide dummy default option for DEBUG_LL UART choice
ARM: 7073/1: debug: augment DEBUG_LL Kconfig help to clarify behaviour

so it's probably easier to go via Russell this time.

Cheers,

Will
