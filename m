From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Dec 2013 20:39:45 +0000
Subject: [PATCH 1/5] arm64: Fix __data_loc value
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <35a937043d1b3eae1b1ea547efc25f75b5f43f67.1386879684.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __data_loc variable should be set to the VMA of the data section, not
the LMA.

At present LOAD_OFFSET is not set and defaults to zero, so this bug
does not cause any problems.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5161ad9..3072c41 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -99,7 +99,7 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	_data = .;
-	__data_loc = _data - LOAD_OFFSET;
+	__data_loc = _data;
 	_sdata = .;
 	RW_DATA_SECTION(64, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
-- 
1.8.1.2
