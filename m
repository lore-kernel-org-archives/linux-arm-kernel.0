From: srikanth.thokala@xilinx.com (Srikanth Thokala)
Date: Thu, 28 Nov 2013 12:59:57 +0530
Subject: [PATCH 2/2] net: emaclite: add barriers to support Xilinx Zynq
 platform
In-Reply-To: <1385623797-26034-1-git-send-email-sthokal@xilinx.com>
References: <1385623797-26034-1-git-send-email-sthokal@xilinx.com>
Message-ID: <9045da6f-88e5-4a20-be68-477790588131@TX2EHSMHS023.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds barriers at appropriate places to ensure the driver
works on Xilinx Zynq ARM-based SoC platform.

Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 3a693a1..31b8b6c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -220,6 +220,7 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 		to_u16_ptr = (u16 *)&align_buffer;
 		*to_u16_ptr++ = *from_u16_ptr++;
 		*to_u16_ptr++ = *from_u16_ptr++;
+		wmb();
 
 		/* Output a word */
 		*to_u32_ptr++ = align_buffer;
@@ -236,6 +237,7 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 		for (; length > 0; length--)
 			*to_u8_ptr++ = *from_u8_ptr++;
 
+		wmb();
 		*to_u32_ptr = align_buffer;
 	}
 }
-- 
1.8.2.GIT
