From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 27 Sep 2013 13:24:26 -0600
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAErSpo4JhjW5a-74eJp5bajmAMKSn4Vxknk8NoVdD462N=Ncug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 9:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Bjorn,
>
> This is basically a resend of imx6 pcie driver patch for inclusion into
> PCI tree.  Since we expect you apply the patch with your SoB, I dropped
> your ACK tag there.
>
> I have to ask you to carry the first patch which adds some macros to be
> used by pcie driver patch.  Since imx6q-iomuxc-gpr.h gets rare updates
> recently, it should be less likely we will run into merge conflict on it.
>
> Changes since v6:
>
> * Drop arch bits from driver patch, and will handle arch bits through
>   arm-soc separately.
> * Use devm_clk_get() instead of clk_get().
> * Drop unnecessary (val != exp_val) check in pcie_phy_poll_ack() loop.
> * Rename function imx6_init() to imx6_pcie_init().
>
> Shawn
>
> Sean Cross (2):
>   ARM: imx6q: Add PCIe bits to GPR syscon definition
>   PCI: imx6: Add support for i.MX6 PCIe controller
>
>  .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
>  drivers/pci/host/Kconfig                           |    6 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-imx6.c                        |  576 ++++++++++++++++++++
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    8 +
>  5 files changed, 597 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/host/pci-imx6.c

I merged both of these to my pci/host-imx6 branch for v3.13.

I made a couple minor spelling and whitespace corrections.

Bjorn
