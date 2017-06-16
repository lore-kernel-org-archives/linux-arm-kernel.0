From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:05:02 +0200
Subject: [RFT PATCH v2 03/42] drivers: pci: host: ftpci100: convert IRQ
 masking to raw PCI config accessors
In-Reply-To: <20170608141342.2018-4-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-4-lorenzo.pieralisi@arm.com>
Message-ID: <CACRpkda-_zNf3E+we4fgGLJXhCOsKTHJ4m5Jj-hS3G05FaJ8_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 4:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Current ftpci100 driver host bridge controller driver requires struct
> pci_bus to be created in order to mask and clear IRQs using standard
> PCI bus config accessors.
>
> This struct pci_bus dependency is fictitious and burdens the driver
> with unneeded constraints (eg to use separate APIs to create and scan
> the root bus).
>
> Add PCI raw config space accessors to PCIe ftpci100 driver and remove the
> fictitious struct pci_bus dependency.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

This makes all kind of sense so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'm hoping to be able to pull in your branch on my board
tree and actually test it too. The semantic change is a bit
scary.

Yours,
Linus Walleij
