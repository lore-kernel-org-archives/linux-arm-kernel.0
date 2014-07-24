From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:33 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Clock Updates for
 v3.17
Message-ID: <cover.1406164563.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC clock updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-clock2-for-v3.17,
which has already been pulled into the next/soc branch of arm-soc.

I apologise that this is being sent after the release of v3.16-rc6.
It has been queued up in next since well before then and not
sending this pull-request was an oversight on my part.

The now-tagged branch of this pull-requests is one of the branched merged
to form a base for "Renesas ARM Based SoC DT Timers Updates for v3.17". And
I believe its absence is the cause of the problem you flagged with regards
to the presence of changes outside of those listed for that pull-request.


The following changes since commit ff4ce48e1f163d945c037c1c90ce12950961d91d:

  ARM: shmobile: sh73a0: add SCI clock support for DT (2014-07-12 15:15:39 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock3-for-v3.17

for you to fetch changes up to a0f7e7496d56ac2da7c684e2035815318c17973a:

  ARM: shmobile: sh73a0: add CMT1 clock support for DT (2014-07-15 13:34:17 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Clock Updates for v3.17

* Add legacy clocks for SCI for SoCs that do not yet have CCF support.
  This is to allow timer devices to be enabled using DT and
  will be removed after CCF support is added for each SoC.

  This is in keeping with the approach taken for enabling
  SCI (serial) devices using DT on these SoCs.

----------------------------------------------------------------
Simon Horman (5):
      ARM: shmobile: r8a7778: add TMU clock support for DT
      ARM: shmobile: r8a7740: add TMU clock support for DT
      ARM: shmobile: r8a73a4: add CMT1 clock support for DT
      ARM: shmobile: r8a7740: add CMT1 clock support for DT
      ARM: shmobile: sh73a0: add CMT1 clock support for DT

 arch/arm/mach-shmobile/clock-r8a73a4.c | 1 +
 arch/arm/mach-shmobile/clock-r8a7740.c | 3 +++
 arch/arm/mach-shmobile/clock-r8a7778.c | 2 ++
 arch/arm/mach-shmobile/clock-sh73a0.c  | 1 +
 4 files changed, 7 insertions(+)
