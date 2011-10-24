From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 24 Oct 2011 17:16:49 +0200
Subject: [PATCH V5 1/3] SDHCI: S3C: Use generic clock names for sdhci
	bus clock options
In-Reply-To: <1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
References: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
	<1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <4EA58161.30603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/11 12:28, Rajeshwari Shinde wrote:
> This patch modifies the driver to stop depending on the clock names
> being passed from the platform and switch over to bus clock lookup
> using generic clock names.
>
> Signed-off-by: Rajeshwari Shinde<rajeshwari.s@samsung.com>
> ---
>   drivers/mmc/host/sdhci-s3c.c |    6 ++----
>   1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 82709b6..a5fde87 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -435,14 +435,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>
>   	for (clks = 0, ptr = 0; ptr<  MAX_BUS_CLK; ptr++) {
>   		struct clk *clk;
> -		char *name = pdata->clocks[ptr];
> +		char name[14];
>
> -		if (name == NULL)
> -			continue;
> +		sprintf(name, "mmc_busclk.%d", ptr);
>
>   		clk = clk_get(dev, name);
>   		if (IS_ERR(clk)) {
> -			dev_err(dev, "failed to get clock %s\n", name);
>   			continue;
>   		}
>

Looks ok for me.

Chris, if you're ok on this, could you please add this in your tree for 
this merge window? or if you want, I will apply this to Samsung tree 
with other Rajeshwari's patches. I'm ok either...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
