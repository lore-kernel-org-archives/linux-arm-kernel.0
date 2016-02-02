From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 2 Feb 2016 15:34:47 +0800
Subject: [PATCH 3/3] ARM: dts: imx6*-hummingboard: fix pcie reset GPIO
 specification
In-Reply-To: <CAOMZO5Ciq-kq4xQm4TH+dF3cdYxFfWUmvuykvorZ-oaEoyBWFQ@mail.gmail.com>
References: <E1aOWdF-00058a-0X@rmk-PC.arm.linux.org.uk>
 <CAOMZO5Ciq-kq4xQm4TH+dF3cdYxFfWUmvuykvorZ-oaEoyBWFQ@mail.gmail.com>
Message-ID: <20160202073446.GJ8307@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 07:07:38PM -0200, Fabio Estevam wrote:
> On Wed, Jan 27, 2016 at 6:24 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > PCIe reset signals are active low, and our GPIO for this is directly
> > connected to the PCIe reset.  However, as the PCIe driver does not use
> > the flag, the specification of '0' flags (which means active high) has
> > not been noticed.  Correct this oversight, and switch to using the
> 
> Yes, the mx6 pci driver did not use the flag, but it does now since 5c5fb40de8f1
> ("PCI: imx6: Add support for active-low reset GPIO"), so it would be
> better to adjust the commit log.

I updated the commit log a bit and applied the series.

Shawn
