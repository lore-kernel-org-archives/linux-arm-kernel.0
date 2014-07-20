From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Sun, 20 Jul 2014 08:06:38 +0000
Subject: FEC driver hangs hardware on i.MX6SX
In-Reply-To: <20140720025732.GF8537@dragon>
References: <20140720025732.GF8537@dragon>
Message-ID: <11d5e68443c446eaa43def6c3e14aad4@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn,

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at freescale.com]
>Sent: Sunday, July 20, 2014 10:58 AM
>To: Duan Fugang-B38611
>Cc: Li Frank-B20596; David S. Miller; Guo Shawn-R65073;
>netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: FEC driver hangs hardware on i.MX6SX
>
>Hi Fugang,
>
>Your commit e8fcfcd5684a (net: fec: optimize the clock management to save
>power) landed on mainline with v3.16-rc1.  It causes a hardware hang on
>i.MX6SX, if the rootfs is not on NFS but something else like MMC.
>
>I think the cause is that PTP is still accessing registers after FEC
>driver calls fec_enet_clk_enable(ndev, false) to disable FEC clocks.
>Can you please try to provide a fix for this regression soon?
>

Yes, you analyze is right. We had the related patch on internal trees since imx6sx bringup.
I will try to move the patch to upstream.

Thanks,
Andy
