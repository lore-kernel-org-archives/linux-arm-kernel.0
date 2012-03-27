From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:19 +0800
Subject: [PATCH 00/10] clk: cleanup on basic clks
Message-ID: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series makes some cleanup on basic clks.  Two patches from Mark
are folded here as they are doing the same thing.

Regards,
Shawn

---
Mark Brown (2):
      clk: fixed-rate: Don't open code kstrdup()
      clk: Constify parent name arrays

Shawn Guo (8):
      clk: use kzalloc in clk_register_mux
      clk: remove unnecessary EXPORT_SYMBOL_GPL
      clk: add "const" for clk_ops of basic clks
      clk: declare clk_ops of basic clks in clk-provider.h
      clk: align error return of basic clks registeration
      clk: fixed-rate: registration error handling fixup
      clk: dynamically allocate parent_names basic clk registration
      clk: copy parent_names in clk-mux registration

 drivers/clk/clk-divider.c    |   19 +++++++++++--------
 drivers/clk/clk-fixed-rate.c |   33 +++++++++++++++++----------------
 drivers/clk/clk-gate.c       |   20 ++++++++++++--------
 drivers/clk/clk-mux.c        |   39 +++++++++++++++++++++++++++++++--------
 drivers/clk/clk.c            |    2 +-
 include/linux/clk-private.h  |   10 +---------
 include/linux/clk-provider.h |   10 ++++++----
 7 files changed, 79 insertions(+), 54 deletions(-)
