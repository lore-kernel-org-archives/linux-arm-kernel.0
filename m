From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 20 Jul 2012 17:20:23 +0800
Subject: [PATCH 0/4] ASoC: fix saif record unwork issue
Message-ID: <1342776027-31758-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series mainly fixes the saif record unwork issue.
The root cause consists of:
1) clk_prepare and clk_enable un-balanced
2) missed setting a proper initial clock rate for saif in dt
3) sgtl5000 dapm widget kcontrol does not work
   So can not test record on mx28evk.
4) missed setting clkmux mode for saif in dt

With this patch series it can fix sgtl5000 widget kcontrol unwork
and saif record unwork issue.

BTW, just let people konw, i still met a few overruns during record,
that's another issue and will be fixed in separte patches later.

Patch based on sound-2.6/for-3.6.

Dong Aisheng (4):
  ASoC: mxs-saif: fix clock prepare and enable unbalance issue
  ASoC: mxs-saif: set a base clock rate for EXTMASTER mode work
  ASoC: sgtl5000: remove unneeded snd_soc_dapm_new_widgets in probe
  ARM: mx28evk: add missed clkmux select for saif

 arch/arm/mach-mxs/mach-mxs.c |    3 +++
 sound/soc/codecs/sgtl5000.c  |    2 --
 sound/soc/mxs/mxs-saif.c     |   24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)
