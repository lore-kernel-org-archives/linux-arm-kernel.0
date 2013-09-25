From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 25 Sep 2013 11:48:06 +0300
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Message-ID: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Version 7 contains following high level changes:
- Dropped support for basic bindings from Mike Turquette, instead using
  vendor specific bindings for all clocks
- Mux clock + divider clock vendor specific bindings get rid of use
  of the bit-masks, instead these are generated runtime based on parent
  clock / divider min/max info, see individual patches for details
- Added support for dummy_ck nodes, was missing from previous version
- Fixed support for omap3630
- Added support for new clock node type: ti,mux-gate-clock (using composite
  clock type)
- OMAP4 / OMAP5 only build fixes (compiler flag checks added to some files)
- most of the of_omap_* calls renamed to of_ti_*
- Rebased on top of v3.12-rc2

Some detailed comments about patch level changes (if no mention, no major
changes):
- Patch #1:
  * removed use of reg-names property, instead registers mapped using
    compatible string
  * removed ti,modes property, instead uses DPLL mode flags now
  * separated AM33XX DPLLs under their own compatible strings
- Patch #4 & #5: new patches
- Patch #6: merged basic gate support from Mike to this patch as vendor
  specific gate clock support
- Patch #9 & #10: new patches
- Patch #11: dummy clocks added, USB / ABE DPLL setup ordering changed
- Patch #14: dummy clocks added
- Patch #20: dropped usage of reg-names property
- Patch #21: dummy clocks added
- Patch #22 & #23: new patches
- Patch #30: AM35XX clock data added to this patch
- Patch #31:
  * dummy clocks added
  * added missing 3630 clocks

Test branch available here:
https://github.com/t-kristo/linux-pm.git
branch: mainline-3.12-rc2-ti-dt-clks-v7

Testing done:
- am335x-bone : boot only
- omap5-sevm : boot only
- dra7-evm : boot only
- omap3-beagle : boot + suspend/resume (ret + off)
- omap4-panda-es : boot + suspend/resume

Nishanth has also been doing some tests with omap3-beagle-xm with some WIP
versions of this branch, but not with this latest one. Nishanth, maybe you
can provide test results to this one also?

-Tero
