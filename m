From: jingoohan1@gmail.com (Jingoo Han)
Date: Mon, 17 Jul 2017 15:28:13 -0400
Subject: [PATCH 1/3] PCI: dwc: Handle host_init failures
In-Reply-To: <73b9c442-38f6-cc5b-c6e0-4ce7187dc0a8@synopsys.com>
References: <20170716063947.3272-1-bjorn.andersson@linaro.org>
 <73b9c442-38f6-cc5b-c6e0-4ce7187dc0a8@synopsys.com>
Message-ID: <000a01d2ff32$d5d59e00$8180da00$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 17, 2017 7:18 AM, Joao Pinto wrote:
> 
> Hi Bjorn Andersson,
> 
> ?s 7:39 AM de 7/16/2017, Bjorn Andersson escreveu:
> > In several dwc based drivers host_init can fail, so make sure to
> > propagate and handle this to avoid continuing operation of a driver or
> > hardware in an invalid state.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/pci/dwc/pci-dra7xx.c           |  4 +++-
> >  drivers/pci/dwc/pci-exynos.c           |  4 +++-
> >  drivers/pci/dwc/pci-imx6.c             |  4 +++-
> >  drivers/pci/dwc/pci-keystone.c         |  4 +++-
> >  drivers/pci/dwc/pci-layerscape.c       | 14 ++++++++++----
> >  drivers/pci/dwc/pcie-armada8k.c        |  4 +++-
> >  drivers/pci/dwc/pcie-artpec6.c         |  4 +++-
> >  drivers/pci/dwc/pcie-designware-host.c |  7 +++++--
> >  drivers/pci/dwc/pcie-designware-plat.c |  4 +++-
> >  drivers/pci/dwc/pcie-designware.h      |  2 +-
> >  drivers/pci/dwc/pcie-kirin.c           |  4 +++-
> >  drivers/pci/dwc/pcie-qcom.c            |  6 ++++--
> >  drivers/pci/dwc/pcie-spear13xx.c       |  4 +++-
> >  13 files changed, 47 insertions(+), 18 deletions(-)
> >

[.....]

> 
> A step in the right direction :). In the future we should add host init
> validation in the specific SoC drivers, like Layerscape and Qcom have, to
> assure
> that any problem is treated properly in the core driver.

I agree with your opinion.

> 
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
