From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2016 10:09:17 -0600
Subject: [PATCH] coresight: etm4x: modify q_support type
In-Reply-To: <1460451517-171713-1-git-send-email-lipengcheng8@huawei.com>
References: <1460451517-171713-1-git-send-email-lipengcheng8@huawei.com>
Message-ID: <CANLsYkw=EHhGjr_NTBgvoui8Rxv2pFfNmz7im0h2v_diO-qarA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 April 2016 at 02:58, lipengcheng <lipengcheng8@huawei.com> wrote:
> Because this operation exceed the range of boolean, so we should
> modify q_support to unit32 bit.
> drvdata->q_support = BMVAL(etmidr0, 15, 16)
>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index c341002..305b29a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -330,7 +330,7 @@ struct etmv4_drvdata {
>         u32                             ccctlr;
>         bool                            trcbb;
>         u32                             bb_ctrl;
> -       bool                            q_support;
> +       u32                             q_support;

Unfortunately this patch doesn't apply on my side.  Please rebase on
my next tree [1], branch "next".

Thanks,
Mathieu

[1]. https://git.linaro.org/kernel/coresight.git


>         u32                             vinst_ctrl;
>         u32                             viiectlr;
>         u32                             vissctlr;
> --
> 1.8.3.2
>
