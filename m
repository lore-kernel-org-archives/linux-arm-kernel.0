From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 11:31:26 +0800
Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171210120718.15197-1-peng.fan@nxp.com>
References: <20171210120718.15197-1-peng.fan@nxp.com>
Message-ID: <20171226033125.GA4210@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 10, 2017 at 08:07:18PM +0800, Peng Fan wrote:
> Use outer_disable/resume for suspend/resume.
> With the two APIs used, code could be simplified and easy to extend
> to introduce l2c_write_sec for i.MX platforms when moving Linux Kernel
> runs in non-secure world.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  arch/arm/mach-imx/pm-imx6.c      |  2 ++
>  arch/arm/mach-imx/suspend-imx6.S | 24 ------------------------

I'm fine with the patch in general.  But this piece of code is running
on a few i.MX6 platforms, and I'm wondering on which SoCs you have
verified the change work fine.

Shawn
