From: panand@redhat.com (Pratyush Anand)
Date: Fri,  7 Jul 2017 17:33:59 +0530
Subject: [PATCH V2 3/4] hw-breakpoint: sample test: set step_needed bit field
In-Reply-To: <cover.1499416107.git.panand@redhat.com>
References: <cover.1499416107.git.panand@redhat.com>
Message-ID: <a38616dbf74dd13b5e41396cb11014be45bd15ba.1499416107.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch like ARM64 expects 'step_needed == true'  in order to use default
single step handler. Therefore, set the bit field in the test case.
Other arch will not have any affect as they do not use it so far.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 samples/hw_breakpoint/data_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index ef7f32291852..5a1919d01800 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -59,6 +59,7 @@ static int __init hw_break_module_init(void)
 	attr.bp_addr = kallsyms_lookup_name(ksym_name);
 	attr.bp_len = HW_BREAKPOINT_LEN_4;
 	attr.bp_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
+	attr.step_needed = true;
 
 	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler, NULL);
 	if (IS_ERR((void __force *)sample_hbp)) {
-- 
2.9.3
