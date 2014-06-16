From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 16:14:34 -0600
Subject: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
Message-ID: <539F6C4A.2030005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This adds support for the integrated AHCI-compliant Serial ATA
> controller present on the NVIDIA Tegra124 system-on-chip.

> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c

> +static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)

> +	/* Pad calibration */
> +
> +	ret = tegra_fuse_readl(0x224, &val);
> +	if (ret) {
> +		dev_err(&tegra->pdev->dev,
> +			"failed to read sata calibration fuse: %d\n", ret);
> +		return ret;
> +	}
> +
> +	calib = tegra124_pad_calibration[val];

Shouldn't val be range-checked before blindly using it?
