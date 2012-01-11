From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 11 Jan 2012 16:53:15 -0500 (EST)
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <CAMuHMdVvQzdxw0B3ZMtJej=9Qwm7Qbd5aenSOfa=QPhX8UUt2w@mail.gmail.com>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <CA+55aFw15sw0PWtom88vJx1M45CLuvpZABQAxMOQ+xowz8Xq2A@mail.gmail.com>
 <7vty438575.fsf@alter.siamese.dyndns.org> <201201111812.46431.arnd@arndb.de>
 <CAMuHMdVvQzdxw0B3ZMtJej=9Qwm7Qbd5aenSOfa=QPhX8UUt2w@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1201111648240.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jan 2012, Geert Uytterhoeven wrote:

> On Wed, Jan 11, 2012 at 19:12, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> [...]
> 
> > Now let's assume that all dependencies are merged upstream already
> > and I just want to send out three pull requests. The first
> > pull request generally works fine, though it could be that some
> > version of git in the past would include the diff between v3.3-rc2
> > and v3.3-rc4 in the diffstat. For the second pull request, I merge
> > v3.3 with A and send do 'git request-pull B origin
> > tmp-merge-of-upstream-and-A'. This seems to generate the correct
> > list of patches, but the wrong diffstat (diffstat also contains
> > the diff between v3.3-rc4 and v3.3-rc5, although that is indeed
> > part of tmp-merge-of-upstream-and-A. For submitting branch C,
> > I have to merge upstream, A, B and the dependencies together
> > and then send a pull request against that. This typically also
> > includes the external dependencies in the diffstat.
> 
> <throwing the bat in the hen house, no idea if this expression exists
> in other languages than Dutch>
> And all of this would look nice if you would have done a rebase on top of the
> latest tagged version of Linus' tree that contains all prerequisites, right?
> </throwing...>

No, because as a maintainer merging other people's branches, you're not 
supposed to rebase anything.  Linus did flame maintainers doing that in 
the past.  The reason is that by rebasing you modify the environment in 
which the changes are applied which voids the testing that the original 
author did.


Nicolas
