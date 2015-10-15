From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 15 Oct 2015 15:48:23 -0400
Subject: [PATCH v3 0/10] clk: iproc: add support for BCM NS, NSP, and NS2 
Message-ID: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


v3 - Added a patch to fix cygnus clk link failures, and added back the
DT documentation patches that were removed from v2.

v2 - Added a patch to change the Cygnus clk macros to uppercase,
removed the device tree changes from the series (will send out those as
an RFC), and other minor changes that Stephen Boyd requested.

This patch series adds support for the Broadcom Northstar, Northstar
Plus, and Northstar 2 clocks.  Some slight modifications were necessary
to clk-iproc-pll to get Northstar and Northstar Plus working, due to
differences in register layout.  This is the reason why the first patch
is necessary.  Some more modifications were necessary to clk-iproc-pll
to get Northstar 2 working, due to differences in register layout (and
resulting fallout in Cygnus and NSP).  This is the reason why the sixth
and seventh patches are necessary.  The fifth patch is clean-up to
prevent accidentally forgetting to adjust for the base write errata
(which happened a few times, but was caught in internal review).

Thanks,
Jon
