From: xiakaixu@huawei.com (Kaixu Xia)
Date: Thu, 15 Jan 2015 17:49:45 +0800
Subject: [PATCH] coresight: fix the debug AMBA bus name
Message-ID: <1421315385-79209-1-git-send-email-xiakaixu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The right debug AMBA bus name should be APB(Advanced Peripheral Bus),
so just fix it.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
---
 Documentation/trace/coresight.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index bba7dbf..0236155 100644
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
1.8.5.5
