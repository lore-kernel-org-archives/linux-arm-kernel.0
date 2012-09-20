From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:19:48 +0200
Subject: [PATCH 6/10] IXP4xx: Remove time limit for PCI TRDY to enable use of
 slow devices.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3haqs30rf.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -410,6 +410,7 @@ void __init ixp4xx_pci_preinit(void)
 		 * Enable the IO window to be way up high, at 0xfffffc00
 		 */
 		local_write_config(PCI_BASE_ADDRESS_5, 4, 0xfffffc01);
+		local_write_config(0x40, 4, 0x000080FF); /* No TRDY time limit */
 	} else {
 		printk("PCI: IXP4xx is target - No bus scan performed\n");
 	}

-- 
Krzysztof Halasa
