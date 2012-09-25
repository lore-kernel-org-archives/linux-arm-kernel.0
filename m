From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 12:32:35 +0300
Subject: [PATCHv5 00/10] ARM: OMAP: PM usecounting changes
Message-ID: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- Fixed OMAP4 support (patches 7-10)
- Dropped debugging support from this set for now
- Rebased on top of 3.6-rc5 + func-pwrst + omap4-ret code
  (omap4 support easier to test with these)
- Patch #1:
  * dropped clkdm_usecount_inc / clkdm_usecount_dec APIs
  * clkdm_clk_enable / disable are used now instead
  * some code ordering changed for the new setup to work properly
  * changed BUG_ON calls to WARN_ON
- Patch #2:
  * added spinlock for protecting voltdm callbacks
  * pwrdm lock extended to protect pwrdm callbacks
- Patch #3:
  * dropped generic API call for the cpu pwrdm idle / wakeup
  * instead use pwrdm_clkdm_enable / disable calls directly from PM code
  * omap4 support fixed to work properly with SMP, added omap4 specific
    CPU pwrdm idle / wakeup calls for this purpose
- Patch #4:
  * no changes
  * added 'Reviewed-by' tag for Rajendra
- Patch #5:
  * no changes, just rebase
- Patch #6:
  * no changes

Tested with OMAP3 beagle, omap4460 GP panda + omap4430 EMU blaze boards.

I will be posting new versions for the voltdm fixes + auto retention +
panda board tps6236x support code later on today, which are based on top
of this set.

Branch also available here:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.6-rc5-pwrdm-changes-v5

-Tero
