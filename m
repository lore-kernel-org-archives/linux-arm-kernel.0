From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 21 Apr 2013 17:14:00 +0100
Subject: [PATCH] Kirkwood: Enable PCIe port 1 on QNAP TS-11x/TS-21x
In-Reply-To: <20130421154704.GV2824@lunn.ch>
References: <20130421152802.GA1408@jirafa.cyrius.com>
 <20130421154704.GV2824@lunn.ch>
Message-ID: <20130421161400.GD26943@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable KW_PCIE1 on QNAP TS-11x/TS-21x devices as newer revisions
(rev 1.3) have a USB 3.0 chip from Etron on PCIe port 1.  Thanks
to Marek Vasut for identifying this issue!

Cc: <stable@kernel.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Tested-by: Marek Vasut <marex@denx.de>

diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 283abff..e1267d6 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -124,7 +124,7 @@ static void __init qnap_ts219_init(void)
 static int __init ts219_pci_init(void)
 {
 	if (machine_is_ts219())
-		kirkwood_pcie_init(KW_PCIE0);
+		kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);
 
 	return 0;
 }

-- 
Martin Michlmayr
http://www.cyrius.com/
