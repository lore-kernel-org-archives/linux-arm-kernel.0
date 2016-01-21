From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Jan 2016 11:12:02 -0800
Subject: [PATCH v2 0/5] omap assembly fixes for CONFIG_DEBUG_RODATA
Message-ID: <1453403527-21308-1-git-send-email-tony@atomide.com>
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

Changes since v1:

- Fix missing ldr in patch 2/5 as Noticed by Nicolas Pitre. This
  had gone unnoticed as the code just happened to work on omap36xx
  without actually toggling the L2 cache. And patches 4 and 5 are setting
  the address, not the value unlike patch 2/5. I've added some comments
  to patch 2/5 too.

- Fix a typo noticed by Sergei Shtylyov in patch 3/5.

[0] https://lkml.org/lkml/2015/12/2/908

Tony Lindgren (5):
  ARM: OMAP2+: Fix wait_dll_lock_timed for rodata
  ARM: OMAP2+: Fix l2dis_3630 for rodata
  ARM: OMAP2+: Fix save_secure_ram_context for rodata
  ARM: OMAP2+: Fix l2_inv_api_params for rodata
  ARM: OMAP2+: Fix ppa_zero_params and ppa_por_params for rodata

 arch/arm/mach-omap2/sleep34xx.S | 61 ++++++++++++++++++++---------------------
 arch/arm/mach-omap2/sleep44xx.S | 25 +++++++++++------
 2 files changed, 47 insertions(+), 39 deletions(-)

-- 
2.7.0.rc3
