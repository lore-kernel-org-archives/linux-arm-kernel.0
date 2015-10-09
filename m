From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 10:18:21 +0200
Subject: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <56177669.2000302@arm.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com>
 <8520D5D51A55D047800579B09414719801690CD0@XAP-PVEXMBX01.xlnx.xilinx.com>
 <56177669.2000302@arm.com>
Message-ID: <5676910.8cxuyuvhpA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 09:10:17 Marc Zyngier wrote:
> > Please let me know whether we require a separate msi file as
> > suggested in your previous comments to separate MSI controller and
> > PCIE controller in two files, if we don't have separate node. If we
> > do not need a separate node do we need to embed MSI controller child
> > node  in PCIe controller node itself, and what properties does this
> > child node will require other than 'interrupts'.
> 
> If you want to keep them in the same file, please at least have two
> separate patches. These are two different functions, and they should be
> reviewed separately.
> 
> It will help everyone to understand your code, and speed up the
> reviewing process.

Agreed. Also, the part we really want is to have the PCI controller
code decoupled enough from the MSI code that it will not require
further changes once Xilinx comes out with a chip that has a modern
GIC in it and the same PCIe host.

	Arnd
