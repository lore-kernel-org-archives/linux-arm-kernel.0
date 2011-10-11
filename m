From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 15:33:50 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111010133246.GG2451@mudshark.cambridge.arm.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<201110101320.24457.arnd@arndb.de>
	<20111010133246.GG2451@mudshark.cambridge.arm.com>
Message-ID: <201110111533.50768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 October 2011, Will Deacon wrote:
> On Mon, Oct 10, 2011 at 12:20:24PM +0100, Arnd Bergmann wrote:
> > On Monday 10 October 2011, Will Deacon wrote:
> > > Do you have any other ideas?
> > 
> > I think the best solution would be to ask Russell to put all the dependencies
> > into a non-rebasing branch and publish that, or to alternatively merge your
> > patches through his tree instead, with my Ack.
> 
> I don't think asking Russell to maintain a stable branch for each series
> scales very well if multiple people are doing cross-platform work at the
> same time. If he's happy merging platform code via his tree, then I'd prefer
> to go down that route. In this case, it might make sense to try and catch
> conflicts between his tree and arm-soc before they hit Linus (I guess -next
> will take care of this?).

Yes, we can definitely spot the conflicts in linux-next, and it gives us
the chance to fix them up, e.g. I can wait with sending the arm-soc
branches upstream until Russell's branches are merged, at which point
I just pull in the branch that was merged into Linus' tree and resolve
all conflicts I get.
 
> > Can you check if the devel-stable branch in his tree already contains the
> > dependencies?
> 
> I just had a quick look and I can't seem them outside of the unstable for-next
> branch.

Ok. I think I'll drop the cpu-mapping branch from arm-soc as well then.

Are the patches in Russell's tree true dependencies for your work, or just
patches touching the same files? If you can send me a branch that contains
only your work without any of the patches that are in an unstable branch
on Russell's side, I could also take them into arm-soc and take care
of the conflicts together with Stephen.

	Arnd
