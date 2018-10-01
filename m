From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Oct 2018 18:46:01 +0100
Subject: [GIT PULL] Late arm64 fixes for 4.19
Message-ID: <20181001174600.GB14755@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Please pull these late arm64 fixes for 4.19. Details in the tag, but we've
fixed a hugetlb livelock issue that was reported by Fujitsu as well as
removing some useless flexibility in our KVM SET_ONE_REG ioctl().

Cheers,

Will

--->8

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2a3f93459d689d990b3ecfbe782fec89b97d3279:

  arm64: KVM: Sanitize PSTATE.M when being set from userspace (2018-10-01 14:38:26 +0100)

----------------------------------------------------------------
Late arm64 fixes

- Fix handling of young contiguous ptes for hugetlb mappings

- Fix livelock when taking access faults on contiguous hugetlb mappings

- Tighten up register accesses via KVM SET_ONE_REG ioctl()s

----------------------------------------------------------------
Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

Marc Zyngier (1):
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Steve Capper (2):
      arm64: hugetlb: Fix handling of young ptes
      arm64: hugetlb: Avoid unnecessary clearing in huge_ptep_set_access_flags

 arch/arm64/kvm/guest.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/mm/hugetlbpage.c | 50 +++++++++++++++++++++++++++++++++++------
 2 files changed, 97 insertions(+), 8 deletions(-)
