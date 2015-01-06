From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 6 Jan 2015 20:59:46 +0000 (UTC)
Subject: [GIT PULL] arm64: fix compilation breakage due to missing headers
 in next-20150105
Message-ID: <alpine.DEB.2.02.1501062058210.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Will & Catalin,

In the event you'd prefer to pull these changes from git
rather than apply them off the mailing lists:

The following changes since commit 5d96e0cba26323c3daeb9f7cdfd4efe70985e2c6:

  arm64: mm: Add pgd_page to support RCU fast_gup (2014-12-23 16:39:17 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/tegra-pending tags/arm64-header-fixes-v2-20150105

for you to fetch changes up to 22ae7f2aaa6206c1ee9275607be26bdc82f8b580:

  arm64: fix missing asm/io.h include in kernel/smp_spin_table.c (2015-01-06 13:37:10 -0700)

- ----------------------------------------------------------------
ARM64 compilation fixes for missing header includes

An ARM64 build here on next-20150105 breaks due to some missing header
file includes. Looks like someone reorganized some headers - although
I have not tracked down what the root cause is. These patches get the
kernel building again. They are based on the arm64 fixes/core
branch.

This second version includes comments from Mark Rutland
<mark.rutland@arm.com>.

Compile-tested only.

- ----------------------------------------------------------------
Paul Walmsley (4):
      arm64: fix missing asm/pgtable-hwdef.h include in asm/processor.h
      arm64: fix missing linux/bug.h include in asm/arch_timer.h
      arm64: fix missing asm/alternative.h include in kernel/module.c
      arm64: fix missing asm/io.h include in kernel/smp_spin_table.c

 arch/arm64/include/asm/arch_timer.h | 1 +
 arch/arm64/include/asm/processor.h  | 1 +
 arch/arm64/kernel/module.c          | 1 +
 arch/arm64/kernel/smp_spin_table.c  | 1 +
 4 files changed, 4 insertions(+)

   text	   data	    bss	    dec	    hex	filename
7173728	 449984	 199064	7822776	 775db8	vmlinux.old
7173728	 449984	 199064	7822776	 775db8	vmlinux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrExOAAoJEMePsQ0LvSpLMe0P/0NVStCPq7KYd9Uwqfj2uOz8
odiM8m+BznB8NFGtqvRttPl/oJFqmh7GG7zJvZGA3BQfX0vEhf48snyk/vEcQe2O
deyML6wcRf5+GxNAPJ0/bg16/8Zzcj8FSd6MJcd0Eearg9KTxDnfoQU4060+gyhR
dr+8CZISovqc7ChRC8Cl3EPQg+BWF0KdKYB1vcD36T6cYVtwk0H1q7JhJhurBLcX
cLWJcDd2sRyiCIPHWGjVPvcdnD5ooIrI/G523dC7NGNR2ButvjgWqbY8EnAiAXCy
QS4xRb4LHe0WU/dsQPHq08AFWgOInK5tXr5+Q4KbOO2tO8xReeAEVFLVrQfuPiHa
UH7G+nFwuCEm1BNWWTIBOroyT72Ef/u19cgBbaxtX3QyXdGaweNL3SEMlXPdu/Be
7aCqP95sjyZ23jxmoLyaAsjgrjZcArYx+VufRcJKNRDvWW8+c+Kh2yMKkeJB3y+v
dhqrajq1LhoaHRp7YXpLk3vEliCLyOFkaYao6UJ5eQ9AO/oa2Trb50whfIO5TZec
fJEK0xt9RwYeYLyAldeIJnMM7P0+1BNwboqSmtGKCTgUpLdhr2nnoy5t7j931dv3
AdJSt05BtUH1qlDbTlO0kSH39efiYVVu2M0GBS7L6Fadi7FHc1+/wyB1Nd+wvfkO
9c8Y8BxEYwA6uIDHV2TB
=6xVW
-----END PGP SIGNATURE-----
