From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Jul 2016 12:07:40 +0200
Subject: [PATCH 0/6] ARM: dts: imx cleanups
Message-ID: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

I put the patches I sent in the last time in a single series here because they
conflict each other. IMHO this is merge window material because according to the
documentation writing to reserved bits doesn't have an effect and the other patches
are non-critical, too. It also splits the fec gpio patch I sent before in two as
the first submission contained some unrelated changes as was pointed out by Fabio.

The first patch was trimmed to use diff -b. This has the downside that it's not
possible to apply. But this way it makes it to the list at least.

You can also pull the series from

	git://git.kleine-koenig.org/git/linux.git imx-dt-cleanups

(which then obviously contains the full 1st patch) based on v4.7-rc6.

Best regards
Uwe

Uwe Kleine-K?nig (6):
  ARM: dts: drop function device nodes for pinctrl-imx nodes
  ARM: dts: imx25: don't configure reserved pad settings
  ARM: dts: imx25: substitute NO_PAD_CTL by the respective reset value
  ARM: dts: imx6q: don't configure reserved pad settings
  ARM: dts: imx: fix polarity of fec reset gpios
  ARM: dts: imx6-wandboard: substitute NO_PAD_CTL by the respective
    reset value

 arch/arm/boot/dts/imx1-ads.dts                     | 100 ++--
 arch/arm/boot/dts/imx1-apf9328.dts                 |  92 ++--
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |  38 +-
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   6 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  | 134 +++---
 arch/arm/boot/dts/imx25-karo-tx25.dts              |  55 +--
 arch/arm/boot/dts/imx25-pdk.dts                    | 192 ++++----
 arch/arm/boot/dts/imx27-apf27.dts                  |  56 ++-
 arch/arm/boot/dts/imx27-apf27dev.dts               | 194 ++++----
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       | 228 +++++-----
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  | 194 ++++----
 arch/arm/boot/dts/imx27-pdk.dts                    | 132 +++---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |  92 ++--
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |  78 ++--
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     | 206 +++++----
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    | 154 ++++---
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |  62 ++-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  88 ++--
 arch/arm/boot/dts/imx35-pdk.dts                    |  36 +-
 arch/arm/boot/dts/imx50-evk.dts                    |  67 +--
 arch/arm/boot/dts/imx51-apf51.dts                  |  58 ++-
 arch/arm/boot/dts/imx51-apf51dev.dts               | 176 ++++---
 arch/arm/boot/dts/imx51-babbage.dts                | 418 +++++++++--------
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts   |  78 ++--
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  | 266 ++++++-----
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |  68 ++-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 192 ++++----
 arch/arm/boot/dts/imx53-ard.dts                    | 116 +++--
 arch/arm/boot/dts/imx53-m53.dtsi                   |  64 ++-
 arch/arm/boot/dts/imx53-m53evk.dts                 | 268 ++++++-----
 arch/arm/boot/dts/imx53-mba53.dts                  | 116 +++--
 arch/arm/boot/dts/imx53-qsb-common.dtsi            | 246 +++++-----
 arch/arm/boot/dts/imx53-qsrb.dts                   |  10 +-
 arch/arm/boot/dts/imx53-smd.dts                    | 198 ++++----
 arch/arm/boot/dts/imx53-tqma53.dtsi                | 246 +++++-----
 arch/arm/boot/dts/imx53-tx53-x03x.dts              | 112 +++--
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |  74 ++-
 arch/arm/boot/dts/imx53-tx53.dtsi                  | 438 +++++++++---------
 arch/arm/boot/dts/imx53-voipac-bsb.dts             | 106 +++--
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        | 126 +++--
 arch/arm/boot/dts/imx6dl-riotboard.dts             | 362 ++++++++-------
 arch/arm/boot/dts/imx6q-arm2.dts                   | 198 ++++----
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |  24 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  94 ++--
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            | 234 +++++-----
 arch/arm/boot/dts/imx6q-evi.dts                    |  26 +-
 arch/arm/boot/dts/imx6q-gk802.dts                  |  92 ++--
 arch/arm/boot/dts/imx6q-gw5400-a.dts               | 217 +++++----
 arch/arm/boot/dts/imx6q-marsboard.dts              |  25 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |  14 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |  82 ++--
 arch/arm/boot/dts/imx6q-tbs2910.dts                |  24 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  24 +-
 arch/arm/boot/dts/imx6qdl-apf6.dtsi                | 112 +++--
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             | 306 +++++++------
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        | 406 ++++++++---------
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             | 136 +++---
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       | 176 ++++---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              | 238 +++++-----
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              | 348 +++++++-------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              | 334 +++++++-------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              | 356 +++++++--------
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              | 162 ++++---
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              | 154 ++++---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        | 152 +++----
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |  86 ++--
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |  98 ++--
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           | 378 ++++++++-------
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       | 506 ++++++++++-----------
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          | 400 ++++++++--------
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       | 288 ++++++------
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 | 264 ++++++-----
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           | 412 +++++++++--------
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           | 360 ++++++++-------
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             | 296 ++++++------
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   2 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                | 186 ++++----
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |  32 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi     |  34 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           | 193 ++++----
 arch/arm/boot/dts/imx6qp-sabreauto.dts             |  40 +-
 arch/arm/boot/dts/imx6qp-sabresd.dts               |  56 ++-
 arch/arm/boot/dts/imx6sl-evk.dts                   | 460 ++++++++++---------
 arch/arm/boot/dts/imx6sl-warp.dts                  | 208 +++++----
 arch/arm/boot/dts/imx6sx-sabreauto.dts             | 134 +++---
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  | 482 ++++++++++----------
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       |   2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   4 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    | 351 +++++++-------
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  10 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  | 334 +++++++-------
 arch/arm/boot/dts/vf500-colibri.dtsi               |  44 +-
 arch/arm/boot/dts/vf610-cosmic.dts                 |  60 ++-
 arch/arm/boot/dts/vf610-twr.dts                    | 228 +++++-----
 arch/arm/boot/dts/vf610m4-colibri.dts              |  16 +-
 arch/arm/boot/dts/vf610m4-cosmic.dts               |  12 +-
 98 files changed, 7851 insertions(+), 8027 deletions(-)

-- 
2.8.1
