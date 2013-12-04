From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Dec 2013 17:17:45 -0800
Subject: [GIT PULL 00/28] Renesas ARM based SoC updates for v3.14
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <20131204011745.GD20332@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 02, 2013 at 11:18:47AM +0900, Simon Horman wrote:
> Hi Kevin, Hi Olof, Hi Arnd,
> 
> please consider these Renesas ARM based SoC updates for v3.14.
> 
> This pull-request is based on "[GIT PULL 00/16] Renesas ARM based SoC
> defconfig updates for v3.14" (tag: renesas-defconfig-for-v3.14) which I
> send a pull-request for on Thursday. The reason for this is to include
> defconfig updates for the emma2 based kzm9d which are required in order to
> avoid a build regression when using the defconfig for that board.

If you can get a build regression due to an outdated defconfig, then you're
likely missing some dependencies in your Kconfig? You could hit the same state
of configurations through randconfig. So I think fixing the dependencies is
better than relying on the defconfig branch in this case.

Would you mind doing it that way instead? It'd reduce our dependencies and in
general it's a more appropriate approach.

> This pull-request also includes defconfig changes related to renaming
> ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY. These are also to avoid build
> regressions when using defconfigs.

So what happens if someone has an old defconfig in their build environment
(i.e. hosted outside of the kernel tree), will they see breakage? If so, you
should probably add a new option ARCH_SHMOBILE_MULTI or similar.

We had similar issues with the first attempt to go multiplatform on Exynos,
some existing defconfigs wouldn't build a usable kernel any more due to new
options, so Arnd had to do it the other way (that code is still unmerged
though).


-Olof
