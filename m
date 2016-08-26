From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2016 15:48:08 +0200
Subject: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
In-Reply-To: <AM3PR04MB13154FA0116D397AABD75E10F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
 <20160826111356.GM1041@n2100.armlinux.org.uk>
 <AM3PR04MB13154FA0116D397AABD75E10F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <201608261548.08227.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2016, Yongcai Huang wrote:
> > 
> > It's about time iMX folk learned that "imx*" is a SoC and not a CPU.
> > It should be "soc_is_imx7d()" because we're wanting to know whether the
> > SoC is an iMX7D.  The CPU is a _Cortex-A7_.
> 
> Agree, I will add a new patch in this patch set to replace all the cpu_is_xxx with
> Soc_is_xxx.

I recently did a patch to remove all the cpu_is_mx{1,2,3,5}* macros, which ended up
making the code simpler and more readable in most places. I think we can
do the same for the cpu_is_imx{6,7}* macros.

In this instance, the easy alternative is to have a separate smp_operation
structure for imx7d rather than using the same as imx6 and then figuring
out at runtime which one you have.

	Arnd
