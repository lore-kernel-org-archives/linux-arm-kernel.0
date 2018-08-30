From: baicar.tyler@gmail.com (Tyler Baicar)
Date: Thu, 30 Aug 2018 15:18:04 -0400
Subject: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
References: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
Message-ID: <CABo9ajCui0y9HMBzgKWeNtrbu4de+mLh=d9Qdkyo4zhU9az6hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On Thu, Aug 30, 2018 at 2:37 PM, Fan Wu <wufan@codeaurora.org> wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
>
> Signed-off-by: Fan Wu <wufan@codeaurora.org>

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..949f603 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,6 +81,20 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>                 (*num_dimm)++;
>  }
>
> +static int get_dimm_smbios_index(u16 handle)
> +{
> +       struct mem_ctl_info *mci;
> +       int i;
> +
> +       mci = ghes_pvt->mci;
> +

Minor nit: you could define and set mci in the same line to save some
space here.

Otherwise this patch looks good to me.

Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
