From: vipulkumar.samar@st.com (vipul kumar samar)
Date: Fri, 28 Sep 2012 17:20:41 +0530
Subject: [PATCH 2/3] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <1348831266-16721-3-git-send-email-ulf.hansson@stericsson.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <50658F11.5010405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ulf,

On 9/28/2012 4:51 PM, Ulf HANSSON wrote:
> From: Ulf Hansson<ulf.hansson@linaro.org>
>
> This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.
>
> Signed-off-by: Ulf Hansson<ulf.hansson@linaro.org>
> ---
>   drivers/spi/spi-pl022.c |    4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 3f2f36c..05cfb61e 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2188,9 +2188,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>   	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
>   	       adev->res.start, pl022->virtbase);
>
> -	pm_runtime_enable(dev);
> -	pm_runtime_resume(dev);
> -
>   	pl022->clk = clk_get(&adev->dev, NULL);
>   	if (IS_ERR(pl022->clk)) {
>   		status = PTR_ERR(pl022->clk);
> @@ -2303,7 +2300,6 @@ pl022_remove(struct amba_device *adev)
>   	clk_disable(pl022->clk);
>   	clk_unprepare(pl022->clk);
>   	clk_put(pl022->clk);
> -	pm_runtime_disable(&adev->dev);
>   	iounmap(pl022->virtbase);
>   	amba_release_regions(adev);
>   	tasklet_disable(&pl022->pump_transfers);

sorry..Now i got it you revert complete rumtime patch.

Regards
Vipul Samar
