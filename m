From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Sun,  6 Nov 2016 17:13:26 -0700
Subject: [PATCH 4/4] fpga mgr: socfpga: Expose support for encrypted bitstreams
In-Reply-To: <20161107001326.7395-1-moritz.fischer@ettus.com>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
Message-ID: <20161107001326.7395-5-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose support for on the fly decryption of bitstreams.
This needs no additional work or configuration,
so just expose the new capability.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Alan Tull <atull@opensource.altera.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---

Alan,

can you please let me know if that works this way, or where to find
information on encrypted bitstreams? I have a CycloneV SoCFPGA to test
on ...

Cheers,

Moritz
---
 drivers/fpga/socfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index fd9760c..ab57ec0c 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -579,6 +579,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 
 	fpga_mgr_cap_zero(&caps);
 	fpga_mgr_cap_set(FPGA_MGR_CAP_FULL_RECONF, caps);
+	fpga_mgr_cap_set(FPGA_MGR_CAP_DECRYPT, caps);
 
 	return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
 				 &socfpga_fpga_ops, caps, priv);
-- 
2.10.0
