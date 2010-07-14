From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 15:29:46 +0800
Subject: [PATCH 0/6] debug macro fixups, v2
Message-ID: <1279092586.619523.10182482328.0.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the DEBUG_LL mapping changes, I ran all of the defconfigs
with DEBUG_LL=y. Some of the configs are broken, so I'm posting the
fixups.

mx1 is still broken, as IMX_IO_ADDRESS() (used by the mx1 debug macros)
uses C syntax, and so it not suitable for asm.

Cheers,


Jeremy

v2:
 * rebased to remotes/rmk/master directly, without addruart changes

---
Jeremy Kerr (6):
      arm/clps711x: fix debug macro compilation failure
      arm/h720x: fix debug macro compilation failure
      arm/l7200: fix debug macro compilation failure
      arm/plat-spear: fix debug macro compilation failure
      arm/ns9xxx: fix debug macro compilation failure
      arm/shark: fix debug macro compilation failure
