From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 14 Jul 2017 10:04:39 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v4.13
Message-ID: <cover.1500019167.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC fixes for v4.13.

This pull request is based on the previous round of
such requests, tagged as renesas-fixes-for-v4.13,
which I have already sent a pull-request for.
That pull request provides the same fix as this pull one
but for the Salvator rather than ULCB boards.

On a personal note, I will be on holidays from the 17th - 26th July.
I apologise in advance for any inconvenience that may cause.


The following changes since commit 5e2feac330953fe75197aecb20c781400e2bf606:

  arm64: renesas: salvator-common: sound clock-frequency needs descending order (2017-06-19 11:18:33 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v4.13

for you to fetch changes up to 2752660a37aed65b1e00fd4563d9f152eefb8200:

  arm64: dts: renesas: ulcb: sound clock-frequency needs descending order (2017-07-10 10:28:07 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v4.13

Correct order of sound clock frequencies for ULCB boards
used by r8a7795 and r8a7796 SoCs.

These sounds clock frequencies are used as the ADG clock (output clocks
for audio module) initial setting and sound codec's initial system clock
which needs the maximum clock frequency. Thus, descending order is
required.

----------------------------------------------------------------
Vladimir Barinov (1):
      arm64: dts: renesas: ulcb: sound clock-frequency needs descending order

 arch/arm64/boot/dts/renesas/ulcb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
