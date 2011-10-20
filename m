From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 23:04:35 +0200
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <20111020185612.GD21648@n2100.arm.linux.org.uk>
References: <4E97A601.1020005@gmail.com> <4EA055AF.4030207@gmail.com>
	<20111020185612.GD21648@n2100.arm.linux.org.uk>
Message-ID: <2901028.94TxBXiCYq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 October 2011 19:56:12 Russell King - ARM Linux wrote:
> On Thu, Oct 20, 2011 at 12:09:03PM -0500, Rob Herring wrote:
> > highbank/soc doesn't build. It needs Russell's l2x0 and io branches.
> > l2x0 has been rebased recently, but the io branch seems to be stable
> > (but not published externally).

I've kept the dt/gic branch the way I had it now, I guess the extra
branch in it doesn't hurt and removing it would cause extra work.
I'll just have to wait until it's merged then.

The highbank/soc branch is now rebased on top of
dt/gic+depends/rmk/io+depends/rmk/l2x0+depends/rmk/gpio.

I ended up having to add the gpio branch to the ones you mentioned to
get it all to compile.

> Actually, l2x0 _hasn't_.  Let's be clear about what happened.  A load
> of patches were all merged into the 'misc' branch over time, containing
> multiple different subjects.  At the time they were merged there was
> no clear separate line of development of each sub-system, so they
> just ended up in a common branch without any particular ordering or
> grouping.
> 
> People wanted to base work on a select few of those commits.  Rather
> than having the entire set of commits merged into various peoples trees,
> many of which have nothing to do with what they were working on, I
> split various commits out of the 'misc' branch and created a set of
> more fine-grained topic branches.
> 
> That is arguably not rebasing - it is re-committing, in such a way that
> those parts can then be frozen, stabilized and published without
> unintended dependencies.  That's got to be a good thing.

Yes, this certainly sounds good to me. One can still call it rebasing,
since you rebased the misc branch to create the l2x0 branch, but that
was of course specifically done to make it possible to create a stable
highbank tree, which is what Rob needs.

I'm not sure if I used the intended process to get at those branches.
Since they are not published on ftp.arm.linux.org.uk as separate branches,
I looked at the big merge changeset in the for-next branch and recreated
the branches I needed, which feels like I'm doing something that wasn't
your intention. Is there a better way?

	Arnd
