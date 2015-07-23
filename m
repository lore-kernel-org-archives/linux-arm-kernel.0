From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Jul 2015 13:44:29 +0100
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <55B0E1AD.60409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/15 20:49, Stuart Yoder wrote:
> Catalin/Will,
> 
> This is not a patch mean to be applied, but a query about whether there
> is any reason to not enable 48-bit VA by default in the arm64 defconfig.
> 
> The Freescale LS2085A physical memory map requires 48-bit VA in Linux for the
> reasons mentioned in [1].
> 
> Based on the comment in [1] by Catalin, it seems that the intent
> is to turn this on by default.
> 
> Is there any issues anyone sees with a patch that does this:
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4e17e7e..5acf75d 100644
> @@ -47,6 +47,7 @@ CONFIG_ARCH_ZYNQMP=y
>  CONFIG_PCI=y
>  CONFIG_PCI_MSI=y
>  CONFIG_PCI_XGENE=y
> +CONFIG_ARM64_VA_BITS_48=y
>  CONFIG_SMP=y
>  CONFIG_PREEMPT=y
>  CONFIG_KSM=y
> 
> Thanks,
> Stuart
> 
> [1] https://www.marc.info/?l=linux-arm-kernel&m=140965303205473&w=1
> 

Is that still a requirement now that our idmap can use 4 levels (as part
of dd006da)?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
