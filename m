From: gengdj.1984@gmail.com (gengdongjiu)
Date: Sat, 17 Nov 2018 23:41:29 +0800
Subject: Resend: How to handle the SMMU RAS Error in the kernel
Message-ID: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi robin/will/James


In the current kernel, it only handles three kinds of error, which is
memory error, PCIE device and ARM process. But now the SMMU already
support the RAS, how to handle the SMMU RAS error in the kernel?

I check the UEFI_SPEC_2.7, the ACPI's CPER have the IOMMU type, but it
seems the IOMMU type only are specific to AMD?s IOMMU specification,
not have the ARM?s IOMMU section type, can we reuse this IOMMU section
type for the ARM SMMU?



N.2.11.3 IOMMU specific DMAr Error Section

Type: {0x036F84E1, 0x7F37, 0x428c, {0xA7, 0x9E, 0x57, 0x5F, 0xDF,
0xAA, 0x84, 0xEC}}

All fields in this error record are specific to AMD?s IOMMU
specification. This error section has a fixed size.
