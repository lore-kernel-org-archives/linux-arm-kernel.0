From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Fri, 10 Mar 2017 08:40:10 +0000
Subject: [PATCH 3/3] mmc: sdhci-st: remove unnecessary
 platform_set_drvdata() call
In-Reply-To: <20170310031733.812-4-jszhang@marvell.com>
References: <20170310031733.812-1-jszhang@marvell.com>
 <20170310031733.812-4-jszhang@marvell.com>
Message-ID: <7e8b38e3-16a3-b00d-b30b-e24aa0f9d85a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng

On 03/10/2017 04:17 AM, Jisheng Zhang wrote:
> sdhci_pltfm_init() has already set the platform drvdata for us, remove
> the unnecessary platform_set_drvdata() call.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/mmc/host/sdhci-st.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index ed92ce729dde..7fff6490855c 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -418,8 +418,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  		goto err_out;
>  	}
>
> -	platform_set_drvdata(pdev, host);
> -
>  	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
>
>  	dev_info(&pdev->dev, "SDHCI ST Initialised: Host Version: 0x%x Vendor Version 0x%x\n",
>

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
