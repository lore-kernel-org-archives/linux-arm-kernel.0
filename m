From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 1 Aug 2018 23:55:11 +0200
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
 <20180801203846.GE19257@lunn.ch>
 <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
Message-ID: <20180801215511.GG19257@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> md->core_clk = devm_clk_get(&pdev->dev, NULL);
> if (md->core_clk == ERR_PTR(-ENOENT) || md->core_clk == ERR_PTR(-EINVAL)) {
> 	/* clock is optional, without it the default
> 	 * rate divider register values will be used
> 	 */
> 	md->core_clk = NULL;
> } else if (IS_ERR(md->core_clk)) {
> 	return PTR_ERR(md->core_clk);
> } else {
> 	rc = clk_prepare_enable(md->core_clk);
> 	...
> }

As Florian pointed out, the clk_ API is happy to take a NULL pointer
for a clock. So you don't need this last else.

    Andrew
