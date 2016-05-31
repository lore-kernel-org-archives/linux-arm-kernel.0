From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 May 2016 14:27:57 +0200
Subject: [PATCH 3/7] binding: mdio-mux: Add DT binding doc for Broadcom
 MDIO bus mutiplexer
In-Reply-To: <e002ac1b95d8ee4725f7315427f65fbf@mail.gmail.com>
References: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
 <1464592251-2688-4-git-send-email-pramod.kumar@broadcom.com>
 <20160530152426.GM6027@lunn.ch>
 <e002ac1b95d8ee4725f7315427f65fbf@mail.gmail.com>
Message-ID: <20160531122757.GD24402@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes. I agree. We will logical OR MII_ADDR_C45 into the address from PHY
> drivers. Is there any standard property exist for non-ethernet-phy DRIVERS
> to decide the whether PHY node support C45 or C22?

Why do you even need this in the device tree? If the driver needs to
access a register > 31, it knows it must use C45. If it is less than
32, it can use either C22 or C45.

    Andrew
