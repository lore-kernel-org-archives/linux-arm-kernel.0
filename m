From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 19 Jun 2015 15:32:39 -0700
Subject: [PATCH v3 2/2] mfd: flexcom: add a driver for Atmel Flexible
 Serial Communication Unit
In-Reply-To: <4b10b4bf7824134dfc91c5e4f25de3086163bba7.1434703451.git.cyrille.pitchen@atmel.com>
References: <cover.1434703451.git.cyrille.pitchen@atmel.com>
 <4b10b4bf7824134dfc91c5e4f25de3086163bba7.1434703451.git.cyrille.pitchen@atmel.com>
Message-ID: <20150619223239.GA24540@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

On Fri, Jun 19, 2015 at 10:49:35AM +0200, Cyrille Pitchen wrote:
> +
> +	clk_prepare_enable(clk);

I believe you need to have error handling here, not because it will
actually fail but to handle deferrals.

> +	version = readl(map + FX_VERSION);
> +	writel(mr, map + FX_MR);
> +	clk_disable_unprepare(clk);
> +
> +	dev_info(&pdev->dev, "version: %#x, mode: %s\n", version, mode);
> +
> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +}

Thanks.

-- 
Dmitry
