From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Sep 2017 16:34:54 +0200
Subject: [PATCH] net: phy: Fix mask value write on gmii2rgmii converter
 speed register.
In-Reply-To: <1505373391-18697-1-git-send-email-fahad.kunnathadi@dexceldesigns.com>
References: <1505373391-18697-1-git-send-email-fahad.kunnathadi@dexceldesigns.com>
Message-ID: <20170914143454.GB27601@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 12:46:31PM +0530, Fahad Kunnathadi wrote:
> To clear Speed Selection in MDIO control register(0x10),
> ie, clear bits 6 and 13 to zero while keeping other bits same.
> Before AND operation,The Mask value has to be perform with bitwise NOT
> operation (ie, ~ operator)
> 
> This patch clears current speed selection before writing the
> new speed settings to gmii2rgmii converter

Hi Fahad

I expect you will find other issues with this driver. I pointed some
out at the time it is submitted, but the developers went quiet as soon
as it was accepted.

Anyway, please ensure David Miller <davem@davemloft.net> gets a copy.

The subject line should be:

[PATCH net] net: phy: Fix mask value write on gmii2rgmii converter speed register.

and include a fixes tag:

Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
