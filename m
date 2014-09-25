From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 18:01:18 +0200
Subject: [GIT PULL 1/3] ARM: tegra: core SoC code changes for 3.18
In-Reply-To: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
References: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201409251801.18466.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 September 2014, Stephen Warren wrote:
> the primary change here gets its address information from DT rather than
> iomap.h. This removes one more user of iomap.h, and will help allow the
> code to move to a location that can be shared between arch/arm and
> arch/arm64.
> 
> An unused header file was also removed.
> 

Pulled all three into the respective soc, dt and defconfig branches.

The defconfig branch was based on -rc2 rather than -rc1, which is mildly
annoying since it means we are backmerging commits from upstream, please
try to avoid that in the future, or describe why it was done if you
had a good reason.

Also I noticed that your defconfig changes enable things in the tegra
defconfig that are not part of multi_v7_defconfig. Could you create
another patch to enable everything you need in terms of Tegra hardware
support in multi_v7_defconfig as well, preferably as loadable modules?

Thanks!

	Arnd
