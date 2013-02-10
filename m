From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 18:25:14 -0800
Subject: [GIT PULL] imx device tree changes for 3.9
In-Reply-To: <20130205080642.GD16787@S2101-09.ap.freescale.net>
References: <20130205030250.GC10807@S2101-09.ap.freescale.net>
 <20130205080642.GD16787@S2101-09.ap.freescale.net>
Message-ID: <20130210022514.GB25302@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 04:06:44PM +0800, Shawn Guo wrote:
> Arnd, Olof,
> 
> On Tue, Feb 05, 2013 at 11:02:52AM +0800, Shawn Guo wrote:
> > Martin Fuzzey (5):
> >       W1: Add device tree support to MXC onewire master.
> >       W1: Convert MXC onewire master to devm_ functions.
> >       W1: Add pinctrl support to MXC onewire master.
> 
> I just dropped these two patches as they are not needed now.
> 
> The refreshed request is as below.
> 
> Shawn
> 
> The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> 
>   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.9

So, this has two merge conflicts. One with the cpuidle branch. Fine, that's
easy to resolve.

The one that's a real pain though, is the one with a fixes branch you
sent in, which changes _one property_, but throws a _HUGE_ merge conflict.

Why? Because you chose to do the churn on all the dtsi files. And this
is a conflict that would percolate all the way up so Linus sees it the way it
is now.

Please resolve this on your own and send out a new pull request. There's
a couple of ways to do it, either merge in your fixes branch, or rebase
on top of it.


Thanks,

-Olof
