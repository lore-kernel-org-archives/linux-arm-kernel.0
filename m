From: matt@console-pimps.org (Matt Fleming)
Date: Mon,  4 Oct 2010 21:44:25 +0100
Subject: [PATCH 7/7] sh: Annotate oprofile_arch_exit() with __exit marker
In-Reply-To: <cover.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
Message-ID: <4426d17460dc88dcb3d6e3af1b91af4db83785ae.1286222593.git.matt@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch we need to annotate
oprofile_arch_exit() with an __exit marker.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/oprofile/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
index 449f842..93033d8 100644
--- a/arch/sh/oprofile/common.c
+++ b/arch/sh/oprofile/common.c
@@ -29,7 +29,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	return oprofile_perf_init(ops);
 }
 
-void oprofile_arch_exit(void)
+void __exit oprofile_arch_exit(void)
 {
 	oprofile_perf_exit();
 }
-- 
1.7.1
