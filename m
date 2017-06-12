From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Jun 2017 11:00:03 -0500
Subject: [PATCH] PCI: imx6: add regulator support
In-Reply-To: <20170608080742.3910-1-quentin.schulz@free-electrons.com>
References: <20170608080742.3910-1-quentin.schulz@free-electrons.com>
Message-ID: <20170612160003.jrt4emvti3hmqiiw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 10:07:42AM +0200, Quentin Schulz wrote:
> Some boards might require to control a regulator to power the PCIe port.
> 
> This adds support for an optional regulator defined in Device Tree
> linked in the PCIe controller under `vpcie-supply`. If present, the
> regulator will be disabled and then enabled as part of the PCIe host
> initialization process and will be disabled when shutting down.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  4 +++
>  drivers/pci/dwc/pci-imx6.c                         | 34 +++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
