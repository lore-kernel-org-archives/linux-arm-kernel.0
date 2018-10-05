From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 5 Oct 2018 15:54:03 +0200
Subject: [PATCH] mmc: meson-mx-sdio: mark expected switch fall-through
In-Reply-To: <20181005100903.GA32057@embeddedor.com>
References: <20181005100903.GA32057@embeddedor.com>
Message-ID: <CAPDyKFo6g9dHDBuL4FL2HW5DSAmwtbVKRFOcTAKxFkyQkDDQiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2018 at 12:09, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced the "fall-through:"
> comment with a proper "fall through", which is what GCC is
> expecting to find.
>
> Addresses-Coverity-ID: 1373880 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2cfec33..abe253c 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -294,7 +294,7 @@ static void meson_mx_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
>                 vdd = 0;
> -               /* fall-through: */
> +               /* fall through */
>         case MMC_POWER_UP:
>                 if (!IS_ERR(mmc->supply.vmmc)) {
>                         host->error = mmc_regulator_set_ocr(mmc,
> --
> 2.7.4
>
