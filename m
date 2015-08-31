From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 31 Aug 2015 14:04:23 +0200
Subject: [PATCH 02/11] x86, pci: Clean up comment about buggy MMIO config
 space access for AMD Fam10h CPUs.
In-Reply-To: <1432644564-24746-3-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55E442C7.7060509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.05.2015 14:49, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> - fix typo
> - improve explanation
> - add reference to the related document
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>   arch/x86/include/asm/pci_x86.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 164e3f8..eddf8f0 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -154,10 +154,13 @@ extern struct list_head pci_mmcfg_list;
>
>   /*
>    * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
> - * on their northbrige except through the * %eax register. As such, you MUST
> - * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
> + * on their northbridge except through the * %eax register. As such, you MUST
> + * NOT use normal IOMEM accesses, you need to only use the magic mmio_config_*
>    * accessor functions.
> - * In fact just use pci_config_*, nothing else please.
> + *
> + * Please refer to the following doc:
> + * "BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors",
> + * rev. 3.48, sec 2.11.1, "MMIO Configuration Coding Requirements".
>    */
>   static inline unsigned char mmio_config_readb(void __iomem *pos)
>   {
>

Hi Bjorn,

Can you please consider to pick up this one patch?

Regards,
Tomasz
