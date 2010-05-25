From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 25 May 2010 17:14:23 +0800
Subject: [PATCH 6/6] [ARM] pxa/cm-x2xx: encode IRQ number into .nr_irqs
In-Reply-To: <4BFB8C1C.5000408@compulab.co.il>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
	<1274682949-25915-7-git-send-email-eric.y.miao@gmail.com>
	<4BFA2BD1.5040005@compulab.co.il>
	<AANLkTildk7al5cPAGDIiCnDNM7xg0Bl587F5e7fIiqof@mail.gmail.com>
	<4BFB8C1C.5000408@compulab.co.il>
Message-ID: <AANLkTikOpWUTzBstbsPuwlbd2J2PaqQ8L1IIUbMLOa53@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 4:36 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Hi Eric,
>
> Eric Miao wrote:
>>
>> Should be in my irq_cleanup branch, test welcome
>
> works with the below patch on top your irq_cleanup branch:
>

Thanks Mike, looks like a fix. You mind if I merge this into the previous patch
with your Signed-off-by?

> -
> From: Mike Rapoport <mike@compulab.co.il>
> Date: Tue, 25 May 2010 11:28:08 +0300
> Subject: [PATCH] [ARM] it8152: update interrupts numbering to work with
> sparse irqs
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/include/asm/hardware/it8152.h | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardware/it8152.h
> b/arch/arm/include/asm/hardware/it8152.h
> index 6700c7f..b2f95c7 100644
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ b/arch/arm/include/asm/hardware/it8152.h
> @@ -75,7 +75,8 @@ extern unsigned long it8152_base_address;
> ? IT8152_PD_IRQ(1) ?USB (USBR)
> ? IT8152_PD_IRQ(0) ?Audio controller (ACR)
> ?*/
> -#define IT8152_IRQ(x) ? (IRQ_BOARD_END + (x))
> +#define IT8152_IRQ(x) ? (IRQ_BOARD_START + (x))
> +#define IT8152_LAST_IRQ ? ? ? ?(IRQ_BOARD_START + 40)
>
> ?/* IRQ-sources in 3 groups - local devices, LPC (serial), and external PCI
> */
> ?#define IT8152_LD_IRQ_COUNT ? ? 9
> --
> 1.6.4.4
>
>>> On May 24, 2010 3:34 PM, "Mike Rapoport" <mike@compulab.co.il
>>> <mailto:mike@compulab.co.il>> wrote:
>>>
>>> Hi Eric,
>>>
>>>
>>>
>>> Eric Miao wrote:
>>> >
>>> > Cc: Mike Rapoport <mike at compulab.co.il <mailto:mike@compulab.co.il>>
>>> > Signed-off-by: Eric Miao <eric.y.mi...
>>>
>>> Looks Ok to me. Do you have a tree I can pull to test your changes?
>>>
>>>
>>>
>>> > diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.h
>>> > b/arch/arm/mach-pxa/cm-x2xx-pci.h
>>> > index e24aad2.....
>>>
>>> Sincerely yours,
>>> Mike.
>>
>
>
> --
> Sincerely yours,
> Mike.
>
>
> From ec3ae629d9844ea5f6d7588ca7451377e640a960 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <mike@compulab.co.il>
> Date: Tue, 25 May 2010 11:28:08 +0300
> Subject: [PATCH] [ARM] it8152: update interrupts numbering to work with
> sparse irqs
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/include/asm/hardware/it8152.h | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardware/it8152.h
> b/arch/arm/include/asm/hardware/it8152.h
> index 6700c7f..b2f95c7 100644
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ b/arch/arm/include/asm/hardware/it8152.h
> @@ -75,7 +75,8 @@ extern unsigned long it8152_base_address;
> ? IT8152_PD_IRQ(1) ?USB (USBR)
> ? IT8152_PD_IRQ(0) ?Audio controller (ACR)
> ?*/
> -#define IT8152_IRQ(x) ? (IRQ_BOARD_END + (x))
> +#define IT8152_IRQ(x) ? (IRQ_BOARD_START + (x))
> +#define IT8152_LAST_IRQ ? ? ? ?(IRQ_BOARD_START + 40)
>
> ?/* IRQ-sources in 3 groups - local devices, LPC (serial), and external PCI
> */
> ?#define IT8152_LD_IRQ_COUNT ? ? 9
> --
> 1.6.4.4
>
>
>
