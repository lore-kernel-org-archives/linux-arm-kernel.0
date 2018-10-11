From: adam.cottrel@veea.com (Adam Cottrel)
Date: Thu, 11 Oct 2018 07:28:37 +0000
Subject: DMA remote memcpy requests
Message-ID: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using the ATH10K on Linux 14.4 with an Arm Cavium processor. During heavy loading, I am seeing that target initiated DMA requests are being silently dropped under extreme IO memory pressure and it is proving very difficult to isolate the root cause.

The ATH10K firmware uses the DMA API to set up phy_addr_t pointers (32-bit) which are then copied to a shared ring buffer. The target then initiates the memcpy operation (for target-to-host reads), but I do not have any means of debugging the target directly, and so I am looking for software hooks on the host that might help debug this complex problem.

Please can someone explain the low-level operation of DMA once it becomes a target initiated memcpy function?

Best,
Adam

p.s. I have tested with and without the IOMMU, and I have eliminated issues such as cache coherency being the root cause.
