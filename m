From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Jun 2013 23:52:58 -0700
Subject: [RFC PATCH 13/50] ARM: at91: move at91rm9200 SoC to new at91 clk
 implem
In-Reply-To: <1370617863-18410-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370617863-18410-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130620065258.9136.63631@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2013-06-07 08:11:03)
> +static struct clk_lookup pioA_clk_lookup[] = {
> +       CLKDEV_INIT(NULL, "pioA_clk", NULL),
> +       CLKDEV_INIT(NULL, "pioA", NULL),
> +};

It would be great to get rid of this clkdev data from the kernel as
well. Have you looked into encoding the aliases into your DT bindings?

Or have you looked into using of_clk_get?

Regards,
Mike
