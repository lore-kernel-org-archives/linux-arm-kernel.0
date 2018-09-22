From: bp@alien8.de (Borislav Petkov)
Date: Sat, 22 Sep 2018 18:37:44 +0200
Subject: [PATCH v5] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1537322340-1860-1-git-send-email-wufan@codeaurora.org>
References: <1537322340-1860-1-git-send-email-wufan@codeaurora.org>
Message-ID: <20180922163744.GC26797@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 01:59:00AM +0000, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: Toshi Kani <toshi.kani@hpe.com>
> ---
> 
> Changes from v4:
> Changes from v3:
> * Updated Reviewed-by list
> 
> Changes from v2:
> * Fixed coding style glitch
> * Added Tested-by/Reviewed-by
> 
> Changes from v1:
> *  Changed the new function name to get_dimm_smbios_index
> *  Removed unnecessary checks inside get_dimm_smbios_index
> *  Reverted the change of the DMI handle print
> *  Updated commit message
> 
> ---
>  drivers/edac/ghes_edac.c | 23 +++++++++++++++++++++++
>  include/linux/edac.h     |  2 ++
>  2 files changed, 25 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
