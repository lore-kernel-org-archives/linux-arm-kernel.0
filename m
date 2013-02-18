From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Feb 2013 09:29:34 +0900
Subject: [PATCH v3 0/2] ARM: shmobile: r8a7779: Correct TMU clock support again
Message-ID: <1361147376-1228-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a third pass at a two line fix for a regression in TMU clock
configuration.

I have managed to track down a portion of the documentation which
confirms the discussion on the mailing list: TMU01, TMU01 and TMU02
share a common clock.

I have also added a second patch to the series to exercise TMU02.

Simon Horman (2):
  ARM: shmobile: r8a7779: Correct TMU clock support again
  [RFC] ARM: shmobile: r8a7779: Add TMU02 platform device

 arch/arm/mach-shmobile/clock-r8a7779.c |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
1.7.10.4
