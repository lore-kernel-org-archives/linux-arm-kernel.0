From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Fri, 24 Jul 2015 18:12:12 +0800
Subject: [PATCH v12 0/6] drm/layerscape: Add Freescale DCU DRM driver
Message-ID: <1437732738-4960-1-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add support for Two Dimensional Animation and Compositing
Engine (2D-ACE) on the Freescale LS102x SoCs.

Changed in v12

-Add one patch for MAINTAINER entry for drm/layerscape
Adviced by Daniel Vetter
-Add #include <drm/drm_crtc_helper.h> in fsl_dcu_drm_drv.c

Changed in V11
-set regmap_config.cache_type to REGCACHE_FLAT
Advanced by Alexander Stein

Changed in V10
-adjust commit log, remove meaningless statement
-cleanup code for it's format and style.
-remove platform related code out, including of tcon(vf610) and scfg(ls1021a)
-remove useless sentences: encoder->crtc = crtc; and connector->encoder = encoder; and so on
-add vendor prefix for panel pandle
-make a DCU_CTRLDESCLN(x, y)  to avoid high repetition
-introduce per-SoC capability structure to avoid check on the OF node's compatible string
-Implement some functions: crtc enable and disable, enable and disable VBLANK, plane atomic_disable and atomic_enable -atomic_check and so on
-move DCU config sentence to the right place
-move get resources functions to  ->probe()
-move fsl,dcu.txt to video/ folder
-add big-endian describe
All advaced by Thierry Reding

Changed in V9

put node after calling of_drm_find_panel
split clk_prepare_enable() to clk_prepare() and clk_enable(), just call clk_prepare once, and check return value
check regmap_write/regmap_read return return value
remove useless ".owner    = THIS_MODULE,"
All advanced by Mark Yao

Changed in V8

- Remove useless code
#define DRIVER_NAME     "fsl-dcu-drm"
MODULE_ALIAS("platform:fsl-dcu-drm");
Adviced by Paul Bolle

Changed in V7

- Remove redundant functions and replace deprecated hooker
Adviced by Daniel Vetter
- Replace drm_platform_init with drm_dev_alloc/register
Adviced by Daniel Vetter

Changed in V6

- Add NEC nl4827hc19_05b panel to panel-simple.c
Adviced by Mark Yao
- Add DRIVER_ATOMIC for driver_features
Adviced by Mark Yao
- check fsl_dev if it's NULL at PM suspend/resume
Adviced by Mark Yao

Changed in V5

- Update commit message
- Add layer registers initialization
- Remove unused functions
- Rename driver folder
Adviced by Stefan Agner
- Move pixel clock control functions to fsl_dcu_drm_drv.c
- remove redundant enable the clock implicitly using regmap
- Add maintainer message

Changed in V4:

-This version doesn't have functionality changed
Just a minor adjustment.

Changed in V3:

- Test driver on Vybrid board and add compatible string
- Remove unused functions
- set default crtc for encoder
- replace legacy functions with atomic help functions
Adviced by Daniel Vetter
- Set the unique name of the DRM device
- Implement irq handle function for vblank interrupt

Changed in v2:
- Add atomic support
Adviced by Daniel Vetter
- Modify bindings file
- Rename node for compatibility
- Move platform related code out for compatibility
Adviced by Stefan Agner
