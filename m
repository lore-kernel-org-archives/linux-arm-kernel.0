From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 30 Aug 2018 13:41:14 +0200
Subject: [PATCH v6 09/11] arm64: update Documentation/arm64/tagged-pointers.txt
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
Message-ID: <594756b2aa9fea948f4da3cd01ffa8a5acbc5805.1535629099.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a note that work on passing tagged user pointers to the kernel via
syscalls has started, but might not be complete yet.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..361481283f00 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -35,8 +35,9 @@ Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
 of failure.
 
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
+Some initial work for supporting non-zero address tags passed to the
+kernel via system calls has been done, but the kernel doesn't provide
+any guarantees at this point. Using a non-zero address tag for sp is
 strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog
