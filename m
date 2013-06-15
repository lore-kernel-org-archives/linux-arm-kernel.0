From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 17:20:29 -0700
Subject: [GIT PULL 3/5]: ux500 pinctrl changes for v3.11
In-Reply-To: <20130615000215.GD18124@quad.lixom.net>
References: <CACRpkdbFs=pX+Yc8EzgVyi-k5HypkHO9jMGMU+VkYfRYyinDSA@mail.gmail.com>
 <20130615000215.GD18124@quad.lixom.net>
Message-ID: <20130615002029.GH18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:02:15PM -0700, Olof Johansson wrote:
> On Tue, Jun 04, 2013 at 02:25:39PM +0200, Linus Walleij wrote:
> > Hi ARM SoC folks,
> > 
> > this is the ux500 pin control changes for v3.11. See the signed
> > tag for details.
> > 
> > The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:
> > 
> >   Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> > tags/ux500-pinctrl-for-arm-soc
> > 
> > for you to fetch changes up to 8258b187c2ba91ba1ff276fd0413f5b655824247:
> > 
> >   ARM: ux500: add ABx500 pinctrl tables (2013-05-31 16:30:38 +0200)
> > 
> > ----------------------------------------------------------------
> > Ux500 pinctrl changes:
> > - Updates to MSP pinctrl entry for ALSA SoC
> > - ABx500 pinctrl tables
> > 
> > ----------------------------------------------------------------
> > Fabio Baltieri (1):
> >       ARM: ux500: update MSP1 pinctrl defintions
> > 
> > Patrice Chotard (1):
> >       ARM: ux500: add ABx500 pinctrl tables
> > 
> >  arch/arm/mach-ux500/board-mop500-pins.c | 279 ++++++++++++++++++++++++++++++--
> >  1 file changed, 268 insertions(+), 11 deletions(-)
> 
> Pulled.

Hmm. u8500_defconfig:

arch/arm/mach-ux500/board-mop500-pins.c:51:6: warning: 'slpm_in_nopull_wkup' defined but not used [-Wunused-variable]
arch/arm/mach-ux500/board-mop500-pins.c:63:6: warning: 'slpm_out_lo_wkup' defined but not used [-Wunused-variable]


I've checked in the following on top:


>From e1e16a4e7696add0c444a1f8766f6269d219a72b Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Fri, 14 Jun 2013 17:15:12 -0700
Subject: [PATCH] ARM: ux500: board-mop500: remove unused pin modes

Removes the following warnings:

arch/arm/mach-ux500/board-mop500-pins.c:51:6: warning: 'slpm_in_nopull_wkup' defined but not used [-Wunused-variable]
arch/arm/mach-ux500/board-mop500-pins.c:63:6: warning: 'slpm_out_lo_wkup' defined but not used [-Wunused-variable]

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linux.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 6086062..7936d40 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -48,8 +48,6 @@ BIAS(gpio_in_pd_slpm_gpio_nopull, PIN_INPUT_PULLDOWN|PIN_GPIOMODE_ENABLED|PIN_SL
 BIAS(gpio_out_hi, PIN_OUTPUT_HIGH|PIN_GPIOMODE_ENABLED);
 BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
 /* Sleep modes */
-BIAS(slpm_in_nopull_wkup, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_DIR_INPUT|PIN_SLPM_PULL_NONE|PIN_SLPM_WAKEUP_ENABLE);
 BIAS(slpm_in_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_in_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|
@@ -60,8 +58,6 @@ BIAS(slpm_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
 BIAS(slpm_out_lo_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_DISABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_out_lo_wkup, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_ENABLE);
 BIAS(slpm_out_lo_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_out_hi_wkup_pdis, PIN_SLEEPMODE_ENABLED|PIN_SLPM_OUTPUT_HIGH|
-- 
1.8.1.192.gc4361b8
