From: andrew-sh.cheng@mediatek.com (Andrew-sh Cheng)
Date: Fri, 8 Dec 2017 14:07:54 +0800
Subject: [PATCH v1 0/4] add support of cpufreq to mt8173 and mt2712 
Message-ID: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on v4.15-rc1 and [1].

Mediatek projects will use mediate-cpufreq.c as cpufreq driver,
so add mediatek related projects into black list of cpufreq_dt.c

mt8173 and mt2712 both support 2 clusters, and the main difference 
is that mt2712 currently only support fixed voltage.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/544072.html

Andrew-sh Cheng (4):
  cpufreq: mediatek: add mt2712 into compatible list
  cpufreq: mediatek: Add mediatek related projects into blacklist
  arm64: dts: mediatek: add mt8173 cpufreq related device nodes
  arm64: dts: mediatek: add mt2712 cpufreq related device nodes

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 +++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  8 +++
 drivers/cpufreq/mediatek-cpufreq.c          |  1 +
 6 files changed, 201 insertions(+)

-- 
2.6.4
