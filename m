From: monstr@monstr.eu (Michal Simek)
Date: Wed, 02 Apr 2014 11:37:34 +0200
Subject: [PATCH 15/75] ARM: l2c: add and use L2C revision constants
In-Reply-To: <E1WTYVM-0005Ze-IW@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYVM-0005Ze-IW@rmk-PC.arm.linux.org.uk>
Message-ID: <533BDA5E.6080205@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 04:15 PM, Russell King wrote:
> The revision namespace is specific to the L2 cache part, so don't name
> these with generic identifiers, use a part specific identifier.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/hardware/cache-l2x0.h | 22 ++++++++++++++++------
>  arch/arm/mm/cache-l2x0.c                   | 10 +++++-----
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 6795ff743b3d..94fbcec216ae 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -68,14 +68,24 @@
>  /* Registers shifts and masks */
>  #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
>  #define L2X0_CACHE_ID_PART_L210		(1 << 6)
> +#define L2X0_CACHE_ID_PART_L220		(2 << 6)
>  #define L2X0_CACHE_ID_PART_L310		(3 << 6)
>  #define L2X0_CACHE_ID_RTL_MASK          0x3f
> -#define L2X0_CACHE_ID_RTL_R0P0          0x0
> -#define L2X0_CACHE_ID_RTL_R1P0          0x2
> -#define L2X0_CACHE_ID_RTL_R2P0          0x4
> -#define L2X0_CACHE_ID_RTL_R3P0          0x5
> -#define L2X0_CACHE_ID_RTL_R3P1          0x6
> -#define L2X0_CACHE_ID_RTL_R3P2          0x8
> +#define L210_CACHE_ID_RTL_R0P2_02	0x00
> +#define L210_CACHE_ID_RTL_R0P1		0x01
> +#define L210_CACHE_ID_RTL_R0P2_01	0x02
> +#define L210_CACHE_ID_RTL_R0P3		0x03
> +#define L210_CACHE_ID_RTL_R0P4		0x0b
> +#define L210_CACHE_ID_RTL_R0P5		0x0f
> +#define L220_CACHE_ID_RTL_R1P7_01REL0	0x06
> +#define L310_CACHE_ID_RTL_R0P0          0x00
> +#define L310_CACHE_ID_RTL_R1P0          0x02
> +#define L310_CACHE_ID_RTL_R2P0          0x04
> +#define L310_CACHE_ID_RTL_R3P0          0x05
> +#define L310_CACHE_ID_RTL_R3P1          0x06
> +#define L310_CACHE_ID_RTL_R3P1_50REL0	0x07
> +#define L310_CACHE_ID_RTL_R3P2          0x08
> +#define L310_CACHE_ID_RTL_R3P3		0x09

Will be good to also clear tabs and spaces usage here
(tabs or spaces not mixing both).

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/82150868/attachment.sig>
