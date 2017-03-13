From: gvrose8192@gmail.com (Greg)
Date: Mon, 13 Mar 2017 04:08:03 -0700
Subject: Legacy features in PCI Express devices
In-Reply-To: <ef5c9778-fbae-9f4f-ac2e-29b8597537a5@free.fr>
References: <ef5c9778-fbae-9f4f-ac2e-29b8597537a5@free.fr>
Message-ID: <1489403283.21692.1.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-03-13 at 17:10 +0100, Mason wrote:
> Hello,
> 
> There are two revisions of our PCI Express controller.
> 
> Rev 1 did not support the following features:
> 
>   1) legacy PCI interrupt delivery (INTx signals)

I'm not sure about this...

>   2) I/O address space

But yes, definitely some support this.

We're working on a new type of network controller that uses I/O for some
types of low latency feature support.

- Greg

> 
> Internally, someone stated that such missing support would prevent
> some PCIe cards from working with our controller.
> 
> Are there really modern PCIe cards that require 1) and/or 2)
> to function?
> 
> Can someone provide examples of such cards, so that I may test them
> on both revisions?
> 
> I was told to check ath9k-based cards. Any other examples?
> 
> Looking around, I came across this thread:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/418254.html
> "i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity"
> 
> IIUC, although some PCIe boards do support MSI, the driver might not
> put in the work to use that infrastructure, and instead reverts to
> legacy interrupts. (So it is a SW issue, in a sense.)
> 
> Regards.
