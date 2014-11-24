From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 24 Nov 2014 16:18:30 +0100
Subject: [RFC 0/2] Fix Arndale Octa/Peach Pi boot on Audio subsystem clocks
Message-ID: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This is initial idea to solve dependency between AudioSS clocks
and main clock controller on Exynos platform.

This solves boot failure of Peach Pi/Pit and Arndale Octa [1].

It is only RFC/proof of concept because I would like to hear whether
this is good direction to solve this particular issue (especially that
it touches main clk api).


[1] http://www.spinics.net/lists/linux-samsung-soc/msg39331.html

Best regards,
Krzysztof Kozlowski


Krzysztof Kozlowski (2):
  clk: Allow overriding generic ops for clocks
  clk: samsung: Fix clock disable failure because domain being gated

 drivers/clk/clk-gate.c                 | 16 ++++++--
 drivers/clk/samsung/clk-exynos-audss.c | 69 +++++++++++++++++++++++++++-------
 include/linux/clk-provider.h           |  5 +++
 3 files changed, 74 insertions(+), 16 deletions(-)

-- 
1.9.1
