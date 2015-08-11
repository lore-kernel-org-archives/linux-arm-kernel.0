From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Aug 2015 15:42:49 +0200
Subject: [GIT PULL] Renesas ARM Based SoC CPG MSTP Clock Domain Updates
 for v4.3
In-Reply-To: <cover.1438911559.git.horms+renesas@verge.net.au>
References: <cover.1438911559.git.horms+renesas@verge.net.au>
Message-ID: <20150811134249.GQ30181@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 11:12:03AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC CPG MSTP clock domain updates
> for v4.3.
> 
> This pull request is based on "Third Round of Renesas ARM Based SoC DT
> Updates for v4.3", tagged as renesas-dt3-for-v4.3, which I have also sent a
> pull-request for.
> 
> The reason for that base is that the DT changes in this series update nodes
> added in that tag.
> 
> This series begins with driver changes and follows up with DT changes.
> The latter depend on the former.
> 
> 
> The following changes since commit 94bdc48d55ca10f90b4a625f0e443197e0013557:
> 
>   ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node (2015-08-05 06:39:28 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cpg-mstp-clock-domain-for-v4.3
> 
> for you to fetch changes up to 2daa8a5a8c0994893c2ca456303f0bf53e881cb9:
> 
>   ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain (2015-08-05 06:42:51 +0900)

We normally prefer to see drivers separately from DT. If you've looked at how
we organize arm-soc, you've maybe seen that we have a separate topic for
next/driver and one for next/dt. In other words, we try to keep them apart
where it makes sense.

In this case, that would mean having the clk changes in a drivers branch, and
include that in this dt4 branch.

If you want a reminder for when you might have looked at the branch sorting
wrong: If you're naming the branch after a feature instead of the type of
patches in it (when you send it to us), then chances are that we would ideally
like to see the contents sorted differently -- at least in the cases where they
cross the category boundaries that we organize our tree in.

So, while it's not a huge deal I think it makes sense to revisit this
and do that sorting for consistency's sake. Can I please ask that you
respin this pull request with that in mind? I'd cherry-pick them apart
but I know you tend to base branches on each other so that might mess
you up and I don't want to do that.


Thanks,


-Olof
