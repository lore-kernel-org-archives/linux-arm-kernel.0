From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 11:05:01 +0200
Subject: [PATCH v3 02/10] devicetree: Add generic IOMMU device tree
 bindings
In-Reply-To: <9ffe3c3871ef4b60a955259bfa0bed6c@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-3-git-send-email-thierry.reding@gmail.com>
 <9ffe3c3871ef4b60a955259bfa0bed6c@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <9506037.pCJq3zRKJU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 06:42:48 Varun Sethi wrote:
> Master node corresponds to the device node, right? Master ID would correspond
> to Stream ID? We are already using "iommu-parent" property to link a device
> to its corresponding IOMMU. We can use the same property instead of using "iommus".

I don't see "iommu-parent" used anywhere, just "fsl,iommu-parent". We can
probably allow "fsl,iommu-parent" as an alias for "iommus" for backwards-
compatibility if that helps you on PowerPC. For ARM, I'd prefer to mandate
that we use just "iommus".

	Arnd
