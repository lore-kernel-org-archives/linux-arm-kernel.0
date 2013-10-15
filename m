From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 12:52:49 -0600
Subject: [PATCH v3 03/19] clk: tegra: common periph_clk_enb_refcnt and clks
In-Reply-To: <1381848794-11761-4-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D8F01.8010603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> This patch makes periph_clk_enb_refcnt a global array, dynamically allocated
> at boottime. It simplifies the macros somewhat and allows clocks common to
> several Tegra SoCs to be defined in a separate files. Also the clks array
> becomes global and dynamically allocated which allows the DT registration to
> be moved to a generic funcion.

> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c

> +struct clk ** __init tegra_clk_init(int num, int banks)
>  {
> +	if (banks > ARRAY_SIZE(periph_regs)) {
> +		WARN_ON(1);

I think that can just be:

	if (WARN_ON(banks > ARRAY_SIZE(periph_regs))) {
