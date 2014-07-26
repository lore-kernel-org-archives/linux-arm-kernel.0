From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jul 2014 10:37:30 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 4)
In-Reply-To: <4997815.jasXMfNc8s@wuerfel>
References: <20140725124926.GH23220@titan.lakedaemon.net>
 <4997815.jasXMfNc8s@wuerfel>
Message-ID: <20140726143730.GK23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Sat, Jul 26, 2014 at 11:46:46AM +0200, Arnd Bergmann wrote:
> On Friday 25 July 2014 08:49:26 Jason Cooper wrote:
> > Here's the (late) last round of changes for mvebu.  Daniel and Thomas
> > did a great job reviewing and resubmitting the cpuidle series, so that
> > is the primary content of this pull request.  There are also a few small
> > changes and Thomas added the URLs for publicly released datasheets for
> > the Armada XP SoCs!
> > 
> > Note that the cpuidle series depends on some fixes in mvebu/fixes,
> > therefore, mvebu/soc now depends on mvebu/fixes.  No matter how I did a
> > temporary merge branch, the commit list is correct (no commits from
> > mvebu/fixes), however, the diffstat includes the changes from
> > mvebu/fixes (the dts changes give it away).
> 
> I suspect this is the 'backmerge' problem: You pulled the fixes branch
> into the soc-cpuidle branch, so git now sees the fixes as part of your
> branch. IIRC you can avoid this if you do the merge the other way round
> and start a new branch on top of fixes and then pull the soc-cpuidle
> branch into that. That in turn will give you an odd-looking commit
> message though, so you can't do it right until someone adds support into
> git-merge to handle it better.

I would be happy if git diff had some sort of --without option so I
could do:

$ git diff --stat --without mvebu/fixes tags/mvebu-soc-3.17-3..tags/mvebu-soc-3.17-4

Since git log seems to figure it out ok with the temporary merge branch.

> > To remedy this, I've included the diffstat of v3.16-rc1..mvebu/fixes at
> > the bottom so that you can compare.  Everything in /fixes has already
> > been pulled.
> > 
> > Based on tags/mvebu-soc-3.17-3, please pull.
> 
> Pulled into next/soc, thanks!

Thanks for taking this so late in the cycle, we appreciate it!

thx,

Jason.
