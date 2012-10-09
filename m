From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 9 Oct 2012 22:44:40 +0530
Subject: [PATCH 01/11] fsmc/nand:FIX: Change the type for regs to void
 __iomem *
In-Reply-To: <c30a9228d4bff7dbedd5d011f84c79c324736452.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <c30a9228d4bff7dbedd5d011f84c79c324736452.1349778820.git.vipin.kumar@st.com>
Message-ID: <CAOh2x=neFZcdK16_3wHRPHURWDVgfyv2UvX44bSb0hLmvMjHqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 4:14 PM, Vipin Kumar <vipin.kumar@st.com> wrote:
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
> ---
>  drivers/mtd/nand/fsmc_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
> index 38d2624..e96d7d1 100644
> --- a/drivers/mtd/nand/fsmc_nand.c
> +++ b/drivers/mtd/nand/fsmc_nand.c
> @@ -361,7 +361,7 @@ static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>         struct nand_chip *this = mtd->priv;
>         struct fsmc_nand_data *host = container_of(mtd,
>                                         struct fsmc_nand_data, mtd);
> -       void *__iomem *regs = host->regs_va;
> +       void __iomem *regs = host->regs_va;

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
