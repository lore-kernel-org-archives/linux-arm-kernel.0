From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 13:01:27 -0600
Subject: [PATCH v5 0/5] efuse driver for Tegra
In-Reply-To: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53878407.3050409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 06:54 AM, Peter De Schrijver wrote:
> This driver allows userspace to read the raw efuse data. Its userspace
> interface is modelled after the sunxi_sid driver which provides similar
> functionality for some Allwinner SoCs. It has been tested on
> Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
> Tegra124 (jetson TK1).

> Changes since v4:
> 
> * Provide fallback to hardcoded 0x70000800 in case the apbmisc DT node is
>   missing. This is exactly what the current code does and prevents a system
>   crash in that case due to an invalid memory access by tegra_read_chipid()

Wouldn't it be better to simply return an error?
