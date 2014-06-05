From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Thu, 5 Jun 2014 20:01:22 +0300
Subject: [PATCH v7 3/5] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5390A262.50402@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/14 16:09, Peter De Schrijver wrote:
> +       dev_info(dev,
> +               "Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
> +               tegra_revision_name[sku_info->revision],
> +               sku_info->sku_id, sku_info->cpu_process_id,
> +               sku_info->core_process_id);

sku_info->sku_id doesn't seem to get initialized anywhere - with an 
older revision of this set I see SKU: 0 in place of what the L4T kernel 
prints (SKU: 0x81).

-- 
nvpublic
