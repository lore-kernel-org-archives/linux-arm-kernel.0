From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:49 -0400
Subject: [PATCH/RFT 0/12] step towards removal of mach/system.h
Message-ID: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the spirit of eventually being able to boot a single zImage on multiple
SOCs, we need to get rid of mach/system.h.  This file mainly contains two
inline functions that should be out-of-line and assigned to the existing global
hooks at run time.  Those functions are arch_idle() and arch_reset().  The
following series only address the former.

This is a RFC and RFT patch series.  This was not compiled even less tested
yet, but I'm posting it now in the hope that people could help fixing/testing
this on the platform they have access to, or even improve upon this initial
draft patches.

The same thing needs to be done with arch_reset(), however there is no existing
global reset hook yet, only arm_pm_restart which may be used but implies a bit
more than arch_reset() does.

[PATCH 01/12] ARM: clean up idle handlers
[PATCH 02/12] ARM: mach-at91: move special idle code to a
[PATCH 03/12] ARM: mach-clps711x: move special idle code to a
[PATCH 04/12] ARM: mach-ebsa110: move special idle code to a
[PATCH 05/12] ARM: mach-gemini: move special idle code to a
[PATCH 06/12] ARM: mach-h720x: move special idle code to a
[PATCH 07/12] ARM: mach-ixp23xx: properly disable CPU idle call
[PATCH 08/12] ARM: mach-ixp4xx: properly disable CPU idle call
[PATCH 09/12] ARM: s3c24xx: move special idle code to a proper
[PATCH 10/12] ARM: mach-shark: properly disable CPU idle call
[PATCH 11/12] ARM: mach-w90x900: properly disable CPU idle call
[PATCH 12/12] ARM: imx: move special idle code to proper out-of-line
