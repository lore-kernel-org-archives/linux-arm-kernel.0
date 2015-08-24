From: joe@perches.com (Joe Perches)
Date: Sun, 23 Aug 2015 19:29:19 -0700
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440383359.2670.15.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-24 at 11:18 +0900, Masahiro Yamada wrote:
> This commit adds support for UniPhier outer cache controller.
> All the UniPhier SoCs are equipped with the L2 cache, while the L3
> cache is currently only integrated on PH1-Pro5 SoC.

style trivia:

You might add and use
	#define pr_fmt(fmt) "uniphier: " fmt
before any other #include so all of the pr_<level>
uses are automatically prefixed.

> diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
[]
> +static int __init __uniphier_cache_init(void)
> +{
[]
> +	if (uniphier_outer_levels == 0) {
> +		ret = ret ?: -ENODEV;
> +		pr_err("uniphier: failed to initialize outer cache\n");

So this becomes:
		pr_err("failed to initialize outer cache\n");

> +int __init uniphier_cache_init(void)
> +{
[]
> +	pr_info("uniphier: enabled outer cache (%s)\n",
> +		uniphier_outer_levels >= 2 ? "L2 and L3" : "L2");

	pr_info("enabled outer cache (%s)\n",
		uniphier_outer_levels >= 2 ? "L2 and L3" : "L2");

etc...
