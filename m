From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 14 Jan 2010 11:36:10 +0100
Subject: [PATCH 5/5] Add PKMAP area description to memory.txt.
In-Reply-To: <1263465370-4192-5-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-4-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-5-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1263465370-4192-6-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also adapts delimiters of neighbouring modules area.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 Documentation/arm/memory.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 9d58c7c..eb0fae1 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -59,7 +59,11 @@ PAGE_OFFSET	high_memory-1	Kernel direct-mapped RAM region.
 				This maps the platforms RAM, and typically
 				maps all platform RAM in a 1:1 relationship.
 
-TASK_SIZE	PAGE_OFFSET-1	Kernel module space
+PKMAP_BASE	PAGE_OFFSET-1	Permanent kernel mappings
+				One way of mapping HIGHMEM pages into kernel
+				space.
+
+MODULES_VADDR	MODULES_END-1	Kernel module space
 				Kernel modules inserted via insmod are
 				placed here using dynamic mappings.
 
-- 
1.6.6
