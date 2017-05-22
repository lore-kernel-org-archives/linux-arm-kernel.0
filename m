From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 22 May 2017 16:01:51 +0300
Subject: [PATCHv4 0/2] clk: keystone: add sci-clk support
Message-ID: <1495458113-7366-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This revision is a rebase on top of 4.12-rc1, with following changes:

1) Dropped the usage of dt-bindings include genpd/k2g.h as this is
   apparently going to be removed
2) Dropped the dt-bindings include file for the clock identifiers
   based on item [1]. The identifiers are only used once for anything
   within the driver, and it is more readable this way also. The DT
   users should use magic numbers for accessing the clocks, relative
   to what is done for example for IP addresses etc.
3) Fixed the node name for the clocks in patch #1
4) Init time failure fixes in patch #2
5) Some other minor fixes for comments provided for v3 of the patch #2

Boot tested with some additional patches on top on keystone-k2g.

(Bootable reference branch, NOT FOR MERGE:
 https://github.com/t-kristo/linux-pm/tree/4.12-rc1-ti-sci-v4c-integ)

-Tero
