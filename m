From: sashal@kernel.org (Sasha Levin)
Date: Sun, 03 Aug 2014 09:16:25 -0400
Subject: [PATCH] ARM: PCI: Use PCI_CLASS_* defines for PCI class
In-Reply-To: <1406904671-19197-1-git-send-email-lisovy@gmail.com>
References: <1406904671-19197-1-git-send-email-lisovy@gmail.com>
Message-ID: <53DE3629.2020706@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 10:51 AM, Rostislav Lisovy wrote:
> Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
> ---
>  arch/arm/kernel/bios32.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..e511ad1 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -255,10 +255,9 @@ static void pci_fixup_it8152(struct pci_dev *dev)
>  {
>  	int i;
>  	/* fixup for ITE 8152 devices */
> -	/* FIXME: add defines for class 0x68000 and 0x80103 */
>  	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
> -	    dev->class == 0x68000 ||
> -	    dev->class == 0x80103) {
> +	    dev->class == (PCI_CLASS_BRIDGE_OTHER << 8) ||
> +	    dev->class == ((PCI_CLASS_SYSTEM_DMA << 8) | 0x03)) {
>  		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  			dev->resource[i].start = 0;
>  			dev->resource[i].end   = 0;
> 

Care to explain how your new code is equivalent to the old one?


Thanks,
Sasha
