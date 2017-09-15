From: fahad.kunnathadi@dexceldesigns.com (Fahad Kunnathadi)
Date: Fri, 15 Sep 2017 12:46:25 +0530 (IST)
Subject: [PATCH] net: phy: Fix mask value write on gmii2rgmii converter
 speed register.
In-Reply-To: <20170914143454.GB27601@lunn.ch>
References: <1505373391-18697-1-git-send-email-fahad.kunnathadi@dexceldesigns.com>
 <20170914143454.GB27601@lunn.ch>
Message-ID: <597180344.2790975.1505459785154.JavaMail.zimbra@dexceldesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Thank you for review and comments.

I will review this driver code with any review comments before, and update you if I could find any..

Best Regards
Fahad K  

----- Original Message -----
From: "Andrew Lunn" <andrew@lunn.ch>
To: "Fahad Kunnathadi" <fahad.kunnathadi@dexceldesigns.com>
Cc: "f fainelli" <f.fainelli@gmail.com>, netdev at vger.kernel.org, "Michal Simek" <michal.simek@xilinx.com>, linux-kernel at vger.kernel.org, "soren brinkmann" <soren.brinkmann@xilinx.com>, linux-arm-kernel at lists.infradead.org
Sent: Thursday, September 14, 2017 8:04:54 PM
Subject: Re: [PATCH] net: phy: Fix mask value write on gmii2rgmii converter speed register.

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
