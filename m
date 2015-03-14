From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 22:33:19 +0100
Subject: [PATCH 10/10] clk: zx: add zx296702 clock support
In-Reply-To: <1426333785-3952-11-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-11-git-send-email-jun.nie@linaro.org>
Message-ID: <4949442.aoJHGEdoV2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 March 2015 19:49:45 Jun Nie wrote:
> +
> +static void __init zx296702_clocks_init(struct device_node *np)
> +{
> +       struct device_node *node;
> +       int i;
> +
> +       topcrm_base = of_iomap(np, 0);
> +       WARN_ON(!topcrm_base);
> +
> +       node = of_find_compatible_node(NULL, NULL, "zte,zx296702-lsp0crpm");
> +       lsp0crpm_base = of_iomap(node, 0);
> +       WARN_ON(!lsp0crpm_base);
> +
> +       node = of_find_compatible_node(NULL, NULL, "zte,zx296702-lsp1crpm");
> +       lsp1crpm_base = of_iomap(node, 0);
> +       WARN_ON(!lsp1crpm_base);
> +

Could you make this three separate clock controllers instead?

	Arnd
