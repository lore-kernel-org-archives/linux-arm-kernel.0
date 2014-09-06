From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat,  6 Sep 2014 10:26:27 +0900
Subject: [PATCH v3 0/3] clocksource: Document Renesas SoC specific bindings
Message-ID: <1409966790-17683-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
a number of drivers for Renesas hardware. The purpose of this patch is to
update the Renesas clocksource drivers to follow this convention.

I plan to follow up with patches to use these new bindings in the
dtsi files for the affected SoCs.

Changes between v1 and v2:

* Addressed feedback from Sergei Shtylyov, Geert Uytterhoeven and
  Mark Rutland: corrected editing errors and generally made
  things clearer.

* Addressed feedback from Laruent Pinchart to
  - remove fallback loop for renesas,cmt-48-gen2
  - Use consistent case for SoC names
  - Document fallback for MTU2 and TMU

Simon Horman (3):
  clocksource: sh_cmt: Document SoC specific bindings
  clocksource: sh_mtu2: Document r7s72100 binding
  clocksource: sh_tmu: Document r8a7779 binding

 .../devicetree/bindings/timer/renesas,cmt.txt      | 44 +++++++++++++++++++---
 .../devicetree/bindings/timer/renesas,mtu2.txt     |  7 +++-
 .../devicetree/bindings/timer/renesas,tmu.txt      |  7 +++-
 3 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.0.1
