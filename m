From: lftan@altera.com (Ley Foon Tan)
Date: Mon, 28 Dec 2015 14:56:15 +0800
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
In-Reply-To: <1450950330-28393-1-git-send-email-marex@denx.de>
References: <1450950330-28393-1-git-send-email-marex@denx.de>
Message-ID: <1451285775.2990.2.camel@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-12-24 at 10:45 +0100, Marek Vasut wrote:
> The example does not work on real hardware with the PCIe HIP [1].
> The problem is with incorrect "ranges" property in the example, so
> one cannot just copy-paste the example into his DT and expect this
> to work. This patches aligns the "ranges" in the example with the
> reference FPGA design.
Hi Marek

The original "ranges" is working for me. What error did you encounter?

Thanks.

> 
> [1] http://rocketboards.org/foswiki/view/Projects/PCIeRootPortWithMSI
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/altera-pcie.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> index 2951a6a..d2427c1 100644
> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> @@ -44,6 +44,6 @@ Example
>  			            <0 0 0 2 &pcie_0 2>,
>  			            <0 0 0 3 &pcie_0 3>,
>  			            <0 0 0 4 &pcie_0 4>;
> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> -			    0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> +		ranges = <0x82000000 0x00000000 0xc0000000 0xc0000000 0x00000000 0x10000000
> +			  0x82000000 0x00000000 0xd0000000 0xd0000000 0x00000000 0x10000000>;
>  	};
