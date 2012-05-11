From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 22:24:15 +0800
Subject: [PATCH v2 0/3] Add device tree support for mxs audio
Message-ID: <1336746258-23970-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Rebased on sound/for-3.5, and consequently the patch of devm_clk_get
  is dropped.
* Fixed the issues caught by Dong (Thanks to Dong).

Shawn Guo (3):
      ASoC: mxs: mxs-pcm does not need to be a plaform_driver
      ASoC: mxs: add device tree support for mxs-saif
      ASoC: mxs: add device tree support for mxs-sgtl5000

 .../bindings/sound/mxs-audio-sgtl5000.txt          |   17 ++++
 .../devicetree/bindings/sound/mxs-saif.txt         |   36 ++++++++
 sound/soc/mxs/mxs-pcm.c                            |   24 ++----
 sound/soc/mxs/mxs-pcm.h                            |    3 +
 sound/soc/mxs/mxs-saif.c                           |   90 +++++++++++++-------
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   50 +++++++++++-
 7 files changed, 168 insertions(+), 53 deletions(-)
