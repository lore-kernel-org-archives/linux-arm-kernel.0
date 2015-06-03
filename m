From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 03 Jun 2015 21:12:28 +0200
Subject: [PATCH 2/7] Documentation: bindings: document the clocks for
 pxa3xx-nand
In-Reply-To: <1433266351-22587-3-git-send-email-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Tue, 2 Jun 2015 19:32:26 +0200")
References: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
 <1433266351-22587-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <87fv6861yb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine Tenart <antoine.tenart@free-electrons.com> writes:

> The pxa3xx nand driver requires at least one clock to probe correctly.
> A second one, named 'ecc' can be specified if needed. Add the
> corresponding documentation.
Is it mandatory, really ?
The code does :
	info->clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(info->clk)) {
		dev_err(&pdev->dev, "failed to get nand clock\n");
		return PTR_ERR(info->clk);
	}

info->clk can very well be NULL, can't it ?

Cheers.

--
Robert
