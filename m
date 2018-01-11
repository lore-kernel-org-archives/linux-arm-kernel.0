From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jan 2018 17:36:29 +0100
Subject: [PATCH net-next v4 0/4] net: mvpp2: 1000BaseX and 2500BaseX
 support
In-Reply-To: <20180111.113203.1899608306187914852.davem@davemloft.net>
References: <20180110155808.3484-1-antoine.tenart@free-electrons.com>
 <20180111.112337.98385023847631863.davem@davemloft.net>
 <20180111.113203.1899608306187914852.davem@davemloft.net>
Message-ID: <20180111173629.5d682190@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 11 Jan 2018 11:32:03 -0500 (EST), David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 11 Jan 2018 11:23:37 -0500 (EST)
> 
> > From: Antoine Tenart <antoine.tenart@free-electrons.com>
> > Date: Wed, 10 Jan 2018 16:58:04 +0100
> >   
> >> This series adds 1000BaseX and 2500BaseX support to the Marvell PPv2
> >> driver. In order to use it, the 2.5 SGMII mode is added in the Marvell
> >> common PHY driver (cp110-comphy).  
> > 
> > Series applied, thank you.  
> 
> Actually, this introduced build warnings, I'm reverting.  Please fix this
> and repost.
> 
> Thank you.
> 
> drivers/net/ethernet/marvell/mvpp2.c: In function ?mvpp2_port_mii_gmac_configure_mode?:
> drivers/net/ethernet/marvell/mvpp2.c:4687:26: warning: suggest parentheses around comparison in operand of ?|? [-Wparentheses]
>   if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX |
>       ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is actually a very good warning: it should be a || and not |.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
