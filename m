From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 10:59:20 +0200
Subject: [PATCH 01/29] ARM: orion5x: fix target ID for crypto SRAM window
In-Reply-To: <1397400006-4315-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BA368.2040607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> In commit 4ca2c04085a1caa903e92a5fc0da25362150aac2 ('ARM: orion5x:
> Move to ID based window creation'), the mach-orion5x code was changed
> to use the new mvebu-mbus API. However, in the process, a mistake was
> made on the crypto SRAM window target ID: it should have been 0x9
> (verified in the datasheet) and not 0x0.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> ---
> This should be backported to stable all the way to v3.12.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/mach-orion5x/common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
> index f565f99..7548db2 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -21,7 +21,7 @@ struct mv_sata_platform_data;
>   #define ORION_MBUS_DEVBUS_BOOT_ATTR   0x0f
>   #define ORION_MBUS_DEVBUS_TARGET(cs)  0x01
>   #define ORION_MBUS_DEVBUS_ATTR(cs)    (~(1 << cs))
> -#define ORION_MBUS_SRAM_TARGET        0x00
> +#define ORION_MBUS_SRAM_TARGET        0x09
>   #define ORION_MBUS_SRAM_ATTR          0x00
>
>   /*
>
