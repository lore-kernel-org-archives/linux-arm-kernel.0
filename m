From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 19:34:41 +0530
Subject: [RFC v2 03/18] memory: emif: Move EMIF related header file to
 include/linux/
In-Reply-To: <1356959231-17335-4-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-4-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC2779.8030507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> OMAP4 and AM33XX share the same EMIF controller IP. Although there
> are significant differences in the IP integration due to which
> AM33XX can't reuse the EMIF driver DVFS similar to OMAP4,
> it can definitely benefit by reusing the EMIF related macros
> defined in drivers/memory/emif.h.
>
> In the current OMAP PM framework the PM code resides under
> arch/arm/mach-omap2/. To enable reuse of the register defines move
> the emif header file to include/linux so that both the EMIF driver
> and the AM33XX PM code can benefit.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Aneesh V <aneesh@ti.com>
> ---
> v1->v2:
> 	This is a new patch in the series to enable code reuse
> 	between the EMIF driver and AM33XX PM code
>
>   drivers/memory/emif.c   |    2 +-
>   drivers/memory/emif.h   |  589 -----------------------------------------------
>   include/linux/ti_emif.h |  589 +++++++++++++++++++++++++++++++++++++++++++++++
You are just moving the file. So "git mv file1 flie2; and the git 
format-patch -C"
on committed patch should just generate few lines of patch.

> +/* DDR_PHY_CTRL_1 - EMIF4D5 */
> +#define DLL_HALF_DELAY_SHIFT_4D5			21
> +#define DLL_HALF_DELAY_MASK_4D5				(1 << 21)
> +#define READ_LATENCY_SHIFT_4D5				0
> +#define READ_LATENCY_MASK_4D5				(0x1f << 0)
> +
> +/* DDR_PHY_CTRL_1_SHDW */
> +#define DDR_PHY_CTRL_1_SHDW_SHIFT			5
> +#define DDR_PHY_CTRL_1_SHDW_MASK			(0x7ffffff << 5)
> +#define READ_LATENCY_SHDW_SHIFT				0
> +#define READ_LATENCY_SHDW_MASK				(0x1f << 0)
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * Structure containing shadow of important registers in EMIF
> + * The calculation function fills in this structure to be later used for
> + * initialisation and DVFS
> + */
> +struct emif_regs {
Are you using above struct. If not we can leave it in same place and
just move the register defines.

Regards
santosh
