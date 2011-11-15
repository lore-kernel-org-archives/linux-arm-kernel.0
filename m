From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Nov 2011 21:01:50 +0000
Subject: [PATCH] ARM: NUC900: add and change some device clk definitions.
In-Reply-To: <4EC25D72.4070909@gmail.com>
References: <4EC25D72.4070909@gmail.com>
Message-ID: <201111152101.51000.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 November 2011, Wan ZongShun wrote:
> This patch is to modify usb, audio and add i2c clk setting in cpu.c.
> Also, add DMA, FMI definition to nuc900_iodesc, since I will use them
> in the corresponding driver.
> 
> ---
>  arch/arm/mach-w90x900/cpu.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
> index 0a235e5..6eeadfc 100644
> --- a/arch/arm/mach-w90x900/cpu.c
> +++ b/arch/arm/mach-w90x900/cpu.c
> @@ -46,6 +46,8 @@ static struct map_desc nuc900_iodesc[] __initdata = {
>  	IODESC_ENT(TIMER),
>  	IODESC_ENT(EBI),
>  	IODESC_ENT(GPIO),
> +	IODESC_ENT(DMA),
> +	IODESC_ENT(FMI),
>  };

Can you change the driver to instead use ioremap with the device resources?
I think that would be much preferred. The two main uses of map_desc are
for devices that you need very early and in order to get larger than 4k
TLB entries. Neither of these seem to apply here.

	Arnd
