From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Sep 2014 10:22:36 +0200
Subject: [PATCH v2 2/2] PCI: keystone: update to support multiple pci ports
In-Reply-To: <540F8425.70304@ti.com>
References: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
 <3967092.l9bxcqMaSa@wuerfel> <540F8425.70304@ti.com>
Message-ID: <3814561.AbrslYBNjb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 18:50:13 Murali Karicheri wrote:
> My mistake. It is the device ID, not vendor ID. The PCI driver supports 
> PCI h/w on K2HK, K2E and K2L SoCs for which PCI device IDs are assigned as
> 
> +#define PCIE_RC_K2HK           0xb008
> +#define PCIE_RC_K2E            0xb009
> +#define PCIE_RC_K2L            0xb00a
> +
> 
> and the same driver code runs on all these h/w. The device ID is not 
> filled in by default by the h/w, in the config space of the RC at offset 
> 1000h "VENDOR_DEVICE_ID Vendor and Device Identification Register". 
> Same is available in a seperate SoC register whose offset is specified 
> by index 2. This is read by driver and updated in the config space. The 
> Vendor ID is however set by default.
> 
> There is a mrrs PCI quirk required for Keystone PCI which depends on 
> this vendor ID to be filled correctly as it match vendor id/ device id 
> of the bridge device to apply the quirk.
> 
> Hope this clarify your question.

Ok, I understand now. Yes, this makes sense, though I wonder if it would
have been easier to handle the quirk in a different way based on the
driver rather than the PCI ID. It's probably not worth revisiting though,
unless Bjorn wants to see it done differently now.

	Arnd
