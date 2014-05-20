From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 20 May 2014 11:22:22 -0600
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on designware
 core driver
In-Reply-To: <20140520170221.GA5130@obsidianresearch.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <6048322.x3M3sdDEWO@wuerfel> <5374FD24.8000806@ti.com>
 <22200719.Jb5jnJylJH@wuerfel>
 <20140515183919.GC11650@obsidianresearch.com> <53751DDF.40304@ti.com>
 <20140515205210.GB14722@obsidianresearch.com>
 <3E54258959B69E4282D79E01AB1F32B704742133@DFLE11.ent.ti.com>
 <20140520170221.GA5130@obsidianresearch.com>
Message-ID: <CAErSpo667uWybiHOh4tVQDh_JFpF0EbvxKwo_GQm+B1-wMtT1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:02 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, May 16, 2014 at 08:29:56PM +0000, Karicheri, Muralidharan wrote:
>
>> But pcie_bus_configure_settings just make sure the mrrs for a device
>> is not greater than the max payload size.
>
> Not quite, it first scans the network checking the Maximum Payload Size
> Supported (MPSS) for each device, and chooses the highest supported by
> all as the MPS for all.

The "performance" setting, e.g., "pci=pcie_bus_perf", adds a few
wrinkles by setting MRRS in ways that allow some devices to have
larger MPS than others.  I don't think this is exactly what was
envisioned in the spec, and it is not guaranteed to work if there is
peer-to-peer DMA.  This isn't documented very well; the best I know of
is the changelogs for:

  a1c473aa11e6 pci: Clamp pcie_set_readrq() when using "performance" settings
  b03e7495a862 PCI: Set PCI-E Max Payload Size on fabric

Bjorn
