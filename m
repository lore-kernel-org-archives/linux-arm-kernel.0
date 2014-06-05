From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 11:57:28 -0600
Subject: [PATCH v7 1/5] ARM: tegra: export apb dma readl/writel
In-Reply-To: <1401973754-19701-2-git-send-email-pdeschrijver@nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5390AF88.9050007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 07:09 AM, Peter De Schrijver wrote:
> Export APB DMA readl and writel. These are needed because we can't access
> the fuses directly on Tegra20 without potentially causing a system hang.
> Also have the APB DMA readl and writel return an error in case of a read
> failure instead of just returning zero or ignore write failures.

> diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h

> +int tegra_apb_readl_using_dma(unsigned long offset, u32 *value);
> +int tegra_apb_writel_using_dma(u32 value, unsigned long offset);

Hmm. I wonder why we're exporting those low-level internal functions
rather than the higher-level tegra_apb_readl()/writel() wrappers that
"clients" are supposed to be using.
