From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Aug 2018 17:12:13 +0100
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20180831161213.GH30626@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

A few arm64 fixes came in this week, specifically fixing some nasty
truncation of return values from firmware calls and resolving a VM_BUG_ON
due to accessing uninitialised struct pages corresponding to NOMAP pages.
Details in the tag.

Please pull, thanks.

Will

--->8

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f52bb98f5aded4c43e52f5ce19fb83f7261e9e73:

  arm64: mm: always enable CONFIG_HOLES_IN_ZONE (2018-08-31 11:06:45 +0100)

----------------------------------------------------------------
A handful of arm64 fixes

- Fix typos in SVE documentation
- Fix type-checking and implicit truncation for SMCCC calls
- Force CONFIG_HOLES_IN_ZONE=y so that SLAB doesn't fall over NOMAP regions

----------------------------------------------------------------
James Morse (1):
      arm64: mm: always enable CONFIG_HOLES_IN_ZONE

Julien Grall (1):
      Documentation/arm64/sve: Couple of improvements and typos

Marc Zyngier (2):
      arm/arm64: smccc-1.1: Make return values unsigned long
      arm/arm64: smccc-1.1: Handle function result as parameters

 Documentation/arm64/sve.txt |  4 ++--
 arch/arm64/Kconfig          |  1 -
 include/linux/arm-smccc.h   | 38 ++++++++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 17 deletions(-)
