From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Jan 2016 09:48:49 -0800
Subject: [PATCH 0/5] omap assembly fixes for CONFIG_DEBUG_RODATA
Message-ID: <1453225734-16993-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are read-only data fixes for omaps discovered few weeks ago
with "[PATCH v2] ARM: mm: flip priority of CONFIG_DEBUG_RODATA"
that caused issues during deeper idle states on omaps [0].

Please review and test if possible. I'd like to merge these fixes
during v4.5-rc cycle to remove these blockers for making it possible
to have CONFIG_DEBUG_RODATA enabled by default.

Regards,

Tony


[0] https://lkml.org/lkml/2015/12/2/908

Tony Lindgren (5):
  ARM: OMAP2+: Fix wait_dll_lock_timed for rodata
  ARM: OMAP2+: Fix l2dis_3630 for rodata
  ARM: OMAP2+: Fix save_secure_ram_context for rodata
  ARM: OMAP2+: Fix l2_inv_api_params for rodata
  ARM: OMAP2+: Fix ppa_zero_params and ppa_por_params for rodata

 arch/arm/mach-omap2/sleep34xx.S | 60 ++++++++++++++++++++---------------------
 arch/arm/mach-omap2/sleep44xx.S | 25 +++++++++++------
 2 files changed, 47 insertions(+), 38 deletions(-)

-- 
2.7.0.rc3
