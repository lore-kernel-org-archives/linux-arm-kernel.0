From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 29 Sep 2012 20:55:48 -0400
Subject: [GIT PULL V2] dove late fixes for v3.7
In-Reply-To: <20120929210915.GE12999@quad.lixom.net>
References: <20120925020716.GY5469@titan.lakedaemon.net>
 <20120929210915.GE12999@quad.lixom.net>
Message-ID: <20120930005548.GN13343@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2012 at 02:09:15PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, Sep 24, 2012 at 10:07:16PM -0400, Jason Cooper wrote:
> > Depends:
> >  - Based against arm-soc/for-next
> 
> Unfortunately this won't work. The arm-soc for-next branch is not a stable
> branch, it's the aggregate where we merge in the contents of different next/*
> branches for staging, but the branch itself doesn't get sent upstream.
> 
> Can you rebase this branch against something that makes more sense? Ideally the
> branch that introduced the breakage, since that will minimize the upstream
> exposure to the bugs.

Ok, since you merged all of the kirkwood/mvebu stuff into one branch, I
based against that (arm-soc/late/kirkwood).

---
Depends:
 - Based against arm-soc/late/kirkwood
 - Latest changes to arch/arm/mm/cache-tauros2.c
    c2b7e05 ARM: cache: add dt support for tauros2 cache

Misc. fixes for latest changes to mach-dove/
Fixes build breakage for mach-dove

The following changes since commit 46f2007c1efadfa4071c17e75f140c47f09293de:

  ARM: mvebu: fix build breaks from multi-platform conversion (2012-09-28 22:27:07 +0200)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git dove/late-fixes

Sebastian Hesselbarth (6):
      ARM: dove: Add pcie clock support
      ARM: dove: Fix tauros2 device tree init
      ARM: dove: Fix clock names of sata and gbe
      ARM: dove: Restructure SoC device tree descriptor
      ARM: dove: Remove watchdog from DT
      ARM: dove: Add crypto engine to DT

 arch/arm/boot/dts/dove.dtsi |   49 ++++++++++++++++++++++++++++---------------
 arch/arm/mach-dove/common.c |    8 +++---
 arch/arm/mach-dove/pcie.c   |    5 ++++
 3 files changed, 41 insertions(+), 21 deletions(-)
