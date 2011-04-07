From: dima@android.com (Dima Zavin)
Date: Wed, 6 Apr 2011 23:28:37 -0700
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
In-Reply-To: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
References: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
Message-ID: <BANLkTimWFiKmvAi+9OeEsdZyP91599ibSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Dima Zavin <dima@android.com>

On Mon, Mar 7, 2011 at 4:08 PM, Murali Nalajala <mnalajal@codeaurora.org> wrote:
> Lets non-standard NAND drivers take advantage of known NAND
> chip information.
>
> The initial development of msm nand driver, driver uses the supported
> NAND devices information as a hardcoded table. Remove the existing
> hardcoded supported flash device table and read the flash device
> information from the flash id table which are part of the mtd subsystem.
>
> Signed-off-by: Dima Zavin <dima@android.com>
> Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> ---
> Changes in V2
> * Add more description to the commit text.
>
> ?drivers/mtd/nand/Kconfig | ? 10 +++++++---
> ?1 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index c895922..782275e 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -1,3 +1,10 @@
> +config MTD_NAND_IDS
> + ? ? ? tristate "Include chip ids for known NAND devices."
> + ? ? ? depends on MTD
> + ? ? ? help
> + ? ? ? ? Useful for NAND drivers that do not use the NAND subsystem but
> + ? ? ? ? still like to take advantage of the known chip information.
> +
> ?config MTD_NAND_ECC
> ? ? ? ?tristate
>
> @@ -123,9 +130,6 @@ config MTD_NAND_OMAP_PREFETCH_DMA
> ? ? ? ? or in DMA interrupt mode.
> ? ? ? ? Say y for DMA mode or MPU mode will be used
>
> -config MTD_NAND_IDS
> - ? ? ? tristate
> -
> ?config MTD_NAND_RICOH
> ? ? ? ?tristate "Ricoh xD card reader"
> ? ? ? ?default n
> --
> 1.7.1.1
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
