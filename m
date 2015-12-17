From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 17 Dec 2015 15:15:25 -0600
Subject: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <5672B633.6030503@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
 <20151216215304.GB27791@localhost> <5672B633.6030503@linaro.org>
Message-ID: <20151217211525.GA4129@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 03:18:43PM +0200, Stanimir Varbanov wrote:
> Bjorn, thanks for the comments!
> 
> On 12/16/2015 11:53 PM, Bjorn Helgaas wrote:
> > On Thu, Dec 03, 2015 at 03:35:22PM +0200, Stanimir Varbanov wrote:
> >> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> >>
> >> The PCIe driver reuse the Designware common code for host
> >> and MSI initialization, and also program the Qualcomm
> >> application specific registers.
> >>
> >> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  MAINTAINERS                  |    7 +
> >>  drivers/pci/host/Kconfig     |   10 +
> >>  drivers/pci/host/Makefile    |    1 +
> >>  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++
> > 
> >> +#define PCIE20_CAP				0x70
> >> +#define PCIE20_CAP_LINKCTRLSTATUS		(PCIE20_CAP + 0x10)
> >> +#define PCIE20_CAP_LINKCTRLSTATUS_LINK_UP	BIT(29)
> > 
> > This looks like it could be referring to a standard PCIe Capability;
> > could you use the existing PCI_EXP_LNKSTA and PCI_EXP_LNKSTA_DLLLA
> > symbols here?  And readw() instead of readl()?
> 
> Yes, that is possible but I still need to keep PCIE20_CAP capabilities
> offset.

Great, thanks!  I think that will help keep generic PCIe things from
looking like they're special implementation-specific things.

Bjorn
