From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 21 Jul 2014 15:47:15 +0100
Subject: [PATCH RFC 4/9] ARM: dump the status of NS bit in L1 PTE
In-Reply-To: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1405954040-30399-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marex@denx.de>

Add minor adjustment to the page table dumper to also print the status
of the L1 PTE NS bit.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/mm/dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index c508f41..0100edb 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -176,6 +176,11 @@ static const struct prot_bits section_bits[] = {
 		.val	= PMD_SECT_S,
 		.set	= "SHD",
 		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_NS,
+		.val	= PMD_SECT_NS,
+		.set	= "NS ",
+		.clear	= "ns ",
 	},
 };
 
-- 
1.9.3
