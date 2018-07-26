From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jul 2018 21:13:40 +0200
Subject: [PATCH 5/7] net: phy: Add support to configure clock in Broadcom
 iProc mdio mux
In-Reply-To: <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180726191340.GH10686@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -175,6 +198,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(md->base);
>  	}
>  
> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(md->core_clk)) {
> +		dev_info(&pdev->dev, "core_clk not specified\n");
> +		md->core_clk = NULL;
> +	}
> +

In the binding, you say the clock is optional. This is a rather strong
message for something which is optional. I think it would be better to
not output anything.

    Andrew
