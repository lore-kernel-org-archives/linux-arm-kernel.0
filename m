From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:30:24 +0000
Subject: [PATCH 01/48] ARM: PL08x: fix spelling errors
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsv2-0001Nr-86@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct mis-spellings in comments and printk strings.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b605cc9..3da49ed 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -19,7 +19,7 @@
  * this program; if not, write to the Free Software Foundation, Inc., 59
  * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  *
- * The full GNU General Public License is iin this distribution in the
+ * The full GNU General Public License is in this distribution in the
  * file called COPYING.
  *
  * Documentation: ARM DDI 0196G == PL080
@@ -82,7 +82,7 @@
 
 /**
  * struct vendor_data - vendor-specific config parameters
- * for PL08x derivates
+ * for PL08x derivatives
  * @name: the name of this specific variant
  * @channels: the number of channels available in this variant
  * @dualmaster: whether this version supports dual AHB masters
@@ -96,10 +96,8 @@ struct vendor_data {
 
 /*
  * PL08X private data structures
- * An LLI struct - see pl08x TRM
- * Note that next uses bit[0] as a bus bit,
- * start & end do not - their bus bit info
- * is in cctl
+ * An LLI struct - see PL08x TRM.  Note that next uses bit[0] as a bus bit,
+ * start & end do not - their bus bit info is in cctl.
  */
 struct lli {
 	dma_addr_t src;
@@ -152,7 +150,7 @@ struct pl08x_driver_data {
 /* Size (bytes) of each LLI buffer allocated for one transfer */
 # define PL08X_LLI_TSFR_SIZE	0x2000
 
-/* Maximimum times we call dma_pool_alloc on this pool without freeing */
+/* Maximum times we call dma_pool_alloc on this pool without freeing */
 #define PL08X_MAX_ALLOCS	0x40
 #define MAX_NUM_TSFR_LLIS	(PL08X_LLI_TSFR_SIZE/sizeof(struct lli))
 #define PL08X_ALIGN		8
@@ -177,7 +175,7 @@ static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
 
 /*
  * Set the initial DMA register values i.e. those for the first LLI
- * The next lli pointer and the configuration interrupt bit have
+ * The next LLI pointer and the configuration interrupt bit have
  * been set when the LLIs were constructed
  */
 static void pl08x_set_cregs(struct pl08x_driver_data *pl08x,
@@ -366,8 +364,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 			while (clli) {
 				bytes += get_bytes_in_cctl(llis_va[i].cctl);
 				/*
-				 * A clli of 0x00000000 will terminate the
-				 * LLI list
+				 * A LLI pointer of 0 terminates the LLI list
 				 */
 				clli = llis_va[i].next;
 				i++;
@@ -469,7 +466,7 @@ static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
 {
 	u32 retbits = cctl;
 
-	/* Remove all src, dst and transfersize bits */
+	/* Remove all src, dst and transfer size bits */
 	retbits &= ~PL080_CONTROL_DWIDTH_MASK;
 	retbits &= ~PL080_CONTROL_SWIDTH_MASK;
 	retbits &= ~PL080_CONTROL_TRANSFER_SIZE_MASK;
@@ -701,7 +698,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 * Choose bus to align to
 	 * - prefers destination bus if both available
 	 * - if fixed address on one bus chooses other
-	 * - modifies cctl to choose an apropriate master
+	 * - modifies cctl to choose an appropriate master
 	 */
 	pl08x_choose_master_bus(&txd->srcbus, &txd->dstbus,
 				&mbus, &sbus, cctl);
@@ -775,7 +772,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				target_len = max_bytes_per_lli;
 
 			/*
-			 * Set bus lengths for incrementing busses
+			 * Set bus lengths for incrementing buses
 			 * to number of bytes which fill to next memory
 			 * boundary
 			 */
@@ -826,7 +823,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				/*
 				 * So now we know how many bytes to transfer
 				 * to get to the nearest boundary
-				 * The next lli will past the boundary
+				 * The next LLI will past the boundary
 				 * - however we may be working to a boundary
 				 *   on the slave bus
 				 *   We need to ensure the master stays aligned
@@ -884,7 +881,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						&& (remainder); j++) {
 					cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 					dev_vdbg(&pl08x->adev->dev,
-						"%s align with boundardy, single byte (remain %08x)\n",
+						"%s align with boundary, single byte (remain %08x)\n",
 						__func__, remainder);
 					num_llis =
 						pl08x_fill_lli_for_desc(pl08x,
@@ -907,7 +904,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		while (remainder) {
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			dev_vdbg(&pl08x->adev->dev,
-				"%s align with boundardy, single odd byte (remain %d)\n",
+				"%s align with boundary, single odd byte (remain %d)\n",
 				__func__, remainder);
 			num_llis = pl08x_fill_lli_for_desc(pl08x, txd, num_llis,
 					1, cctl, &remainder);
@@ -1367,8 +1364,8 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 		 * available to handle it whereas slave transfers may
 		 * have been denied due to platform channel muxing restrictions
 		 * and since there is no guarantee that this will ever be
-		 * resolved, and since the signal must be aquired AFTER
-		 * aquiring the physical channel, we will let them be NACK:ed
+		 * resolved, and since the signal must be acquired AFTER
+		 * acquiring the physical channel, we will let them be NACK:ed
 		 * with -EBUSY here. The drivers can alway retry the prep()
 		 * call if they are eager on doing this using DMA.
 		 */
@@ -1620,7 +1617,7 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 
 	val = readl(pl08x->base + PL080_CONFIG);
 	val &= ~(PL080_CONFIG_M2_BE | PL080_CONFIG_M1_BE | PL080_CONFIG_ENABLE);
-	/* We implictly clear bit 1 and that means little-endian mode */
+	/* We implicitly clear bit 1 and that means little-endian mode */
 	val |= PL080_CONFIG_ENABLE;
 	writel(val, pl08x->base + PL080_CONFIG);
 }
@@ -2160,7 +2157,7 @@ static int __init pl08x_init(void)
 	retval = amba_driver_register(&pl08x_amba_driver);
 	if (retval)
 		printk(KERN_WARNING DRIVER_NAME
-		       "failed to register as an amba device (%d)\n",
+		       "failed to register as an AMBA device (%d)\n",
 		       retval);
 	return retval;
 }
-- 
1.6.2.5
