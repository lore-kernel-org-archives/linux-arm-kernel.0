From: davem@davemloft.net (David Miller)
Date: Fri, 06 Dec 2013 16:26:33 -0500 (EST)
Subject: [PATCH 03/10] net: stmmac: Use platform data tied with
 compatible strings
In-Reply-To: <1386350983-13281-4-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-4-git-send-email-wens@csie.org>
Message-ID: <20131206.162633.125107323851595113.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>
Date: Sat,  7 Dec 2013 01:29:36 +0800

> +	device = of_match_device(stmmac_dt_ids, &pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
> +	if (device->data)
> +	    memcpy(plat, device->data, sizeof(*plat));
> +

Don't invent your own indentation using spaces, this memcpy()
call is not indented properly, it should be two TABs.
