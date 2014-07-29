From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 28 Jul 2014 22:31:49 -0700
Subject: [PATCH v3 06/15] drivers: clk: st: STiH407: Support for Flexgen
 Clocks
In-Reply-To: <1405437631-23623-7-git-send-email-gabriel.fernandez@linaro.org>
References: <1405437631-23623-1-git-send-email-gabriel.fernandez@linaro.org>
 <1405437631-23623-7-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140729053149.4906.84119@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gabriel FERNANDEZ (2014-07-15 08:20:22)
> +static const char ** __init flexgen_get_parents(struct device_node *np,
> +                                                      int *num_parents)
> +{
> +       const char **parents;
> +       int nparents, i;
> +
> +       nparents = of_count_phandle_with_args(np, "clocks", "#clock-cells");

FYI, of_clk_get_parent_count provides a nice wrapper around this. Maybe
you can update it some day? Not a blocking issue for this series.

Regards,
Mike
