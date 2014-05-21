From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 May 2014 14:46:44 +0800
Subject: [PATCH] ARM: imx6: init enet MAC address
In-Reply-To: <9e30b11d922542fb851c09c46685599d@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1400566266-22746-1-git-send-email-b38611@freescale.com>
 <20140520090312.GH5858@pengutronix.de>
 <9e30b11d922542fb851c09c46685599d@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <20140521064642.GB25299@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:24:01PM +0800, Duan Fugang-B38611 wrote:
> >> +#define OCOTP_MACn(n)		(0x00000620 + (n) * 0x10)
> >> +#define IMX_MAX_ENET_NUM	2
> >> +void __init imx6_enet_mac_init(const char *compatible)
> >
> >static
> >
> The .fun() will be called for imx6sl, imx6sx(the latest chip) machine files.

Then, it shouldn't be put in mach-imx6q.c which will be built only when
CONFIG_SOC_IMX6Q is enabled.

Shawn
