From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Mar 2012 21:33:59 +0100
Subject: [PATCH] clk: Fix compile errors in DEFINE_CLK_GATE
In-Reply-To: <1330763341-3437-5-git-send-email-mturquette@linaro.org>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-5-git-send-email-mturquette@linaro.org>
Message-ID: <20120304203359.GE11546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 71e9a676b2b2f0dc2bb0cc395e8325cf38f4808b Mon Sep 17 00:00:00 2001
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 4 Mar 2012 16:31:14 +0100
Subject: [PATCH] [clk] Fix compile errors in DEFINE_CLK_GATE()

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/clk-private.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index d06e6fb..9d5c4b1 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -95,7 +95,7 @@ extern struct clk_ops clk_gate_ops;
 		},						\
 		.reg = _reg,					\
 		.bit_idx = _bit_idx,				\
-		.flags = _gate_flags				\
+		.flags = _gate_flags,				\
 		.lock = _lock,					\
 	};							\
 	static struct clk _name = {				\
@@ -104,7 +104,7 @@ extern struct clk_ops clk_gate_ops;
 		.hw = &_name##_hw.hw,				\
 		.parent_names = _name##_parent_names,		\
 		.num_parents =					\
-			ARRAY_SIZE(_name##parent_names),	\
+			ARRAY_SIZE(_name##_parent_names),	\
 		.parents = _name##_parents,			\
 		.flags = _flags,				\
 	};
-- 
1.7.2.5
