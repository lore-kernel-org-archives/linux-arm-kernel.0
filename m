From: labbott@fedoraproject.org (Laura Abbott)
Date: Fri, 29 Jan 2016 15:46:58 -0800
Subject: [PATCHv2 3/3] arm64: ptdump: Indicate whether memory should be
 faulting
In-Reply-To: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
References: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1454111218-3461-4-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_DEBUG_PAGEALLOC, pages do not have the valid bit
set when free in the buddy allocator. Add an indiciation to
the page table dumping code that the valid bit is not set,
'F' for fault, to make this easier to understand.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
 arch/arm64/mm/dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 5a22a11..f381ac9 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -90,6 +90,11 @@ struct prot_bits {
 
 static const struct prot_bits pte_bits[] = {
 	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
 		.mask	= PTE_USER,
 		.val	= PTE_USER,
 		.set	= "USR",
-- 
2.5.0
