From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2018 14:13:45 +0100
Subject: [GIT PULL] arm64 fixes for 4.18-rc5
Message-ID: <20180713131344.GH32020@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Catalin's out enjoying the sunshine, so I'm sending the fixes for a couple
of weeks (although there hopefully won't be any more!). Summary is in the
tag, but we've got a revert of a previous fix because it broke the build
with some distro toolchains and a preemption fix when detemining whether
or not the SIMD unit is in use.

Please pull. Thanks,

Will

--->8

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2fd8eb4ad87104c54800ef3cea498c92eb15c78a:

  arm64: neon: Fix function may_use_simd() return error status (2018-07-11 17:02:02 +0100)

----------------------------------------------------------------
More arm64 fixes:

- Revert back to the 'linux' target for LD, as 'elf' breaks some distributions

- Fix preemption race when testing whether the vector unit is in use or not

----------------------------------------------------------------
Laura Abbott (1):
      Revert "arm64: Use aarch64elf and aarch64elfb emulation mode variants"

Yandong Zhao (1):
      arm64: neon: Fix function may_use_simd() return error status

 arch/arm64/Makefile           |  6 ++++--
 arch/arm64/include/asm/simd.h | 19 +++++++------------
 2 files changed, 11 insertions(+), 14 deletions(-)
