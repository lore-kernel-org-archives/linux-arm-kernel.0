From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 11 Jun 2014 15:47:31 +0300
Subject: [PATCH v7 3/5] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53984FE3.6010509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/14 16:09, Peter De Schrijver wrote:
...
> +int tegra_fuse_readl(u32 offset, u32 *val)
> +{
> +       if (!fuse_readl)
> +               return -ENXIO;
> +
> +       *val = fuse_readl(offset);
> +
> +       return 0;
> +}
> +

-EPROBE_DEFER would be a better error value, so that drivers can work 
even if they are initially probed before the fuse driver. Of course, if 
the fuse initialization is moved into machine init then this is a non-issue.
