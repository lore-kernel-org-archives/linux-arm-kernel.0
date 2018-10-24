From: dbasehore@chromium.org (Derek Basehore)
Date: Tue, 23 Oct 2018 18:31:31 -0700
Subject: [PATCH 5/6] docs: driver-api: add pre_rate_req to clk documentation
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
Message-ID: <20181024013132.115907-6-dbasehore@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation for the new clk op pre_rate_req.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/driver-api/clk.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 593cca5058b1..917f6ac29645 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -82,6 +82,9 @@ the operations defined in clk-provider.h::
 						unsigned long *parent_rate);
 		int		(*determine_rate)(struct clk_hw *hw,
 						  struct clk_rate_request *req);
+		int		(*pre_rate_req)(struct clk_hw *hw,
+						const struct clk_rate_request *next,
+						struct clk_rate_request *pre);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw,
@@ -224,6 +227,8 @@ optional or must be evaluated on a case-by-case basis.
    +----------------+------+-------------+---------------+-------------+------+
    |.determine_rate |      | y [1]_      |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
+   |.pre_rate_req   |      | y [1]_      |               |             |      |
+   +----------------+------+-------------+---------------+-------------+------+
    |.set_rate       |      | y           |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
    +----------------+------+-------------+---------------+-------------+------+
@@ -238,7 +243,7 @@ optional or must be evaluated on a case-by-case basis.
    |.init           |      |             |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
 
-.. [1] either one of round_rate or determine_rate is required.
+.. [1] one of round_rate, determine_rate, or pre_rate_req is required.
 
 Finally, register your clock at run-time with a hardware-specific
 registration function.  This function simply populates struct clk_foo's
-- 
2.19.1.568.g152ad8e336-goog
