From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:21 -0700
Subject: [PATCH 5/9] coresight: fix the debug AMBA bus name
In-Reply-To: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422289345-2084-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

The right debug AMBA bus name should be APB(Advanced Peripheral Bus),
so just fix it.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index bba7dbfc49ed..02361552a3ea 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -46,7 +46,7 @@ At typical coresight system would look like this:
   | |   .        | !   | |   .        | !      | !        .   |      | SWD/
   | |   .        | !   | |   .        | !      | !        .   |      | JTAG
   *****************************************************************<-|
- *************************** AMBA Debug ABP ************************
+ *************************** AMBA Debug APB ************************
   *****************************************************************
    |    .          !         .          !        !        .    |
    |    .          *         .          *        *        .    |
@@ -79,7 +79,7 @@ At typical coresight system would look like this:
           To trace port                       TPIU= Trace Port Interface Unit
                                               SWD = Serial Wire Debug
 
-While on target configuration of the components is done via the ABP bus,
+While on target configuration of the components is done via the APB bus,
 all trace data are carried out-of-band on the ATB bus.  The CTM provides
 a way to aggregate and distribute signals between CoreSight components.
 
-- 
1.9.1
