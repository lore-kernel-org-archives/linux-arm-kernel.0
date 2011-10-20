From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Oct 2011 16:08:32 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <20111020185612.GD21648@n2100.arm.linux.org.uk>
References: <4E97A601.1020005@gmail.com> <201110201507.38722.arnd@arndb.de>
	<4EA03160.1050304@gmail.com> <201110201812.29202.arnd@arndb.de>
	<4EA055AF.4030207@gmail.com>
	<20111020185612.GD21648@n2100.arm.linux.org.uk>
Message-ID: <4EA08DD0.1090706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 10/20/2011 01:56 PM, Russell King - ARM Linux wrote:
> On Thu, Oct 20, 2011 at 12:09:03PM -0500, Rob Herring wrote:
>> highbank/soc doesn't build. It needs Russell's l2x0 and io branches.
>> l2x0 has been rebased recently, but the io branch seems to be stable
>> (but not published externally).
> 
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

Understood, but from a git perspective the commit ids have changed.
While git can deal with trivial re-commits like this, my understanding
is that should be avoided for upstream merges. Otherwise, I could just
cherry-pick them and re-commit them in my tree.

Ultimately, the people working off of those branches do need them to be
stable to merge their branches. So are you saying your l2x0 branch
(91c2ebb90b1890abc648ba9dec5608cbc97e1cb9) is now stable? Can you
publish it as a branch. iMX6Q is also dependent on it.

Rob
