From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 5 Aug 2014 14:16:59 +0800
Subject: Suspend/resume broken on mx5/mx6 running 4.16
In-Reply-To: <9930f46074e04c90a58fa6b01e055ff2@BLUPR03MB373.namprd03.prod.outlook.com>
References: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
 <9930f46074e04c90a58fa6b01e055ff2@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <20140805061658.GG2167@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 02:06:18PM +0800, Duan Fugang-B38611 wrote:
> I use linux net tree cannot reproduce the issue like your log, but show another issue as below log:
> (imx6dl sabresd board, Nfs mount rootfs)
> 
> root at freescale ~$ uname -r
> 3.16.0-rc5-01146-gda388973d	

Fabio already bisect the issue down to commit a71e3c37960c (net: phy:
Set the driver when registering an MDIO bus device).  This commit
landed on mainline after v3.16-rc7, and that may be the reason you
do not see it on net tree (3.16.0-rc5-01146-gda388973d).

Shawn
