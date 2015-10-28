From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 29 Oct 2015 08:09:17 +0900
Subject: [PATCH v3 0/2] Basic GPIO support for r8a7795
Message-ID: <1446073759-10569-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is an update of work by Takeshi Kihara, posted by me, then Ulrich
Hecht and now me again.  Ulrich, I would be most grateful if you could look
over this and repost if there are problems.

Changes:

* v3
  - Correction to gpio-ranges as suggested by Geert Uytterhoeven
* v2
  - Update to new CPG/MSSR bindings via Geert Uytterhoeven

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
* This patchset is available in the topic/r8a7795-gpio-v3 branch of my
  renesas tree on kernel.org


Takeshi Kihara (2):
  arm64: dts: r8a7795: add GPIO nodes
  arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 112 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |   1 +
 2 files changed, 113 insertions(+)

-- 
2.1.4
