From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 1 Aug 2018 22:07:12 +0200
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
Message-ID: <20180801200712.GD19257@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> My intention was to proceed with probe if the clock is not found in the DT.
> If the clock is specified in the DT, make use of it.

You might want to look at what phy_optional_get() does.  If the phy
does not exist in DT, it does not return an error, but a NULL phy.
You can pass NULL to all the other calls generic phy_ calls. If there
is a real error, it returns it. That makes the driver code much
simpler.

You might want to consider adding clk_optional_get() and
devm_clk_optional_get().

	Andrew
