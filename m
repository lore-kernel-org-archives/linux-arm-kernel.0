From: bp@alien8.de (Borislav Petkov)
Date: Mon, 24 Sep 2018 11:22:26 +0200
Subject: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
In-Reply-To: <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180924092226.GA20187@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:55:02PM +0530, Manish Narani wrote:
> Add macro defines for ZynqMP DDR controller. These macros will be used
> for ZyqnMP ECC operations.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index eb458e5..6bf7959 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -97,6 +97,174 @@
>  #define SCRUB_MODE_MASK		0x7
>  #define SCRUB_MODE_SECDED	0x4
>  
> +/* DDR ECC Quirks */
> +#define DDR_ECC_INTR_SUPPORT		BIT(0)
> +#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)

All those new additions are one column further to the left than the old
ones. Why?

Is there some significance here or can they all be vertically aligned?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
