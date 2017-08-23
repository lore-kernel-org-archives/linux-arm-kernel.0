From: stefanc@marvell.com (Stefan Chulski)
Date: Wed, 23 Aug 2017 13:30:47 +0000
Subject: [EXT] Re: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY
 address when connecting to the PHY
In-Reply-To: <20170823123424.GA28612@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
 <20170726160806.GF12049@lunn.ch> <20170728014905.GC24728@kwain>
 <20170728042153.GH18666@lunn.ch>
 <f6d8907b057241c7a72da0a0255cfd23@IL-EXCH01.marvell.com>
 <20170823123424.GA28612@lunn.ch>
Message-ID: <7dc117f56c284081b791bceb588a8aa1@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In order to safely read/write the PHY, you need to hold the PHY mutex.
> Unless the hardware is very smart, please don't enable this. Let the phylib and
> the appropriate PHY driver do the work.
> 
>        Andrew

Hi Andrew,

This feature work only for Out-of-Band Auto-Negotiation in SGMII Mode.
Current GoP(MAC) code configure SGMII In-band Auto-Negotiation performed by the PCS layer
without PHY polling.

Regards,
Stefan. 
