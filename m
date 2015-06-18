From: raghumag@gmail.com (raghu MG)
Date: Fri, 19 Jun 2015 00:52:38 +0530
Subject: Marvell PCI enumeration & separating BAR0 & BAR2 allocation to
 different IO-RANGE
Message-ID: <CAG1O52WuDPz7M2Mf78msqJGXPtaMHNTHieRtXZTcWSdNep339g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I have MV78460 based board with Marvell LION2 device connected to
8-ports of  PCIe.
LION2 consists of 8 PCIe device.
MV78460  PCIe -->8-devices of LION2 are mapped as given here
pcie,0.0
pcie0.1
pcie 0.2
pcie 0.3
pcie 1.0
pcie 1.1
pcie 2.0
pcie 3.0

I am running linux-4.0.4 with modified device tree.

The issue here is each of the PCIe device requires 64MB BAR2 & 1MB
BAR0 MMIO space.
Due to alignment criteria during the bootup the PCIe layer aligns it to 128MB
 8x128MB =1GB of MMIO space .

Also Marvell needs 256MB for other Internal Register & also for other I/Os

Though the 8-devices require just 512MB+8MB+256MB MMIO space because
of alignment MMIO space required is more than 1GB.

Board has 8GB RAM but due to MMIO only 6GB RAM is addressable because
MMIO requires 2GB IO space.

I would like to fix this issue by separting BAR0 1MB assignment @
0xF0000000 +1MB for each device
And BAR2 64MB assigment starting at 0xD0000000 +64MB for each device.

How can I disable sequential resource allocation to BAR0 & BAR2  and
separate BAR0 assignment  at F1000000 & BAR2 0xD0000000

Any help to resolve this issue would be great
