From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Jul 2014 12:31:59 -0700
Subject: [GIT PULL 2/7] ARM: tegra: core code changes for 3.17
In-Reply-To: <1405694740-4090-2-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
 <1405694740-4090-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140719193159.GB10514@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 04:45:35PM +0200, Thierry Reding wrote:
> The following changes since commit dd849e581d7d23e1729c23bb2d6b85360ce4dd9d:
> 
>   Merge branch 'for-3.17/fuse-move' into for-3.17/soc (2014-07-17 14:58:18 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-soc
> 
> for you to fetch changes up to 7232398abc6a7186e315425638c367d50c674718:
> 
>   ARM: tegra: Convert PMC to a driver (2014-07-17 14:58:43 +0200)
> 
> ----------------------------------------------------------------
> ARM: tegra: core code changes for 3.17
> 
> Some of the code that's currently called from the Tegra machine setup
> code is moved to regular initcalls. To catch dependency violations, the
> various code paths now WARN if they're called to early. Not all of the
> potential candidates are converted yet, but those that were have been
> verified to work across all supported Tegra generations.
> 
> A new function, soc_is_tegra(), is also provided to make sure that the
> initcalls can abort early if they aren't run on Tegra, which can happen
> for multi-platform builds.
> 
> Finally this also moves out the PMC driver to drivers/soc/tegra so that
> it can be shared with 64-bit ARM.
> 
> This is based on the for-3.17/fuse-move branch. The split is somewhat
> arbitrary but allows the dependents of the for-3.17/fuse-move to pull
> in as little code as necessary.

Merged (also into next/cleanup). Thanks!


-Olof
