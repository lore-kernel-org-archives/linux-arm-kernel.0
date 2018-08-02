From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Aug 2018 13:01:17 +0100
Subject: [GIT PULL] arm64 regression fix for 4.18
Message-ID: <20180802120117.GB14419@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Ard found a nasty arm64 regression in 4.18 where the AES ghash/gcm code
doesn't notify the kernel about its use of the vector registers, therefore
potentially corrupting live user state. The fix is straightforward and
Herbert agreed for it to go via arm64.

Please pull.

Thanks,

Will

--->8

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c7513c2a2714204d3588ecaa170ae628fd0d217e:

  crypto/arm64: aes-ce-gcm - add missing kernel_neon_begin/end pair (2018-07-31 13:20:30 +0100)

----------------------------------------------------------------
arm64 regression fix

- Fix potential clobbering of user vector register state by AES ghash code

----------------------------------------------------------------
Ard Biesheuvel (1):
      crypto/arm64: aes-ce-gcm - add missing kernel_neon_begin/end pair

 arch/arm64/crypto/ghash-ce-glue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
