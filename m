From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 3 Jan 2011 23:43:00 +0800
Subject: [PATCH] [ARM] it8152: add IT8152_LAST_IRQ definition to fix build
	error
In-Reply-To: <1293606386-17388-1-git-send-email-mike@compulab.co.il>
References: <1293606386-17388-1-git-send-email-mike@compulab.co.il>
Message-ID: <AANLkTinBj7o0BCk6cv0D1d53dhLj=Uon-=NjTVw2Dd1x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 3:06 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> The commit 6ac6b817f3f4c23c5febd960d8deb343e13af5f3 (ARM: pxa: encode
> IRQ number into .nr_irqs) removed definition of ITE_LAST_IRQ which
> caused the following build error:
>
> CC ? ? ?arch/arm/common/it8152.o
> arch/arm/common/it8152.c: In function 'it8152_init_irq':
> arch/arm/common/it8152.c:86: error: 'IT8152_LAST_IRQ' undeclared (first use in this function)
> arch/arm/common/it8152.c:86: error: (Each undeclared identifier is reported only once
> arch/arm/common/it8152.c:86: error: for each function it appears in.)
> make[2]: *** [arch/arm/common/it8152.o] Error 1
>
> Defining the IT8152_LAST_IRQ in the arch/arm/include/hardware/it8152.c
> fixes the build.
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Applied.

> ---
> ?arch/arm/include/asm/hardware/it8152.h | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
> index 21fa272..b2f95c7 100644
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ b/arch/arm/include/asm/hardware/it8152.h
> @@ -76,6 +76,7 @@ extern unsigned long it8152_base_address;
> ? IT8152_PD_IRQ(0) ?Audio controller (ACR)
> ?*/
> ?#define IT8152_IRQ(x) ? (IRQ_BOARD_START + (x))
> +#define IT8152_LAST_IRQ ? ? ? ?(IRQ_BOARD_START + 40)
>
> ?/* IRQ-sources in 3 groups - local devices, LPC (serial), and external PCI */
> ?#define IT8152_LD_IRQ_COUNT ? ? 9
> --
> 1.6.4.4
>
>
