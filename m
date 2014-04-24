From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 24 Apr 2014 11:58:44 -0600
Subject: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140424175844.GD29593@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 05:52:51PM +0100, Lucas Stach wrote:
> While working on MSI support for the i.MX6 PCIe host driver
> it has been discovered that the binding for this host controller
> is broken in many ways (refer to the patch descriptions for more
> info) and was introduced without proper discussion about what
> should/should not be in the binding.
> 
> This series fixes this and minimizes the difference of the
> i.MX6 binding to the common designware PCIe binding. I'm aware
> that this is a quite radical change, but I think it's justified
> to do this as long as there aren't many user of the old binding
> (most of the optional properties in the binding aren't even
> implemented).
> 
> Looking forward to your feedback.
> 
> Lucas Stach (8):
>   ARM: imx6q-clk: parent lvds_gate from lvds_sel
>   PCI: designware: split Exynos and i.MX bindings
>   ARM: dts: imx6: update pcie to bring in line with new binding
>   PCI: imx6: use new clock names
>   PCI: imx6: drop old irq mapping
>   PCI: imx6: rip out optional (and unused) irqs
>   PCI: designware: make MSI isr shared irq aware
>   PCI: imx6: add support for MSI

What's the status of all these?  I would normally apply patches 4-8 of this
series through my tree, given the appropriate acks, but I haven't seen
those yet.  And I'm not sure what dependencies there are between the
non-PCI patches and the PCI ones.

Bjorn
