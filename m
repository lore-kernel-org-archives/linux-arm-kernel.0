From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 16:17:02 -0600
Subject: [PATCH v8 0/6] efuse driver for Tegra
In-Reply-To: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
References: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <539A26DE.8050609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2014 09:36 AM, Peter De Schrijver wrote:
> This driver allows userspace to read the raw efuse data. Its userspace
> interface is modelled after the sunxi_sid driver which provides similar
> functionality for some Allwinner SoCs. It has been tested on
> Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
> Tegra124 (jetson TK1).

I think this series looks OK now. However, I noticed one change in
behaviour that I don't think is expected:

The current code/DTB print:
Tegra Revision: A01 SKU: 0 CPU Process: 0 Core Process: 0

However, applying these patches and booting yields:
Tegra Revision: A01 SKU: 0 CPU Process: 1 Core Process: 1
