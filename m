From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Feb 2017 15:12:44 +0100
Subject: [PATCH 1/2] arm64: dts: marvell: remove msi-parent from PCIe on
 Armada 3700
In-Reply-To: <1472744484-19132-2-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 1 Sep 2016 17:41:23 +0200")
References: <1472744484-19132-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472744484-19132-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <878tp7ee5f.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., sept. 01 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Following the switch of the Aardvark PCIe controller driver to the
> generic MSI support, the msi-parent property in the PCIe controller,
> pointing to itself is no longer needed: since the MSI irq domain is
> associated to the PCIe controller Device Tree node, this is sufficient
> for the interrupt resolution logic to work.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Please only apply once "pci: pci-aardvark: move to MSI handling using
> generic MSI support" is merged, or it will break MSI support on Armada
> 3700.

What is the status of this patch?
Can I remove it from my mailbox?

it seemed that "pci: pci-aardvark: move to MSI handling using generic
MSI support" was never merged.

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index c476253..e56a34a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -187,7 +187,6 @@
>  			bus-range = <0x00 0xff>;
>  			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  			#interrupt-cells = <1>;
> -			msi-parent = <&pcie0>;
>  			msi-controller;
>  			ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
>  				  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
