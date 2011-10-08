From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 8 Oct 2011 12:13:22 +0200
Subject: [PULL] i.MX
In-Reply-To: <201110072230.18233.arnd@arndb.de>
References: <20111004092015.GM31404@pengutronix.de>
	<201110072230.18233.arnd@arndb.de>
Message-ID: <20111008101322.GH31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 10:30:18PM +0200, Arnd Bergmann wrote:
> On Tuesday 04 October 2011, Sascha Hauer wrote:
> > Please pull the following for next. There are merge conflicts between
> > the cleanup and the features branch, so I decided to merge them together
> > so you don't have to handle the conflicts yourself. Please let me know
> > if this is ok for you or if we have to find another solution.
> 
> Hi Sascha,
> 
> it took me a while to figure out what you are doing here, but I think I've
> made it in the end. I recreated the imx/cleanup and imx/devel branches
> from the commit you sent me and made sure everything was still there, then
> did the merge again and took the conflict resolution that you had
> provided.

Well it also took me a while to figure out what I should do ;) The
problem I had started with the second pull request which partly depended
on the first one, so I decided to use the commits of the first pull
request as a base.

> 
> I also recreated the next/devel branch to have a cleaner history with
> the same contents after that.
> 
> I also took out the ata stuff into a separate branch, and will decide
> later if I submit that before the rest or as part of the devel branch.
> 
> Please check if the branch contents are ok for you now and if the for-next
> branch work for you.

Compiles and works smoothly and everything seems to be there. Thanks.

> 
> I've been thinking about these dependencies a bit more in general. I
> think a good solution is how Tony does it for the omap branches:
> There are lots of feature branches and he sends the bigger ones
> individually to me instead of one big 'devel' branch, so I can decide
> how to group them with other stuff (e.g. your ata changes can go
> into a driver branch). Any significant cleanups go *first* in each
> branch in order to avoid having to do a merge between feature and
> cleanup branches for the conflict resolution. There are (at least)
> two ways to get there, I don't mind which one you prefer:
> 
> 1. Apply all cleanups into one branch, then start each feature branch
> from the latest (at that time) version of the cleanup branch.
> 2. Keep the cleanups local to the feature branches, but have them
> first in each branch. Then create the global cleanup branch by
> merging the cleanup parts of each branch together.
> 
> In the end, the thing I'm interested in is being able to reasonably
> argue stuff like:
> a) This branch contains only cleanups. The number of lines changed
> may be huge, but you can easily tell from each commit that the
> code quality is improving throughout the branch.
> b) This is a feature branch. We've tried our best to keep each
> feature as clean and small as possible and from the commits
> it is clear to see why these changes are necessary in order to
> make progress.
> 
> When you get to a point where you have to do a manual merge between
> branches because there was no easier solution, I generally want
> to be the person to do the merge. If the merge is nontrivial,
> I certainly like to see a branch that contains the resolution
> that you ended up with, so I can do the same, but I also want to
> understand what you do, and that is easier if I get individual
> branches.

Ok, the last paragraph explains it for me. As you might have noticed
I keep all branches seperated by topics anyway, so I have no problem
letting you pull what you prefer, only I wanted to resolve the merge
conflicts myself. What I'll do next time is that I leave resolving
conflicts up to you but provide a second branch with all necessary
merges as a hint for you.

I think I still have to learn that merge conflicts are no bad thing at
all.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
