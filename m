From: bp@alien8.de (Borislav Petkov)
Date: Mon, 27 Nov 2017 14:12:22 +0100
Subject: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
In-Reply-To: <1510578490-14510-1-git-send-email-t-kristo@ti.com>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
Message-ID: <20171127131222.gr6pofces6fts3iv@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 03:08:10PM +0200, Tero Kristo wrote:
> TI Keystone and DRA7xx SoCs have support for EDAC on DDR3 memory that can
> correct one bit errors and detect two bit errors. Add EDAC driver for this
> feature which plugs into the generic kernel EDAC framework.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v3:
>  * dropped the atomic edac_id counter
>  * added _emif_get_id which calculates the emif ID based on the sorted
>    address order of all emif instances
>  * changed the order of irq allocation and edac_mc_add_mc() within probe
> 
> v2:
>  * fixed checkpatch errors
>  * improved error cleanup for failed probe
>  * converted to use edac_printk
>  * added MAINTAINERS entry
>  * dropped mutex and used atomic counter for ID
>  * ... and some minor cosmetic changes
>  
>  MAINTAINERS            |   6 +
>  drivers/edac/Kconfig   |   7 +
>  drivers/edac/Makefile  |   1 +
>  drivers/edac/ti_edac.c | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 354 insertions(+)
>  create mode 100644 drivers/edac/ti_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
