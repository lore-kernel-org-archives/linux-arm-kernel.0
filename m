From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:02:13 +0200
Subject: [RFT PATCH v2 07/42] drivers: pci: host: ftpci100: Fix host
 bridge memory leakage
In-Reply-To: <20170608141342.2018-8-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-8-lorenzo.pieralisi@arm.com>
Message-ID: <CACRpkdZEV50hZ6kiHmg+=PjFPMHgb2CVFoMMsk1M0DG97sq7KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 4:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> When probing the PCI host controller driver, if an error condition
> is trigger the probe function code does not free memory allocated
> for the struct pci_host_bridge resulting in memory leakage.
>
> Move the struct pci_host_bridge allocation over to the respective
> devm interface to fix the issue.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
