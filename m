From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Jun 2014 12:50:19 -0700
Subject: [PATCH 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller
 driver
In-Reply-To: <1402600404-19214-2-git-send-email-galak@codeaurora.org>
References: <1402600404-19214-1-git-send-email-galak@codeaurora.org>
 <1402600404-19214-2-git-send-email-galak@codeaurora.org>
Message-ID: <539A047B.3010306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/14 12:13, Kumar Gala wrote:
> +static int qcom_ahci_probe(struct platform_device *pdev)
> +{
> +	struct ahci_host_priv *hpriv;
> +	struct clk *rxoob_clk;
> +	int rc;
> +
> +	hpriv = ahci_platform_get_resources(pdev);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	/* Try and set the rxoob clk to 100Mhz */
> +	rxoob_clk = of_clk_get_by_name(pdev->dev.of_node, "rxoob");

Any reason we can't use devm_clk_get() here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
