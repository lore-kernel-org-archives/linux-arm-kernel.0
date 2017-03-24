From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 24 Mar 2017 08:46:43 +0100
Subject: [PATCH] mmc: sunxi: change controller error info to debug level
In-Reply-To: <20170316132903.61246-1-icenowy@aosc.xyz>
References: <20170316132903.61246-1-icenowy@aosc.xyz>
Message-ID: <CAPDyKFppqPjjXtAAcSynxMw-1Oc7W6ZMf=oJLzWwsnLUWCq5Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 March 2017 at 14:29, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> The controller's errors are usually normal (for example, for MMC or SDIO
> cards, some errors are expected to happen; and for boards without a
> dedicated card detect pin the error info will even flood console and
> hide other normal messages) and hard to understand.
>
> Change their print level to debug, thus it won't be shown to generic
> users.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

For some reason this change didn't enter the mmc patchtracker. However
I have picked it up for next anyway.

Thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6ffcd2838272..0391c62cc99f 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -489,7 +489,7 @@ static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *host)
>                                       cmd->opcode == SD_IO_RW_DIRECT))
>                 return;
>
> -       dev_err(mmc_dev(host->mmc),
> +       dev_dbg(mmc_dev(host->mmc),
>                 "smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n",
>                 host->mmc->index, cmd->opcode,
>                 data ? (data->flags & MMC_DATA_WRITE ? " WR" : " RD") : "",
> --
> 2.12.0
>
