From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 17 Sep 2018 16:09:57 -0500
Subject: [PATCH -next] fsl/qe: Fix copy-paste error in
 ucc_get_tdm_sync_shift
In-Reply-To: <20180915111005.10028-1-yuehaibing@huawei.com>
References: <20180915111005.10028-1-yuehaibing@huawei.com>
Message-ID: <CADRPPNSQp78jioP8Eao3ku_vqYCddRTuz1sydskUiPWTfmSUGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2018 at 6:11 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> if 'mode' is COMM_DIR_TX, 'shift' should use TX_SYNC_SHIFT_BASE
>
> Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for submitting the patch, but there is already the same fix in
the queue from Zhao Qiang and Dan Carpenter.

> ---
>  drivers/soc/fsl/qe/ucc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index c646d87..681f7d4 100644
> --- a/drivers/soc/fsl/qe/ucc.c
> +++ b/drivers/soc/fsl/qe/ucc.c
> @@ -626,7 +626,7 @@ static u32 ucc_get_tdm_sync_shift(enum comm_dir mode, u32 tdm_num)
>  {
>         u32 shift;
>
> -       shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : RX_SYNC_SHIFT_BASE;
> +       shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : TX_SYNC_SHIFT_BASE;
>         shift -= tdm_num * 2;
>
>         return shift;
> --
> 1.8.3.1
>
>
