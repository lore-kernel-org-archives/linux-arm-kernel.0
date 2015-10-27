From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 27 Oct 2015 10:42:04 +0900
Subject: [PATCH v2 0/2] Basic GPIO support for r8a7795
Message-ID: <1445910126-14097-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is an update of work by Takeshi Kihara, posted by me, then Ulrich
Hecht and now me again. The main change since Ulrich's v1 posting is to
update to new CPG/MSSR bindings via Geert Uytterhoeven. This includes
dropping "arm64: dts: r8a7795: add GPIO clocks" from the series as the new
approach does not require those nodes.

Ulrich, I would be most grateful if you could look over this and repost
if there are problems.

Base:

* "[PATCH v12 0/7] arm64: renesas: Add Renesas R8A7795 SoC support".
  This can be found in the topic/arm64-rcar-gen3-v12 branch of
  my renesas tree on kernel.org.

Run-time dependencies:
* The base
* The new GPG driver
  "[PATCH/RFC v4 0/5] clk: shmobile: Add new Renesas CPG/MSSR DT bindings"
  and its dependencies. This may be found in the
  topic/cpg-mssr-v4 branch of
  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
  along with an earlier version of this patchset which updates applied.

Availability:
* This patchset is available in the  topic/r8a7795-gpio-v2 branch of my
  renesas tree on kernel.org


Takeshi Kihara (2):
  arm64: dts: r8a7795: add GPIO nodes
  arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 112 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |   1 +
 2 files changed, 113 insertions(+)

-- 
2.1.4
