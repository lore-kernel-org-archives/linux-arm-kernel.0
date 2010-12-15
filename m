From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 15 Dec 2010 16:13:03 +0300
Subject: [PATCH 04/16] ARM: Dove: Remove PXA compatibility IRQ defines.
In-Reply-To: <20101215020306.GW15575@mail.wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020306.GW15575@mail.wantstofly.org>
Message-ID: <4D08BEDF.3060700@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-12-2010 5:03, Lennert Buytenhek wrote:

> These are not currently used anywhere, but when the relevant
> peripherals are enabled on the Dove port, the IRQ numbers should be
> passed into the drivers via platform device resources rather than
> having the drivers get them from platform headers directly.

> Signed-off-by: Lennert Buytenhek<buytenh@secretlab.ca>
[...]

> diff --git a/arch/arm/mach-dove/include/mach/irqs.h b/arch/arm/mach-dove/include/mach/irqs.h
> index 4668146..03d401d 100644
> --- a/arch/arm/mach-dove/include/mach/irqs.h
> +++ b/arch/arm/mach-dove/include/mach/irqs.h
> @@ -92,10 +92,5 @@
>
>   #define NR_IRQS			(IRQ_DOVE_PMU_START + NR_PMU_IRQS)
>
> -/* Required for compatability with PXA AC97 driver.	*/
> -#define IRQ_AC97		IRQ_DOVE_AC97
> -/* Required for compatability with PXA DMA driver.	*/
> -#define IRQ_DMA			IRQ_DOVE_PDMA
> -/* Required for compatability with PXA NAND driver 	*/
> -#define IRQ_NAND		IRQ_DOVE_NAND
> +

    The second new line is not needed here.

>   #endif

WBR, Sergei
