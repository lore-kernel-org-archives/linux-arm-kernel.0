From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 29 Oct 2013 13:14:39 -0600
Subject: [PATCH 0/6] PCI: imx6: Random fixes
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Message-ID: <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 10:06 AM, Marek Vasut <marex@denx.de> wrote:
> Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
> setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as expected.
>
> NOTE: I'm sure this will start some discussion. There are quite a few patches
>       that are more of a hacks. Shawn, I didn't ignore your remark about the
>       clock patches, I will test it ASAP, I just want to have these fixes in
>       the public so others can comment/test.
>
> Marek Vasut (6):
>   PCI: imx6: Make reset-gpio optional
>   PCI: imx6: Fix the clock for PCIe
>   ARM: dts: imx6qdl: Fix the clock for PCIe
>   PCI: imx6: Probe the PCIe in fs_initcall()
>   PCI: imx6: Force Gen1 operation
>   PCI: designware: Fix DT resource retrieval
>
>  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  4 +-
>  drivers/pci/host/pci-imx6.c                        | 63 ++++++++++++++++------
>  drivers/pci/host/pcie-designware.c                 | 17 +++---
>  4 files changed, 55 insertions(+), 31 deletions(-)

I'm ignoring this series for now.  I assume you'll post an updated
series as mentioned in your Oct 17 response to "[Patch 5/6] PCI: imx6:
Force Gen1 operation."  Please mark that series as "v2" when you post
it.  My assumption is still that Shawn Guo will ack the
drivers/pci/host/ pieces before I apply them [1].

Bjorn

[1] http://marc.info/?l=linux-pci&m=138030833011687&w=2
