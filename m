From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:34:47 +0530
Subject: [PATCH v5 09/22] gpio/omap: cleanup omap1 related macros
In-Reply-To: <1312455893-14922-10-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-10-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53A56F.3050006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> mpuio_init() function is defined under #ifdefs. It is required only in case
> of MPUIO bank type and only when PM operations are supported by it.
> This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
> For all the other cases it is a dummy function. Hence clean up the same
> and remove all the OMAP SoC specific #ifdefs.
>
> bank_is_mpuio() is defined as a check to identify if the bank type is MPUIO.
> It is not required to define it separately as zero for OMAP2PLUS. Remove this.
>
> Signed-off-by: Charulatha V<charu@ti.com>

Looks good though it can be cleaned up in the patch where
'bank_is_mpuio()' introduced.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
