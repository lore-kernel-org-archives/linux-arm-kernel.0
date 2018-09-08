From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sun,  9 Sep 2018 01:57:02 +0530
Subject: [PATCH 1/6] dt-bindings: ramoops: Add event-size property
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <4ec22906649fb3f6ab9570d8d4bf214e61512664.1536430404.git.saiprakash.ranjan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional property called event-size to reserve
log buffer for trace events.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../devicetree/bindings/reserved-memory/ramoops.txt        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
index 0eba562fe5c6..4f835ef65635 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
@@ -14,8 +14,8 @@ Any remaining space will be used for a circular buffer of oops and panic
 records.  These records have a configurable size, with a size of 0 indicating
 that they should be disabled.
 
-At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
-must be set non-zero, but are otherwise optional as listed below.
+At least one of "record-size", "console-size", "event-size", "ftrace-size", or
+"pmsg-size" must be set non-zero, but are otherwise optional as listed below.
 
 
 Required properties:
@@ -36,6 +36,9 @@ Optional properties:
 - console-size: size in bytes of log buffer reserved for kernel messages
   (defaults to 0: disabled)
 
+- event-size: size in bytes of log buffer reserved for trace events
+  (defaults to 0: disabled)
+
 - ftrace-size: size in bytes of log buffer reserved for function tracing and
   profiling (defaults to 0: disabled)
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
