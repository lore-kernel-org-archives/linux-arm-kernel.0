From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 10 Feb 2017 05:13:59 +0100
Subject: i.MX7 clock support broken
In-Reply-To: <AM4PR0401MB22602ECF28CCB7172B917EC2FF440@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20170207142225.zitac2r7g3kvowjw@pengutronix.de>
 <DB5PR04MB1431EB280E8B9BA929FF006D80420@DB5PR04MB1431.eurprd04.prod.outlook.com>
 <AM4PR0401MB22602ECF28CCB7172B917EC2FF440@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Message-ID: <20170210041359.GB2103@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The issue was caused by one patch submitted at 2017 Jan.31 :
> 
> commit cafe8df8b9bc9aa3dffa827c1a6757c6cd36f657
> Author: Mao Wenan <maowenan@huawei.com>
> Date:   Tue Jan 31 18:46:43 2017 -0800
> 
>     net: phy: Fix lack of reference count on PHY driver
> 
>     There is currently no reference count being held on the PHY driver,
>     which makes it possible to remove the PHY driver module while the PHY
>     state machine is running and polling the PHY. This could cause crashes
>     similar to this one to show up:
> 
>     ......
> 
>     Signed-off-by: Mao Wenan <maowenan@huawei.com>
>     [florian: rebase, rework commit message]
>     Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> I will submit one patch to fix it today.

No need, it has already been fixed.

   Andrew
