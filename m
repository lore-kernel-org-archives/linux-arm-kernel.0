From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Jun 2017 21:26:36 +0800
Subject: [PATCH 0/2] ASoC: audio-graph-card: support external amplifier with
 DAPM widget
Message-ID: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It's basically the result of discussion around how external amplifier
controlled by GPIO should be supported by audio card, that uses generic
machine driver like audio-graph-card.

The patch series updates audio-graph-card bindings and driver to support
DAPM widget and audio routing, and then based on that, creates an output
driver widget with event to control the amplifier via GPIO.

[1] https://www.spinics.net/lists/arm-kernel/msg589717.html

Shawn Guo (2):
  ASoC: audio-graph-card: update bindings for amplifier support
  ASoC: audio-graph-card: add widgets and routing for external amplifier
    support

 .../devicetree/bindings/sound/audio-graph-card.txt |  5 +++
 sound/soc/generic/audio-graph-card.c               | 48 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

-- 
1.9.1
