From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Jan 2013 15:29:59 +0900
Subject: [RFC v9 0/8] ARM: shmobile: DT initialisation of INTC
Message-ID: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aims of this series are:

* Add DT bindings to to INTC
* Allowing sh7372 and r8a7740 ARM shmobile SoCs to use DT
  to initialise INTCA

Changes since v8
* Address review of bindings by Mark Rutland

Change between v7 and v8
* Squash the first and second patch of the series and rename there result
  "SH: intc: Add support OF for INTC"

Changes between v5 and v7 (v6 was not publicly released)
* Drop support for sh73a0 SoC.
  To be useful this requires a fuller initialisation than jsut INCA.
  In particular, cascade IRQs that are shared between INTC and GIC
  need to be handled.
* Drop board support
  This will be revisited on a per-board basis, ideally with
  filler INTC initialisation via DT in place
* Drop GIC initialisation
  This will also be revisited on a per-board basis.
* Remove unused INTC DT helper functions

Status:

I am reasonably happy with this series and plan to merge the patch set.
