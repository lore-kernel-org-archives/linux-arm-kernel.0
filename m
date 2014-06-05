From: robherring2@gmail.com (Rob Herring)
Date: Thu, 5 Jun 2014 07:18:10 -0500
Subject: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
Message-ID: <CAL_JsqLh7kqnufNaWKdOEFb=m2mViFX4kTGMHOKmHuTAVMr+fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 6:32 AM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> This adds support for the integrated AHCI-compliant Serial ATA
> controller present on the NVIDIA Tegra124 system-on-chip.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

[...]

> +static int tegra_ahci_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *match;
> +       struct ahci_host_priv *hpriv;
> +       struct tegra_ahci_priv *tegra;
> +       int ret;
> +
> +       match = of_match_device(tegra_ahci_of_match, &pdev->dev);

This is not needed.

> +       if (!match)
> +               return -EINVAL;
> +
