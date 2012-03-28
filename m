From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Mar 2012 20:28:16 +0100
Subject: [GIT PULL 1/5] ARM: cleanups of io includes
In-Reply-To: <CAOesGMjwZOON9kFNvaEq8QhSvjAgsJT_J1Ysb9-AbePd6g+-rQ@mail.gmail.com>
References: <1332918842-13521-1-git-send-email-olof@lixom.net>
 <1332918842-13521-2-git-send-email-olof@lixom.net>
 <20120328082501.GA22414@n2100.arm.linux.org.uk>
 <CAOesGMjwZOON9kFNvaEq8QhSvjAgsJT_J1Ysb9-AbePd6g+-rQ@mail.gmail.com>
Message-ID: <20120328192816.GD22414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 02:05:50AM -0700, Olof Johansson wrote:
> On Wed, Mar 28, 2012 at 1:25 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Mar 28, 2012 at 12:13:58AM -0700, Olof Johansson wrote:
> >> Rob Herring has done a sweeping change cleaning up all of the mach/io.h includes,
> >> moving some of the oft-repeated macros to a common location and removing a bunch of
> >> boiler plate. This is another step closer to a common zImage for multiple platforms.
> >
> > NAK. ?Linus, do not pull this. ?This breaks PXA compilation, which has
> > been known about for more than a week.
> 
> The branch contains fixes for the compilation failures, they were
> pulled in right before I staged the tag for the pull request:
> 
> http://marc.info/?l=linux-arm-kernel&m=133272592723334
> 
> If you prefer to let it sit in linux-next for a day or two before
> going in, that's fine. But I verified that the original build problem
> introduced was fixed before I sent it out.

Right, having merged the latest arm-soc tree this evening into the build
tree and forced a rebuild, the errors induced by Rob's patches are now
gone, so I'm fine with this going in now.

> Unfortunately, PXA is also broken due to the regulator changes
> mentioned in the above referenced mail, which is already upstream and
> unrelated to the changes in this branch.

Yes, I noticed that appearing when I updated the build tree on the 27th.
Not impressed by that.
