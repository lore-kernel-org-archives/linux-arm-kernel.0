From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 10:56:23 +0200
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Fixes for v4.13
Message-ID: <cover.1502959921.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC fixes for v4.13.

This pull request is based on the second round of
such requests, tagged as renesas-fixes2-for-v4.13,
which I you have already pulled.

It is not based on the third round of fixes as they
are not related to arm64 DT and have a different base.


The following changes since commit 2752660a37aed65b1e00fd4563d9f152eefb8200:

  arm64: dts: renesas: ulcb: sound clock-frequency needs descending order (2017-07-10 10:28:07 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes4-for-v4.13

for you to fetch changes up to 8cd7b51ff57c74260b20c97623b0e0d420c22be8:

  arm64: renesas: salvator-common: avoid audio_clkout naming conflict (2017-08-07 09:50:10 +0200)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Fixes for v4.13

* Avoid audio_clkout naming conflict for salvator boards using
  Renesas R-Car Gen 3 SoCs

  Morimoto-san says "The clock name of "audio_clkout" is used by the
  Renesas sound driver.  This duplicated naming breaks its clock
  registering/unregistering.  Especially when unbind/bind it can't handle
  clkout correctly.  This patch renames "audio_clkout" to "audio-clkout" to
  avoid the naming conflict."

----------------------------------------------------------------
Kuninori Morimoto (1):
      arm64: renesas: salvator-common: avoid audio_clkout naming conflict

 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
