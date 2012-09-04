From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  4 Sep 2012 13:17:33 -0700
Subject: [PATCH] ARM: msm: Fix sparse warnings due to incorrect type
Message-ID: <1346789853-824-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-msm/timer.c:153:3: warning: incorrect type in initializer (different address spaces)
arch/arm/mach-msm/timer.c:153:3:    expected void const [noderef] <asn:3>*__vpp_verify
arch/arm/mach-msm/timer.c:153:3:    got struct clock_event_device [noderef] <asn:3>**<noident>
arch/arm/mach-msm/timer.c:153:38: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-msm/timer.c:153:38:    expected struct clock_event_device [noderef] <asn:3>*<noident>
arch/arm/mach-msm/timer.c:153:38:    got struct clock_event_device *evt
arch/arm/mach-msm/timer.c:191:22: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-msm/timer.c:191:22:    expected struct clock_event_device [noderef] <asn:3>**static [toplevel] percpu_evt
arch/arm/mach-msm/timer.c:191:22:    got struct clock_event_device *[noderef] <asn:3>*<noident>
arch/arm/mach-msm/timer.c:196:4: warning: incorrect type in initializer (different address spaces)
arch/arm/mach-msm/timer.c:196:4:    expected void const [noderef] <asn:3>*__vpp_verify
arch/arm/mach-msm/timer.c:196:4:    got struct clock_event_device [noderef] <asn:3>**<noident>
arch/arm/mach-msm/timer.c:196:39: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-msm/timer.c:196:39:    expected struct clock_event_device [noderef] <asn:3>*<noident>
arch/arm/mach-msm/timer.c:196:39:    got struct clock_event_device *ce
arch/arm/mach-msm/timer.c:198:24: warning: incorrect type in argument 4 (different address spaces)
arch/arm/mach-msm/timer.c:198:24:    expected void [noderef] <asn:3>*percpu_dev_id
arch/arm/mach-msm/timer.c:198:24:    got struct clock_event_device [noderef] <asn:3>**static [toplevel] percpu_evt

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 81280825..004f935 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -101,7 +101,7 @@ static struct clock_event_device msm_clockevent = {
 
 static union {
 	struct clock_event_device *evt;
-	struct clock_event_device __percpu **percpu_evt;
+	struct clock_event_device * __percpu *percpu_evt;
 } msm_evt;
 
 static void __iomem *source_base;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, hosted by The Linux Foundation
