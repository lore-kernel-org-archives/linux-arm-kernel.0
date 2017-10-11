From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 11 Oct 2017 09:46:47 +0200
Subject: [GIT PULL v2] Second Round of Renesas ARM Based SoC Updates for v4.15
Message-ID: <cover.1507707869.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v4.15.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v4.15,
which I have already sent a pull-request for.

This pull request fixes a bug introduced in renesas-soc-for-v4.15.

Changes since v1:

* Correctly annotate fixes tag in changelog.


The following changes since commit 3fd45a136ff61bb54deab70fb2d534a85e40481f:

  ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15 (2017-09-18 08:10:44 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v4.15

for you to fetch changes up to 703ef76b8fd5169d5cff30de5b958d6728b9a147:

  ARM: shmobile: rcar-gen2: fix non-SMP build (2017-10-11 09:40:12 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v4.15

Fix to allow UP build of shmobile.

Arnd Bergmann says:

  A bugfix for the SMP case broke the build for the UP case:

  arch/arm/mach-shmobile/headsmp-apmu.o: In function `shmobile_boot_apmu':
  (.text+0x34): undefined reference to `secondary_startup'

  The assembler file mixes code that is used for SMP with code
  that we also need on a single-CPU build, so I'm leaving it
  always enabled in the Makefile, but enclose the SMP code
  in an #ifdef.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: rcar-gen2: fix non-SMP build

 arch/arm/mach-shmobile/headsmp-apmu.S | 2 ++
 1 file changed, 2 insertions(+)
