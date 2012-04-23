From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 23 Apr 2012 11:26:13 +0800
Subject: [PATCH 4/5] ARM: mxs: do not add dma device by default
In-Reply-To: <20120423015953.GH26306@S2101-09.ap.freescale.net>
References: <1334753197-12032-1-git-send-email-b29396@freescale.com>
 <1334753197-12032-5-git-send-email-b29396@freescale.com>
 <20120423015953.GH26306@S2101-09.ap.freescale.net>
Message-ID: <20120423032612.GA24843@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 09:59:57AM +0800, Shawn Guo wrote:
> On Wed, Apr 18, 2012 at 08:46:36PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > This will cause conflict when dt is enabled.
> > So let each platform add dma devices respectively.
> > 
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Huang Shijie <b32955@freescale.com>
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  arch/arm/mach-mxs/devices-mx23.h                |    2 ++
> >  arch/arm/mach-mxs/devices-mx28.h                |    2 ++
> >  arch/arm/mach-mxs/devices/platform-dma.c        |    3 +--
> >  arch/arm/mach-mxs/include/mach/devices-common.h |    3 +++
> >  arch/arm/mach-mxs/mach-apx4devkit.c             |    1 +
> >  arch/arm/mach-mxs/mach-m28evk.c                 |    1 +
> >  arch/arm/mach-mxs/mach-mx23evk.c                |    1 +
> >  arch/arm/mach-mxs/mach-stmp378x_devb.c          |    1 +
> >  arch/arm/mach-mxs/mach-tx28.c                   |    1 +
> >  9 files changed, 13 insertions(+), 2 deletions(-)
> > 
> I think instead of asking every board file to add dma device
> explicitly, we probably need to do something similar to imx, having
> functions imx23_soc_init and imx28_soc_init which will only be called
> for non-dt boot, and adding devices like dma, gpio there.
> 
Yes, it's fine to me since gpio has the same issue.
Will revise the patch.

Regards
Dong Aisheng
